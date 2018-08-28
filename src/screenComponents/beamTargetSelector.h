#ifndef BEAM_TARGET_SELECTOR_H
#define BEAM_TARGET_SELECTOR_H

#include "gui/gui2_selector.h"

class GuiLASERTargetSelector : public GuiSelector
{
public:
    GuiLASERTargetSelector(GuiContainer* owner, string id);
    
    virtual void onHotkey(const HotkeyResult& key) override;
};

#endif//BEAM_TARGET_SELECTOR_H
