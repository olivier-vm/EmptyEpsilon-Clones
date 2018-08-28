#include <time.h>

//We need a really fast float to string conversion. dtoa from milo does this very well.
#include "dtoa/dtoa_milo.h"

#include "gameStateLogger.h"
#include "gameGlobalInfo.h"
#include "spaceObjects/spaceObject.h"
#include "spaceObjects/asteroid.h"
#include "spaceObjects/mine.h"
#include "spaceObjects/blackHole.h"
#include "spaceObjects/nebula.h"
#include "spaceObjects/spaceship.h"

class JSONGenerator
{
public:
    JSONGenerator(char*& ptr)
    : ptr(ptr), first(true)
    {
        *ptr++ = '{';
    }
    
    ~JSONGenerator()
    {
        *ptr++ = '}';
    }
    
    template<typename T> void write(const char* key, const T& value)
    {
        if (!first)
            *ptr++ = ',';
        *ptr++ = '"';
        while(*key)
            *ptr++ = *key++;
        *ptr++ = '"';
        *ptr++ = ':';
        first = false;
        writeValue(value);
    }
    JSONGenerator createDict(const char* key)
    {
        if (!first)
            *ptr++ = ',';
        *ptr++ = '"';
        while(*key)
            *ptr++ = *key++;
        *ptr++ = '"';
        *ptr++ = ':';
        first = false;
        return JSONGenerator(ptr);
    }
    void startArray(const char* key)
    {
        if (!first)
            *ptr++ = ',';
        *ptr++ = '"';
        while(*key)
            *ptr++ = *key++;
        *ptr++ = '"';
        *ptr++ = ':';
        *ptr++ = '[';
        first = false;
        array_first = true;
    }
    JSONGenerator arrayCreateDict()
    {
        if (!array_first)
            *ptr++ = ',';
        array_first = false;
        return JSONGenerator(ptr);
    }
    template<typename T> void arrayWrite(const T& value)
    {
        if (!array_first)
            *ptr++ = ',';
        array_first = false;
        writeValue(value);
    }
    void endArray()
    {
        *ptr++ = ']';
        first = false;
        array_first = true;
    }
private:
    void writeValue(bool b)
    {
        const char* c = "false";
        if (b) c = "true";
        while(*c)
            *ptr++ = *c++;
    }
    void writeValue(int i) { ptr += sprintf(ptr, "%d", i); }
    void writeValue(float _f) { dtoa_milo(_f, ptr); ptr += strlen(ptr); }
    void writeValue(const char* value)
    { /*ptr += sprintf(ptr, "\"%s\"", value);*/ 
        *ptr++ = '"';
        while(*value)
            *ptr++ = *value++;
        *ptr++ = '"';
    }
    void writeValue(const string& value)
    {
        const char* str = value.c_str();
        *ptr++ = '"';
        while(*str)
            *ptr++ = *str++;
        *ptr++ = '"';
    }

    char*& ptr;
    bool first, array_first;
};

GameStateLogger::GameStateLogger()
{
    log_file = nullptr;
    logging_interval = 1.0;
    logging_delay = 0.0;
}

GameStateLogger::~GameStateLogger()
{
    stop();
}

void GameStateLogger::start()
{
    time_t rawtime;
    char filename_buffer[128];

    rawtime = time(nullptr);
    strftime(filename_buffer, sizeof(filename_buffer), "logs/game_log_%d-%m-%Y_%H.%M.%S.txt", localtime(&rawtime));
    log_file = fopen(filename_buffer, "wt");
    if (log_file)
        LOG(INFO) << "Opened game state log: " << filename_buffer;
    else
        LOG(WARNING) << "Failed to open game state log file: " << filename_buffer;
    start_time = engine->getElapsedTime();
}

void GameStateLogger::stop()
{
    if (log_file)
    {
        fclose(log_file);
        log_file = nullptr;
    }
}

void GameStateLogger::update(float delta)
{
    if (!log_file || delta == 0.0)
        return;
    
    logging_delay -= delta;
    if (logging_delay > 0.0)
        return;
    logging_delay = logging_interval;
    
    logGameState();
}

