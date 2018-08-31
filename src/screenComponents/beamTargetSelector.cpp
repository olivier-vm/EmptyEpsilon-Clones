#include "playerInfo.h"
#include "gameGlobalInfo.h"
#include "beamTargetSelector.h"

GuiLASERTargetSelector::GuiLASERTargetSelector(GuiContainer* owner, string id)
: GuiSelector(owner, id, [](int index, string value) { if (my_spaceship) my_spaceship->commandSetLASERSystemTarget(ESystem(index + SYS_None)); })
{
    addEntry("Coque", "-1");
    for(int n=0; n<SYS_COUNT; n++)
        addEntry(getSystemName(ESystem(n)), string(n));
    if (my_spaceship)
        setSelectionIndex(my_spaceship->LASER_system_target - SYS_None);
    if (!gameGlobalInfo->use_system_damage)
        hide();
}

void GuiLASERTargetSelector::onHotkey(const HotkeyResult& key)
{
    if (key.category == "WEAPONS" && my_spaceship && gameGlobalInfo->use_system_damage)
    {
        if (key.hotkey == "LASER_SUBSYSTEM_TARGET_NEXT")
        {
            if (getSelectionIndex() >= (int)entries.size() - 1)
                setSelectionIndex(0);
            else
                setSelectionIndex(getSelectionIndex() + 1);
            callback();
        }
        if (key.hotkey == "LASER_SUBSYSTEM_TARGET_PREV")
        {
            if (getSelectionIndex() <= 0)
                setSelectionIndex(entries.size() - 1);
            else
                setSelectionIndex(getSelectionIndex() - 1);
        }
    }
}
