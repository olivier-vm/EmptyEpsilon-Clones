#ifndef BEAM_WEAPON_H
#define BEAM_WEAPON_H

#include "SFML/System/NonCopyable.hpp"
#include "stringImproved.h"
#include "spaceObjects/spaceObject.h"
class SpaceShip;

class LASERWeapon : public sf::NonCopyable
{
public:
    LASERWeapon();

    void fire(P<SpaceObject> target, ESystem system_target);

    void setParent(SpaceShip* parent);

    void setArc(float arc);
    float getArc();

    void setDirection(float direction);
    float getDirection();

    void setRange(float range);
    float getRange();

    void setTurretArc(float arc);
    float getTurretArc();

    void setTurretDirection(float direction);
    float getTurretDirection();

    void setTurretRotationRate(float rotation_rate);
    float getTurretRotationRate();

    void setCycleTime(float cycle_time);
    float getCycleTime();
    
    void setDamage(float damage);
    float getDamage();

    float getEnergyPerFire();
    void setEnergyPerFire(float energy);

    float getHeatPerFire();
    void setHeatPerFire(float heat);

    void setPosition(sf::Vector3f position);
    sf::Vector3f getPosition();
    
    void setLASERTexture(string LASER_texture);
    string getLASERTexture();

    float getCooldown();
    
    void update(float delta);
protected:
    sf::Vector3f position;//Visual position on the 3D model where this LASER is fired from.
    SpaceShip* parent; //The ship that this LASER weapon is attached to.

    //LASER configuration
    float arc;
    float direction;
    float range;
    float turret_arc;
    float turret_direction;
    float turret_rotation_rate;
    float cycle_time;
    float damage;//Server side only
    float energy_per_LASER_fire;//Server side only
    float heat_per_LASER_fire;//Server side only
    //LASER runtime state
    float cooldown;
    string LASER_texture;
};

#endif//BEAM_WEAPON_H