/* Write the state log entry. All entries are in json format.
   The state entry looke like:
    {
        "type": "state",
        "time": game time passed sinds start of logging,
        "new_static": [ list of object entries that are not likely to change, and only send once ],
        "objects": [ list of updated objects, this can include objects that have been created by new_static before ],
        "del_static": [ list of ids that have been added with "new_static" in a previous entry, but have been destroyed now ]
    }
*/
void GameStateLogger::logGameState()
{
    static char log_line_buffer[1024*1024*10];
    char* ptr = log_line_buffer;
    
    {
        JSONGenerator json(ptr);
        json.write("type", "state");
        json.write("time", engine->getElapsedTime() - start_time);
        json.startArray("new_static");
        foreach(SpaceObject, obj, space_object_list)
        {
            if (isStatic(obj) && static_objects.find(obj->getMultiplayerId()) == static_objects.end())
            {
                static_objects[obj->getMultiplayerId()] = obj->getPosition();
                JSONGenerator entry = json.arrayCreateDict();
                writeObjectEntry(entry, obj);
                
                if ((unsigned int)(ptr - log_line_buffer) > sizeof(log_line_buffer) / 2)
                {
                    fwrite(log_line_buffer, 1, ptr - log_line_buffer, log_file);
                    ptr = log_line_buffer;
                }
            }
        }
        json.endArray();
        std::vector<int> del_list;
        for(auto it : static_objects)
        {
            if (!game_server->getObjectById(it.first))
            {
                del_list.push_back(it.first);
            }
        }
        json.startArray("del_static");
        for(int id : del_list)
        {
            json.arrayWrite(id);
            static_objects.erase(id);
        }
        json.endArray();
        
        json.startArray("objects");
        foreach(SpaceObject, obj, space_object_list)
        {
            if (static_objects.find(obj->getMultiplayerId()) != static_objects.end())
            {
                if (static_objects[obj->getMultiplayerId()] == obj->getPosition())
                    continue;
            }
            JSONGenerator entry = json.arrayCreateDict();
            writeObjectEntry(entry, obj);

            if ((unsigned int)(ptr - log_line_buffer) > sizeof(log_line_buffer) / 2)
            {
                fwrite(log_line_buffer, 1, ptr - log_line_buffer, log_file);
                ptr = log_line_buffer;
            }
        }
        json.endArray();
    }
    
    *ptr++ = '\n';
    *ptr = '\0';
    fwrite(log_line_buffer, 1, ptr - log_line_buffer, log_file);
}

bool GameStateLogger::isStatic(P<SpaceObject> obj)
{
    if (P<Asteroid>(obj))
        return true;
    if (P<VisualAsteroid>(obj))
        return true;
    if (P<BlackHole>(obj))
        return true;
    if (P<Nebula>(obj))
        return true;
    if (P<Mine>(obj))
        return true;
    return false;
}

void GameStateLogger::writeObjectEntry(JSONGenerator& json, P<SpaceObject> obj)
{
    json.write("type", obj->getMultiplayerClassIdentifier());
    json.write("id", obj->getMultiplayerId());
    json.startArray("position");
    json.arrayWrite(obj->getPosition().x);
    json.arrayWrite(obj->getPosition().y);
    json.endArray();
    json.write("rotation", obj->getRotation());
    P<SpaceShip> ship = obj;
    if (ship)
    {
        writeShipEntry(json, ship);
    }else{
        P<SpaceStation> station = obj;
        if (station)
        {
            writeStationEntry(json, station);
        }
    }
}


