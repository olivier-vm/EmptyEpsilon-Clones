#ifndef WARP_JAMMER_H
#define WARP_JAMMER_H

#include "spaceObject.h"

class RLSJammer : public SpaceObject
{
    static PVector<RLSJammer> jammer_list;

    float range;
    float hull;
public:
    RLSJammer();
    
    void setRange(float range) { this->range = range; }

    virtual void drawOnRadar(sf::RenderTarget& window, sf::Vector2f position, float scale, bool long_range) override;

    virtual bool canBeTargetedBy(P<SpaceObject> other)  override { return true; }
    virtual void takeDamage(float damage_amount, DamageInfo info) override;

    static bool isRLSJammed(sf::Vector2f position);
    static sf::Vector2f getFirstNoneJammedPosition(sf::Vector2f start, sf::Vector2f end);
    
    virtual string getExportLine() { return "RLSJammer():setFaction(\"" + getFaction() + "\"):setPosition(" + string(getPosition().x, 0) + ", " + string(getPosition().y, 0) + ")"; }
};

#endif//WARP_JAMMER_H
