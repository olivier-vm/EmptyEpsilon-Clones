#include "playerInfo.h"
#include "gameGlobalInfo.h"
#include "beamFrequencySelector.h"

GuiLASERFrequencySelector::GuiLASERFrequencySelector(GuiContainer* owner, string id)
: GuiSelector(owner, id, [](int index, string value) { if (my_spaceship) my_spaceship->commandSetLASERFrequency(index); })
{
    for(int n=0; n<=SpaceShip::max_frequency; n++)
        addEntry(frequencyToString(n), frequencyToString(n));
    if (my_spaceship)
        setSelectionIndex(my_spaceship->LASER_frequency);
    if (!gameGlobalInfo->use_LASER_shield_frequencies)
        hide();
}

void GuiLASERFrequencySelector::onHotkey(const HotkeyResult& key)
{
    if (key.category == "WEAPONS" && my_spaceship && gameGlobalInfo->use_LASER_shield_frequencies)
    {
        if (key.hotkey == "LASER_FREQUENCY_INCREASE")
        {
            if (getSelectionIndex() >= (int)entries.size() - 1)
                setSelectionIndex(0);
            else
                setSelectionIndex(getSelectionIndex() + 1);
            callback();
        }
        if (key.hotkey == "LASER_FREQUENCY_DECREASE")
        {
            if (getSelectionIndex() <= 0)
                setSelectionIndex(entries.size() - 1);
            else
                setSelectionIndex(getSelectionIndex() - 1);
        }
    }
}
