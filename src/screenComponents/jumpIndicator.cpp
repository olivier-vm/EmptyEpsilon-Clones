#include "playerInfo.h"
#include "spaceObjects/playerSpaceship.h"
#include "jumpIndicator.h"

#include "gui/gui2_panel.h"
#include "gui/gui2_label.h"

GuiWARPIndicator::GuiWARPIndicator(GuiContainer* owner)
: GuiElement(owner, "WARP_INDICATOR")
{
    setSize(GuiElement::GuiSizeMax, GuiElement::GuiSizeMax);

    box = new GuiPanel(owner, "WARP_BOX");
    box->setSize(800, 100)->setPosition(0, 200, ATopCenter);
    label = new GuiLabel(box, "WARP_LABEL", "WARP in: ", 50);
    label->setSize(GuiElement::GuiSizeMax, GuiElement::GuiSizeMax)->setPosition(0, 0, ACenter);
}

void GuiWARPIndicator::onDraw(sf::RenderTarget& window)
{
    if (my_spaceship && my_spaceship->WARP_delay > 0.0)
    {
        box->show();
        label->setText("WARP in: " + string(int(ceilf(my_spaceship->WARP_delay))));
    }else{
        box->hide();
    }
}
