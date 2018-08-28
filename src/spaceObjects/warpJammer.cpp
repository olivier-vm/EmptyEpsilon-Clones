#include "warpJammer.h"
#include "playerInfo.h"
#include "spaceObjects/playerSpaceship.h"
#include "explosionEffect.h"
#include "main.h"

#include "scriptInterface.h"
REGISTER_SCRIPT_SUBCLASS(RLSJammer, SpaceObject)
{
    REGISTER_SCRIPT_CLASS_FUNCTION(RLSJammer, setRange);
}

REGISTER_MULTIPLAYER_CLASS(RLSJammer, "RLSJammer");

PVector<RLSJammer> RLSJammer::jammer_list;

RLSJammer::RLSJammer()
: SpaceObject(100, "RLSJammer")
{
    range = 7000.0;
    hull = 50;

    jammer_list.push_back(this);
    setRadarSignatureInfo(0.05, 0.5, 0.0);

    registerMemberReplication(&range);
    
    model_info.setData("shield_generator");
}

void RLSJammer::drawOnRadar(sf::RenderTarget& window, sf::Vector2f position, float scale, bool long_range)
{
    sf::Sprite object_sprite;
    textureManager.setTexture(object_sprite, "RadarBlip.png");
    object_sprite.setRotation(getRotation());
    object_sprite.setPosition(position);
    if (my_spaceship && my_spaceship->isEnemy(this))
        object_sprite.setColor(sf::Color(255, 0, 0));
    else
        object_sprite.setColor(sf::Color(200, 150, 100));
    float size = 0.6;
    object_sprite.setScale(size, size);
    window.draw(object_sprite);

    if (long_range)
    {
        sf::CircleShape range_circle(range * scale);
        range_circle.setOrigin(range * scale, range * scale);
        range_circle.setPosition(position);
        range_circle.setFillColor(sf::Color::Transparent);
        range_circle.setOutlineColor(sf::Color(255, 255, 255, 64));
        range_circle.setOutlineThickness(2.0);
        window.draw(range_circle);
    }
}

void RLSJammer::takeDamage(float damage_amount, DamageInfo info)
{
    if (info.type == DT_EMP)
        return;
    hull -= damage_amount;
    if (hull <= 0)
    {
        P<ExplosionEffect> e = new ExplosionEffect();
        e->setSize(getRadius());
        e->setPosition(getPosition());
        destroy();
    }
}

bool RLSJammer::isRLSJammed(sf::Vector2f position)
{
    foreach(RLSJammer, wj, jammer_list)
    {
        if (wj->getPosition() - position < wj->range)
            return true;
    }
    return false;
}

sf::Vector2f RLSJammer::getFirstNoneJammedPosition(sf::Vector2f start, sf::Vector2f end)
{
    sf::Vector2f startEndDiff = end - start;
    float startEndLength = sf::length(startEndDiff);
    P<RLSJammer> first_jammer;
    float first_jammer_f = startEndLength;
    sf::Vector2f first_jammer_q;
    foreach(RLSJammer, wj, jammer_list)
    {
        float f = sf::dot(startEndDiff, wj->getPosition() - start) / startEndLength;
        if (f < 0.0)
            f = 0;
        sf::Vector2f q = start + startEndDiff / startEndLength * f;
        if ((q - wj->getPosition()) < wj->range)
        {
            if (!first_jammer || f < first_jammer_f)
            {
                first_jammer = wj;
                first_jammer_f = f;
                first_jammer_q = q;
            }
        }
    }
    if (!first_jammer)
        return end;

    float d = sf::length(first_jammer_q - first_jammer->getPosition());
    return first_jammer_q + sf::normalize(start - end) * sqrtf(first_jammer->range * first_jammer->range - d * d);
}
