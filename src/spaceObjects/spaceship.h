#ifndef SPACESHIP_H
#define SPACESHIP_H

#include "shipTemplateBasedObject.h"
#include "spaceStation.h"
#include "spaceshipParts/beamWeapon.h"
#include "spaceshipParts/weaponTube.h"

enum EMainScreenSetting
{
    MSS_Front = 0,
    MSS_Back,
    MSS_Left,
    MSS_Right,
    MSS_Target,
    MSS_Tactical,
    MSS_LongRange
};
template<> void convert<EMainScreenSetting>::param(lua_State* L, int& idx, EMainScreenSetting& mss);

enum EMainScreenOverlay
{
    MSO_HideComms = 0,
    MSO_ShowComms
};
template<> void convert<EMainScreenOverlay>::param(lua_State* L, int& idx, EMainScreenOverlay& mso);

enum EDockingState
{
    DS_NotDocking = 0,
    DS_Docking,
    DS_Docked
};

class ShipSystem
{
public:
    float health; //1.0-0.0, where 0.0 is fully broken.
    float power_level; //0.0-3.0, default 1.0
    float power_request;
    float heat_level; //0.0-1.0, system will damage at 1.0
    float coolant_level; //0.0-10.0
    float coolant_request;
    float hacked_level; //0.0-1.0

    float getHeatingDelta()
    {
        return powf(1.7, power_level - 1.0) - (1.01 + coolant_level * 0.1);
    }
};

class SpaceShip : public ShipTemplateBasedObject
{
public:
    constexpr static int max_frequency = 20;
    constexpr static float combat_maneuver_charge_time = 20.0f; /*< Amount of time it takes to fully charge the combat maneuver system */
    constexpr static float combat_maneuver_boost_max_time = 3.0f; /*< Amount of time we can boost with a fully charged combat maneuver system */
    constexpr static float combat_maneuver_strafe_max_time = 3.0f; /*< Amount of time we can strafe with a fully charged combat maneuver system */
    constexpr static float RLS_charge_time = 4.0f;
    constexpr static float RLS_decharge_time = 2.0f;
    constexpr static float WARP_drive_charge_time = 90.0;   /*<Total charge time for the WARP drive after a max range WARP */
    constexpr static float WARP_drive_energy_per_km_charge = 4.0f;
    constexpr static float WARP_drive_heat_per_WARP = 0.35;
    constexpr static float heat_per_combat_maneuver_boost = 0.2;
    constexpr static float heat_per_combat_maneuver_strafe = 0.2;
    constexpr static float heat_per_RLS = 0.02;
    constexpr static float unhack_time = 180.0f; //It takes this amount of time to go from 100% hacked to 0% hacked for systems.

    float energy_level;
    float max_energy_level;
    ShipSystem systems[SYS_COUNT];
    /*!
     *[input] Ship will try to aim to this rotation. (degrees)
     */
    float target_rotation;

    /*!
     * [input] Amount of impulse requested from the user (-1.0 to 1.0)
     */
    float impulse_request;

    /*!
     * [output] Amount of actual impulse from the engines (-1.0 to 1.0)
     */
    float current_impulse;

    /*!
     * [config] Speed of rotation, in deg/second
     */
    float turn_speed;

    /*!
     * [config] Max speed of the impulse engines, in m/s
     */
    float impulse_max_speed;

    /*!
     * [config] Impulse engine acceleration, in (m/s)/s
     */
    float impulse_acceleration;

    /*!
     * [config] True if we have a RLSdrive.
     */
    bool has_RLS_drive;

    /*!
     * [input] Level of RLS requested, from 0 to 4
     */
    int8_t RLS_request;

    /*!
     * [output] Current active RLS amount, from 0.0 to 4.0
     */
    float current_RLS;

    /*!
     * [config] Amount of speed per RLS level, in m/s
     */
    float RLS_speed_per_RLS_level;

    /*!
     * [output] How much charge there is in the combat maneuvering system (0.0-1.0)
     */
    float combat_maneuver_charge;
    /*!
     * [input] How much boost we want at this moment (0.0-1.0)
     */
    float combat_maneuver_boost_request;
    float combat_maneuver_boost_active;

    float combat_maneuver_strafe_request;
    float combat_maneuver_strafe_active;

    float combat_maneuver_boost_speed; /*< [config] Speed to indicate how fast we will fly forwards with a full boost */
    float combat_maneuver_strafe_speed; /*< [config] Speed to indicate how fast we will fly sideways with a full strafe */

