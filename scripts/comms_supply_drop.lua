-- Name: Supply ship comms
-- Description: Stripped comms that do not allow any interaction. Used for transport ships.

function mainMenu()
	if player:isFriendly(comms_target) then
		setCommsMessage("Nous transportons des biens.");
		return true
	end
	if player:isEnemy(comms_target) then
		return false
	end
	setCommsMessage("Nous n'avons rien pour vous.\nBonne journee.");
end
mainMenu()
