#ifndef WARP_CONTROLS_H
#define WARP_CONTROLS_H

#include "gui/gui2_element.h"

class GuiKeyValueDisplay;
class GuiSlider;

class GuiRLSControls : public GuiElement
{
private:
    GuiKeyValueDisplay* label;
    GuiSlider* slider;
public:
    GuiRLSControls(GuiContainer* owner, string id);
    
    virtual void onDraw(sf::RenderTarget& window) override;
    virtual void onHotkey(const HotkeyResult& key) override;
};

#endif//WARP_CONTROLS_H
