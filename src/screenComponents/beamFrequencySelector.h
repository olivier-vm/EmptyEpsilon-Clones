#ifndef BEAM_FREQUENCY_SELECTOR_H
#define BEAM_FREQUENCY_SELECTOR_H

#include "gui/gui2_selector.h"

class GuiLASERFrequencySelector : public GuiSelector
{
public:
    GuiLASERFrequencySelector(GuiContainer* owner, string id);
    
    virtual void onHotkey(const HotkeyResult& key) override;
};

#endif//BEAM_FREQUENCY_SELECTOR_H