    bool has_WARP_drive;      //[config]
    float WARP_drive_charge; //[output]
    float WARP_distance;     //[output]
    float WARP_delay;        //[output]
    float WARP_drive_min_distance; //[config]
    float WARP_drive_max_distance; //[config]
    float wormhole_alpha;    //Used for displaying the RLS-postprocessor

    int weapon_storage[MW_Count];
    int weapon_storage_max[MW_Count];
    int8_t weapon_tube_count;
    WeaponTube weapon_tube[max_weapon_tubes];

    /*!
     * [output] Frequency of LASER weapons
     */
    int LASER_frequency;
    ESystem LASER_system_target;
    LASERWeapon LASER_weapons[max_LASER_weapons];

    /**
     * Frequency setting of the shields.
     */
    int shield_frequency;

    /// MultiplayerObjectID of the targeted object, or -1 when no target is selected.
    int32_t target_id;

    EDockingState docking_state;
    P<SpaceObject> docking_target; //Server only
    sf::Vector2f docking_offset; //Server only

    SpaceShip(string multiplayerClassName, float multiplayer_significant_range=-1);

#if FEATURE_3D_RENDERING
    virtual void draw3DTransparent() override;
#endif
    /*!
     * Draw this ship on the radar.
     */
    virtual void drawOnRadar(sf::RenderTarget& window, sf::Vector2f position, float scale, bool long_range) override;
    virtual void drawOnGMRadar(sf::RenderTarget& window, sf::Vector2f position, float scale, bool long_range) override;

    virtual void update(float delta) override;
    virtual float getShieldRechargeRate(int shield_index) override;
    virtual float getShieldDamageFactor(DamageInfo& info, int shield_index) override;
    float getWARPDriveRechargeRate() { return Tween<float>::linear(getSystemEffectiveness(SYS_WARPDrive), 0.0, 1.0, -0.25, 1.0); }

    /*!
     * Check if the ship can be targeted.
     */
    virtual bool canBeTargetedBy(P<SpaceObject> other) override { return true; }

    /*!
     * didAnOffensiveAction is called whenever this ship does something offesive towards an other object
     * this can identify the ship as friend or foe.
     */
    void didAnOffensiveAction();

    /*!
     * Spaceship takes damage directly on hull.
     * This is used when shields are down or by weapons that ignore shields.
     * \param damage_amount Damage to be delt.
     * \param info Information about damage type (usefull for damage reduction, etc)
     */
    virtual void takeHullDamage(float damage_amount, DamageInfo& info) override;

    /*!
     * Spaceship is destroyed by damage.
     * \param info Information about damage type
     */
    virtual void destroyedByDamage(DamageInfo& info);

    /*!
     * WARP in current direction
     * \param distance Distance to WARP in meters)
     */
    virtual void executeWARP(float distance);

    /*!
     * Check if object can dock with this ship.
     * \param object Object that wants to dock.
     */
    virtual bool canBeDockedBy(P<SpaceObject> obj);

    virtual void collide(Collisionable* other, float force) override;

    /*!
     * Start the WARPing procedure.
     */
    void initializeWARP(float distance);

    /*!
     * Request to dock with target.
     */
    void requestDock(P<SpaceObject> target);

    /*!
     * Request undock with current docked object
     */
    void requestUndock();

    /*!
     * Abort the current dock request
     */
    void abortDock();

    /// Dummy virtual function to use energy. Only player ships currently model energy use.
    virtual bool useEnergy(float amount) { return true; }

    /// Dummy virtual function to add heat on a system. The player ship class has an actual implementation of this as only player ships model heat right now.
    virtual void addHeat(ESystem system, float amount) {}

    virtual bool canBeScannedBy(P<SpaceObject> other) override { return getScannedStateFor(other) != SS_FullScan; }
    virtual int scanningComplexity(P<SpaceObject> other) override;
    virtual int scanningChannelDepth(P<SpaceObject> other) override;
    virtual void scannedBy(P<SpaceObject> other) override;

    bool isFriendOrFoeIdentified();//[DEPRICATED]
    bool isFullyScanned();//[DEPRICATED]
    bool isFriendOrFoeIdentifiedBy(P<SpaceObject> other);
    bool isFullyScannedBy(P<SpaceObject> other);
    bool isFriendOrFoeIdentifiedByFaction(int faction_id);
    bool isFullyScannedByFaction(int faction_id);