void GameStateLogger::writeShipEntry(JSONGenerator& json, P<SpaceShip> ship)
{
    bool has_LASER_weapons = false;
    
    json.write("callsign", ship->getCallSign());
    json.write("faction", ship->getFaction());
    json.write("ship_type", ship->type_name);
    json.write("energy_level", ship->energy_level);
    json.write("hull", ship->hull_strength);
    if (ship->target_id > -1)
        json.write("target", ship->target_id);
    if (ship->docking_state != DS_NotDocking && ship->docking_target)
    {
        if (ship->docking_state == DS_Docking)
            json.write("docking", ship->docking_target->getMultiplayerId());
        if (ship->docking_state == DS_Docked)
            json.write("docked", ship->docking_target->getMultiplayerId());
    }
    if (ship->shield_count > 0)
    {
        if (gameGlobalInfo->use_LASER_shield_frequencies)
            json.write("shield_frequency", ship->shield_frequency);
        json.startArray("shields");
        for(int n=0; n<ship->shield_count; n++)
            json.arrayWrite(ship->shield_level[n]);
        json.endArray();
    }
    if (ship->weapon_tube_count > 0)
    {
        JSONGenerator missiles = json.createDict("missiles");
        for(int n=0; n<MW_Count; n++)
        {
            if (ship->weapon_storage[n] > 0)
            {
                missiles.write(getMissileWeaponName(EMissileWeapons(n)).c_str(), ship->weapon_storage[n]);
            }
        }
    }
    if (ship->weapon_tube_count > 0)
    {
        json.startArray("tubes");
        for(int n=0; n<ship->weapon_tube_count; n++)
        {
            JSONGenerator tube = json.arrayCreateDict();
            if (ship->weapon_tube[n].isEmpty())
            {
                tube.write("state", "empty");
            }
            else if (ship->weapon_tube[n].isLoaded())
            {
                tube.write("state", "loaded");
                tube.write("type", getMissileWeaponName(ship->weapon_tube[n].getLoadType()).c_str());
            }
            else if (ship->weapon_tube[n].isLoading())
            {
                tube.write("state", "loading");
                tube.write("type", getMissileWeaponName(ship->weapon_tube[n].getLoadType()).c_str());
                tube.write("progress", ship->weapon_tube[n].getLoadProgress());
            }
            else if (ship->weapon_tube[n].isUnloading())
            {
                tube.write("state", "unloading");
                tube.write("type", getMissileWeaponName(ship->weapon_tube[n].getLoadType()).c_str());
                tube.write("progress", ship->weapon_tube[n].getUnloadProgress());
            }
            else if (ship->weapon_tube[n].isFiring())
            {
                tube.write("state", "firing");
                tube.write("type", getMissileWeaponName(ship->weapon_tube[n].getLoadType()).c_str());
                //int fire_count;
            }
        }
        json.endArray();
    }
    {
        JSONGenerator systems = json.createDict("systems");
        for(int n=0; n<SYS_COUNT; n++)
        {
            if (ship->hasSystem(ESystem(n)))
            {
                JSONGenerator system = systems.createDict(getSystemName(ESystem(n)).c_str());
                system.write("health", ship->systems[n].health);
                system.write("power_level", ship->systems[n].power_level);
                system.write("power_request", ship->systems[n].power_request);
                system.write("heat", ship->systems[n].heat_level);
                system.write("coolant_level", ship->systems[n].coolant_level);
                system.write("coolant_request", ship->systems[n].coolant_request);
            }
        }
    }
    {
        JSONGenerator input = json.createDict("input");
        input.write("rotation", ship->target_rotation);
        input.write("impulse", ship->impulse_request);
        if (ship->has_RLS_drive)
            input.write("RLS", ship->RLS_request);
        if (ship->combat_maneuver_boost_speed > 0)
            input.write("combat_maneuver_boost", ship->combat_maneuver_boost_request);
        if (ship->combat_maneuver_strafe_speed > 0)
            input.write("combat_maneuver_strafe", ship->combat_maneuver_strafe_request);
    }
    {
        JSONGenerator output = json.createDict("output");
        output.write("impulse", ship->current_impulse);
        if (ship->has_RLS_drive)
            output.write("RLS", ship->current_RLS);
        if (ship->combat_maneuver_boost_speed > 0 || ship->combat_maneuver_strafe_speed > 0)
            output.write("combat_maneuver_charge", ship->combat_maneuver_charge);
        if (ship->combat_maneuver_boost_speed > 0)
            output.write("combat_maneuver_boost", ship->combat_maneuver_boost_active);
        if (ship->combat_maneuver_strafe_speed > 0)
            output.write("combat_maneuver_strafe", ship->combat_maneuver_strafe_active);
        if (ship->has_WARP_drive)
        {
            JSONGenerator WARP = output.createDict("WARP");
            if (ship->WARP_delay > 0)
            {
                WARP.write("distance", ship->WARP_distance);
                WARP.write("delay", ship->WARP_delay);
            }else{
                WARP.write("charge", ship->WARP_drive_charge);
            }
        }
    }
    {
        JSONGenerator config = json.createDict("config");
        config.write("turn_speed", ship->turn_speed);
        config.write("impulse_speed", ship->impulse_max_speed);
        config.write("impulse_acceleration", ship->impulse_acceleration);
        config.write("hull", ship->hull_max);
        if (ship->has_RLS_drive)
            config.write("RLS", ship->RLS_speed_per_RLS_level);
        if (ship->combat_maneuver_boost_speed > 0)
            config.write("combat_maneuver_boost", ship->combat_maneuver_boost_speed);
        if (ship->combat_maneuver_strafe_speed > 0)
            config.write("combat_maneuver_strafe", ship->combat_maneuver_strafe_speed);
        if (ship->has_WARP_drive)
            config.write("WARPdrive", true);
        if (ship->weapon_tube_count > 0)
        {
            JSONGenerator missiles = config.createDict("missiles");
            for(int n=0; n<MW_Count; n++)
            {
                if (ship->weapon_storage_max[n] > 0)
                {
                    missiles.write(getMissileWeaponName(EMissileWeapons(n)).c_str(), ship->weapon_storage_max[n]);
                }
            }
        }
        if (ship->weapon_tube_count > 0)
        {
            config.startArray("tubes");
            for(int n=0; n<ship->weapon_tube_count; n++)
            {
                JSONGenerator tube = config.arrayCreateDict();
                tube.write("direction", int(ship->weapon_tube[n].getDirection()));
                tube.write("load_time", int(ship->weapon_tube[n].getLoadTimeConfig()));
                //uint32_t type_allowed_mask;
            }
            config.endArray();
        }
        if (ship->shield_count > 0)
        {
            config.startArray("shields");
            for(int n=0; n<ship->shield_count; n++)
                json.arrayWrite(ship->shield_max[n]);
            config.endArray();
        }
        
        has_LASER_weapons = false;
        for(int n=0; n<max_LASER_weapons; n++)
        {
            if (ship->LASER_weapons[n].getRange() > 0)
            {
                if (!has_LASER_weapons)
                    config.startArray("LASERs");
                has_LASER_weapons = true;
                JSONGenerator LASER = config.arrayCreateDict();
                LASER.write("arc", ship->LASER_weapons[n].getArc());
                LASER.write("direction", ship->LASER_weapons[n].getDirection());
                LASER.write("range", ship->LASER_weapons[n].getRange());
                LASER.write("turret_arc", ship->LASER_weapons[n].getTurretArc());
                LASER.write("turret_direction", ship->LASER_weapons[n].getTurretDirection());
                LASER.write("damage", ship->LASER_weapons[n].getDamage());
                LASER.write("cycle_time", ship->LASER_weapons[n].getCycleTime());
            }
        }
        if (has_LASER_weapons)
        {
            config.endArray();
        }
    }
    if (has_LASER_weapons)
    {
        if (gameGlobalInfo->use_LASER_shield_frequencies)
            json.write("LASER_frequency", ship->LASER_frequency);
        if (ship->LASER_system_target != SYS_None)
            json.write("LASER_system_target", getSystemName(ship->LASER_system_target));
    }
}

void GameStateLogger::writeStationEntry(JSONGenerator& json, P<SpaceStation> station)
{
    json.write("callsign", station->getCallSign());
    json.write("faction", station->getFaction());
    json.write("station_type", station->type_name);
    json.write("hull", station->hull_strength);
    if (station->shield_count > 0)
    {
        json.startArray("shields");
        for(int n=0; n<station->shield_count; n++)
            json.arrayWrite(station->shield_level[n]);
        json.endArray();
    }
    {
        JSONGenerator config = json.createDict("config");
        config.write("hull", station->hull_max);
        if (station->shield_count > 0)
        {
            config.startArray("shields");
            for(int n=0; n<station->shield_count; n++)
                json.arrayWrite(station->shield_max[n]);
            config.endArray();
        }
    }
}
