#include "beamTemplate.h"

LASERTemplate::LASERTemplate()
{
    arc = 0;
    direction = 0;
    range = 0;
    turret_arc = 0;
    turret_direction = 0;
    turret_rotation_rate = 0;
    cycle_time = 0;
    damage = 0;
    beam_texture = "beam_orange.png";

    energy_per_LASER_fire = 3.0;
    heat_per_LASER_fire = 0.02;
}

string LASERTemplate::getLASERTexture()
{
    return LASER_texture;
}

void LASERTemplate::setLASERTexture(string texture)
{
    //TODO: Add some more inteligent input checking
    LASER_texture = texture;
}

float LASERTemplate::getDirection()
{
    return direction;
}

void LASERTemplate::setDirection(float direction)
{
    // Clamp values
    while(direction < 0)
        direction += 360;
    while(direction > 360)
        direction -= 360;
    this->direction = direction;
}

float LASERTemplate::getArc()
{
    return arc;
}

void LASERTemplate::setArc(float arc)
{
    while(arc < 0)
        arc += 360;
    while(arc > 360)
        arc -=360;
    this->arc = arc;
}

float LASERTemplate::getRange()
{
    return range;
}

void LASERTemplate::setRange(float range)
{
    if(range <= 0)
        this->range = 0.1;
    else
        this->range = range;
}

float LASERTemplate::getTurretDirection()
{
    return turret_direction;
}

void LASERTemplate::setTurretDirection(float direction)
{
    // Clamp values
    while(direction < 0)
        direction += 360;
    while(direction > 360)
        direction -= 360;
    this->turret_direction = direction;
}

float LASERTemplate::getTurretArc()
{
    return turret_arc;
}

void LASERTemplate::setTurretArc(float arc)
{
    while(arc < 0)
        arc += 360;
    while(arc > 360)
        arc -=360;
    this->turret_arc = arc;
}

float LASERTemplate::getTurretRotationRate()
{
    return turret_rotation_rate;
}

void LASERTemplate::setTurretRotationRate(float rotation_rate)
{
    if (rotation_rate < 0)
        this->turret_rotation_rate = 0.0;
    // 25 is an arbitrary limit. Values greater than 25.0 are nearly
    // instantaneous.
    else if (rotation_rate > 25.0)
        this->turret_rotation_rate = 25.0;
    else
        this->turret_rotation_rate = rotation_rate;
}

float LASERTemplate::getCycleTime()
{
    return cycle_time;
}

void LASERTemplate::setCycleTime(float cycle_time)
{
    if(cycle_time <= 0)
        this->cycle_time = 0.1;
    else
        this->cycle_time = cycle_time;
}

float LASERTemplate::getDamage()
{
    return damage;
}

void LASERTemplate::setDamage(float damage)
{
    if(damage < 0)
        this->damage = 0;
    else
        this->damage = damage;
}

float LASERTemplate::getEnergyPerFire()
{
    return energy_per_LASER_fire;
}

void LASERTemplate::setEnergyPerFire(float energy)
{
    energy_per_LASER_fire = energy;
}

float LASERTemplate::getHeatPerFire()
{
    return heat_per_LASER_fire;
}

void LASERTemplate::setHeatPerFire(float heat)
{
    heat_per_LASER_fire = heat;
}

LASERTemplate& LASERTemplate::operator=(const LASERTemplate& other)
{
    LASER_texture = other.LASER_texture;
    direction = other.direction;
    arc = other.arc;
    range = other.range;
    turret_direction = other.turret_direction;
    turret_arc = other.turret_arc;
    turret_arc = other.turret_rotation_rate;
    cycle_time = other.cycle_time;
    damage = other.damage;
    energy_per_LASER_fire = other.energy_per_LASER_fire;
    heat_per_LASER_fire = other.heat_per_LASER_fire;
    return *this;
}
