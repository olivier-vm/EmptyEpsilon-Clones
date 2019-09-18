#include "warpControls.h"
#include "playerInfo.h"
#include "spaceObjects/playerSpaceship.h"
#include "powerDamageIndicator.h"

#include "gui/gui2_slider.h"
#include "gui/gui2_keyvaluedisplay.h"

GuiRLSControls::GuiRLSControls(GuiContainer* owner, string id)
: GuiElement(owner, id)
{
    // Build RLS request slider.
    slider = new GuiSlider(this, id + "_SLIDER", 4.0, 0.0, 0.0, [this](float value) {
        // Round the slider value to an int.
        int RLS_level = value;

        // Send a RLS request command to our ship.
        if (my_spaceship)
            my_spaceship->commandRLS(RLS_level);

        // Set the slider value to the RLS level.
        slider->setValue(RLS_level);
    });
    slider->setPosition(0, 0, ATopLeft)->setSize(50, GuiElement::GuiSizeMax);

    // Snap the slider to integers up to 4.
    slider->addSnapValue(0.0, 0.5);
    slider->addSnapValue(1.0, 0.5);
    slider->addSnapValue(2.0, 0.5);
    slider->addSnapValue(3.0, 0.5);
    slider->addSnapValue(4.0, 0.5);

    if (my_spaceship)
    {
        // Set the slider's value to the current RLS request.
        slider->setValue(my_spaceship->RLS_request);
    }

    // Label the RLS slider.
    label = new GuiKeyValueDisplay(this, id + "_LABEL", 0.5, "RLS", "0.0");
    label->setTextSize(30)->setPosition(50, 0, ATopLeft)->setSize(40, GuiElement::GuiSizeMax);

    // Prep the alert overlay.
    (new GuiPowerDamageIndicator(this, id + "_DPI", SYS_RLS, ATopCenter))->setSize(50, GuiElement::GuiSizeMax);
}

void GuiRLSControls::onDraw(sf::RenderTarget& window)
{
    // Update the label with the current RLS factor.
    if (my_spaceship) {
        label->setValue(string(my_spaceship->current_RLS, 1));
        slider->setValue(my_spaceship->RLS_request);
    }
}

void GuiRLSControls::onHotkey(const HotkeyResult& key)
{
    // Handle hotkey input. RLS is a HELMS-category shortcut.
    if (key.category == "HELMS" && my_spaceship)
    {
        if (key.hotkey == "RLS_0")
        {
            my_spaceship->commandRLS(0);
            slider->setValue(0);
        }
        else if (key.hotkey == "RLS_1")
        {
            my_spaceship->commandRLS(1);
            slider->setValue(1);
        }
        else if (key.hotkey == "RLS_2")
        {
            my_spaceship->commandRLS(2);
            slider->setValue(2);
        }
        else if (key.hotkey == "RLS_3")
        {
            my_spaceship->commandRLS(3);
            slider->setValue(3);
        }
        else if (key.hotkey == "RLS_4")
        {
            my_spaceship->commandRLS(4);
            slider->setValue(4);
        }
    }
}
