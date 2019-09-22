#ifndef BEAM_EFFECT_H
#define BEAM_EFFECT_H

#include "spaceObject.h"

class LASEREffect : public SpaceObject, public Updatable
{
    float lifetime;
    int32_t sourceId;
    int32_t target_id;
    sf::Vector3f sourceOffset;
    sf::Vector3f targetOffset;
    sf::Vector2f targetLocation;
    sf::Vector3f hitNormal;
public:
    string LASER_texture;
    string LASER_fire_sound;
    float LASER_fire_sound_power;
    LASEREffect();

#if FEATURE_3D_RENDERING
    virtual void draw3DTransparent();
#endif
    virtual void update(float delta);

    void setSource(P<SpaceObject> source, sf::Vector3f offset);
    void setTarget(P<SpaceObject> target, sf::Vector2f hitLocation);

    ///Set the texture used for this LASER. Options available by default take the form LASER_color.png
    void setTexture(string texture) {this->LASER_texture = texture;}
    ///Set the sound played when firing the LASER. Included laser sound is laser.wav
    void setLASERFireSound(string sound) {this->LASER_fire_sound = sound;}
    ///Control volume and pitch of firing sound
    void setLASERFireSoundPower(float power) {this->LASER_fire_sound_power = power;}
    ///Control Duration of the LASER. Default is 1 second
    void setDuration(float duration) {this->lifetime = duration;}
};

#endif//BEAM_EFFECT_H