    virtual bool canBeHackedBy(P<SpaceObject> other) override;
    virtual std::vector<std::pair<string, float> > getHackingTargets() override;
    virtual void hackFinished(P<SpaceObject> source, string target) override;

    /*!
     * Check if ship has certain system
     */
    bool hasSystem(ESystem system);

    /*!
     * Check effectiveness of system.
     * If system has more / less power or is damages, this can influence the effectiveness.
     * \return float 0. to 1.
     */
    float getSystemEffectiveness(ESystem system);

    virtual void applyTemplateValues();

    P<SpaceObject> getTarget();

    virtual std::unordered_map<string, string> getGMInfo();

    bool isDocked(P<SpaceObject> target) { return docking_state == DS_Docked && docking_target == target; }
    bool canStartDocking() { return current_RLS <= 0.0 && (!has_WARP_drive || WARP_delay <= 0.0); }
    int getWeaponStorage(EMissileWeapons weapon) { if (weapon == MW_None) return 0; return weapon_storage[weapon]; }
    int getWeaponStorageMax(EMissileWeapons weapon) { if (weapon == MW_None) return 0; return weapon_storage_max[weapon]; }
    void setWeaponStorage(EMissileWeapons weapon, int amount) { if (weapon == MW_None) return; weapon_storage[weapon] = amount; }
    void setWeaponStorageMax(EMissileWeapons weapon, int amount) { if (weapon == MW_None) return; weapon_storage_max[weapon] = amount; weapon_storage[weapon] = std::min(int(weapon_storage[weapon]), amount); }
    float getMaxEnergy() { return max_energy_level; }
    void setMaxEnergy(float amount) { if (amount > 0.0) { max_energy_level = amount;} }
    float getEnergy() { return energy_level; }
    void setEnergy(float amount) { if ( (amount > 0.0) && (amount <= max_energy_level)) { energy_level = amount; } }
    float getSystemHealth(ESystem system) { if (system >= SYS_COUNT) return 0.0; if (system <= SYS_None) return 0.0; return systems[system].health; }
    void setSystemHealth(ESystem system, float health) { if (system >= SYS_COUNT) return; if (system <= SYS_None) return; systems[system].health = std::min(1.0f, std::max(-1.0f, health)); }
    float getSystemHeat(ESystem system) { if (system >= SYS_COUNT) return 0.0; if (system <= SYS_None) return 0.0; return systems[system].heat_level; }
    void setSystemHeat(ESystem system, float heat) { if (system >= SYS_COUNT) return; if (system <= SYS_None) return; systems[system].heat_level = std::min(1.0f, std::max(0.0f, heat)); }
    float getSystemPower(ESystem system) { if (system >= SYS_COUNT) return 0.0; if (system <= SYS_None) return 0.0; return systems[system].power_level; }
    void setSystemPower(ESystem system, float power) { if (system >= SYS_COUNT) return; if (system <= SYS_None) return; systems[system].power_level = std::min(3.0f, std::max(0.0f, power)); }
    float getSystemCoolant(ESystem system) { if (system >= SYS_COUNT) return 0.0; if (system <= SYS_None) return 0.0; return systems[system].coolant_level; }
    void setSystemCoolant(ESystem system, float coolant) { if (system >= SYS_COUNT) return; if (system <= SYS_None) return; systems[system].coolant_level = std::min(1.0f, std::max(0.0f, coolant)); }
    float getImpulseMaxSpeed() { return impulse_max_speed; }
    void setImpulseMaxSpeed(float speed) { impulse_max_speed = speed; }
    float getRotationMaxSpeed() { return turn_speed; }
    void setRotationMaxSpeed(float speed) { turn_speed = speed; }
    void setCombatManeuver(float boost, float strafe) { combat_maneuver_boost_speed = boost; combat_maneuver_strafe_speed = strafe; }

    bool hasWARPDrive() { return has_WARP_drive; }
    void setWARPDrive(bool has_WARP) { has_WARP_drive = has_WARP; }
    void setWARPDriveRange(float min, float max) { WARP_drive_min_distance = min; WARP_drive_max_distance = max; }
    bool hasRLSDrive() { return has_RLS_drive; }
    void setRLSDrive(bool has_RLS)
    {
        has_RLS_drive = has_RLS;
        if (has_RLS_drive)
        {
            if (RLS_speed_per_RLS_level < 100)
                RLS_speed_per_RLS_level = 1000;
        }else{
            RLS_request = 0.0;
            RLS_speed_per_RLS_level = 0;
        }
    }

