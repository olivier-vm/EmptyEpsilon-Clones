#ifndef JUMP_CONTROLS_H
#define JUMP_CONTROLS_H

#include "gui/gui2_element.h"

class GuiKeyValueDisplay;
class GuiSlider;
class GuiButton;
class GuiProgressbar;

class GuiWARPControls : public GuiElement
{
private:
    GuiKeyValueDisplay* label;
    GuiSlider* slider;
    GuiButton* button;
    GuiProgressbar* charge_bar;
public:
    GuiWARPControls(GuiContainer* owner, string id);
    
    virtual void onDraw(sf::RenderTarget& window) override;
    virtual void onHotkey(const HotkeyResult& key) override;
};

#endif//JUMP_CONTROLS_H