    float getLASERWeaponArc(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getArc(); }
    float getLASERWeaponDirection(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getDirection(); }
    float getLASERWeaponRange(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getRange(); }

    float getLASERWeaponTurretArc(int index) 
    {
        if (index < 0 || index >= max_LASER_weapons)
            return 0.0;
        return LASER_weapons[index].getTurretArc();
    }

    float getLASERWeaponTurretDirection(int index)
    {
        if (index < 0 || index >= max_LASER_weapons)
            return 0.0;
        return LASER_weapons[index].getTurretDirection();
    }

    float getLASERWeaponTurretRotationRate(int index)
    {
        if (index < 0 || index >= max_LASER_weapons)
            return 0.0;
        return LASER_weapons[index].getTurretRotationRate();
    }

    float getLASERWeaponCycleTime(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getCycleTime(); }
    float getLASERWeaponDamage(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getDamage(); }
    float getLASERWeaponEnergyPerFire(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getEnergyPerFire(); }
    float getLASERWeaponHeatPerFire(int index) { if (index < 0 || index >= max_LASER_weapons) return 0.0; return LASER_weapons[index].getHeatPerFire(); }

    int getShieldsFrequency(void){ return shield_frequency; }
    void setShieldsFrequency(float freq) { if ((freq > SpaceShip::max_frequency) || (freq < 0)) return; shield_frequency = freq;}

    void setLASERWeapon(int index, float arc, float direction, float range, float cycle_time, float damage)
    {
        if (index < 0 || index >= max_LASER_weapons)
            return;
        LASER_weapons[index].setArc(arc);
        LASER_weapons[index].setDirection(direction);
        LASER_weapons[index].setRange(range);
        LASER_weapons[index].setCycleTime(cycle_time);
        LASER_weapons[index].setDamage(damage);
    }

    void setLASERWeaponTurret(int index, float arc, float direction, float rotation_rate)
    {
        if (index < 0 || index >= max_LASER_weapons)
            return;
        LASER_weapons[index].setTurretArc(arc);
        LASER_weapons[index].setTurretDirection(direction);
        LASER_weapons[index].setTurretRotationRate(rotation_rate);
    }

    void setLASERWeaponTexture(int index, string texture)
    {
        if (index < 0 || index >= max_LASER_weapons)
            return;
        LASER_weapons[index].setLASERTexture(texture);
    }

    void setLASERWeaponEnergyPerFire(int index, float energy) { if (index < 0 || index >= max_LASER_weapons) return; return LASER_weapons[index].setEnergyPerFire(energy); }
    void setLASERWeaponHeatPerFire(int index, float heat) { if (index < 0 || index >= max_LASER_weapons) return; return LASER_weapons[index].setHeatPerFire(heat); }

    void setWeaponTubeCount(int amount);
    int getWeaponTubeCount();
    EMissileWeapons getWeaponTubeLoadType(int index);
    void weaponTubeAllowMissle(int index, EMissileWeapons type);
    void weaponTubeDisallowMissle(int index, EMissileWeapons type);
    void setWeaponTubeExclusiveFor(int index, EMissileWeapons type);
    void setWeaponTubeDirection(int index, float direction);

    void setRadarTrace(string trace) { radar_trace = trace; }

    void addBroadcast(int threshold, string message);

    //Return a string that can be appended to an object create function in the lua scripting.
    // This function is used in getScriptExport calls to adjust for tweaks done in the GM screen.
    string getScriptExportModificationsOnTemplate();
};

float frequencyVsFrequencyDamageFactor(int LASER_frequency, int shield_frequency);

string getMissileWeaponName(EMissileWeapons missile);
REGISTER_MULTIPLAYER_ENUM(EMissileWeapons);
REGISTER_MULTIPLAYER_ENUM(EWeaponTubeState);
REGISTER_MULTIPLAYER_ENUM(EMainScreenSetting);
REGISTER_MULTIPLAYER_ENUM(EMainScreenOverlay);
REGISTER_MULTIPLAYER_ENUM(EDockingState);
REGISTER_MULTIPLAYER_ENUM(EScannedState);

string frequencyToString(int frequency);

#ifdef _MSC_VER
// MFC: GCC does proper external template instantiation, VC++ doesn't.
#include "spaceship.hpp"
#endif

#endif//SPACESHIP_H
