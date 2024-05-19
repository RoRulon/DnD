#--------------------------------------------------
#Create-DnDAttackAction.ps1
#RoRulon
#V1.0 - 2024-05-19
#--------------------------------------------------

#--------------------------------------------------
<#Script prompts the user to enter the details of the attack, then outputs a string to the clipboard which can then be pasted into DNDBeyond.
This will allow the user to quickly make syntax correct strings that are compatible with the dice rolling on DNDBeyond

Improvements to be made:
- Add option for additional damage types
- Add option for ranged attacks
- Once a string is copied, allow a user to start the process again and make another in the same session
#>

#--------------------------------------------------
#Change Log
#1.0	2024-05-19 - First working version - Allows the creation of a single, one action attack (i.e. a Longsword, or Bite)
#--------------------------------------------------

#//////////////////////////////////////////////////

#--------------------------------------------------
#Script
#--------------------------------------------------

do {
	Write-Host "Please enter the values for the attack to generate the string"
	$AttackName = Read-Host "Enter the name of the attack"
	$ToHit = Read-Host "Enter the value of the to hit bonus (i.e. for +5 to hit, type 5)"
	$Range = Read-Host "Enter the range of the attack (i.e. for 10 ft. type 10)"
	$AverageDamage01 = Read-Host "Enter the average damage of the attack"
	$DiceNumber01 = Read-Host "Enter the number of damage die (i.e. for 4d6 + 5 type 4)"
	$DamageDice01 = Read-Host "Enter the number of sides of the damage die (i.e. for 4d6 + 5 type 6)"
	$Modifier01 = Read-Host "Enter the the modifier for the damage (i.e. if the damage is 4d6 + 5 type 5)"
	$TotalDamage01 = $Dicenumber01 + "d" + $DamageDice01 + "+" + $Modifier01
	$DamageType01 = Read-Host "Enter the damage type of the attack"
	$AddDamageType = Read-Host "Would you like to add another damage type? (Y/N)"
	
	if ($AddDamageType -eq "y") {
		Write-Host "Please enter the details of the secondary damage of the attack (i.e. if an attack does 5 (1d4 + 3) pircing damage plus 3 (1d6) psychic damage, this is where you input the details for the psychic damage"
		$AverageDamage02 = Read-Host "Enter the average secondary damage of the attack"
		$DiceNumber02 = Read-Host "Enter the number of secondary damage die (i.e. for 4d6 + 5 type 4)"
		$DamageDice02 = Read-Host "Enter the number of sides of the secondary damage die (i.e. for 4d6 + 5 type 6)"
		$Modifier02 = Read-Host "Enter the the modifier for the secondary damage (i.e. if the damage is 4d6 + 5 type 5). If this is a straight dice roll, put 0"
		if ($Modifier02 -eq "0") {
			$TotalDamage02 = $Dicenumber02 + "d" + $DamageDice02
		}
		else {
			$TotalDamage02 = $Dicenumber02 + "d" + $DamageDice02 + "+" + $Modifier02
		}
		$DamageType02 = Read-Host "Enter the secondary damage type of the attack"
	}

	Write-Host "Thank you, generating string..."

	if ($AddDamageType -eq "y") {
		Write-Output "$AttackName. Melee Weapon Attack: [rollable]+$ToHit;{`"diceNotation`":`"1d20+$ToHit`",`"rollType`":`"to hit`",`"rollAction`":`"$AttackName`"}[/rollable] to hit, reach $Range ft., one target. Hit: $AverageDamage01 [rollable]($TotalDamage01);{`"diceNotation`":`"$TotalDamage01`",`"rollType`":`"damage`",`"rollAction`":`"$AttackName01`",`"rollDamageType`":`"$DamageType01`"}[/rollable] $DamageType01 damage plus $AverageDamage02 [rollable]($TotalDamage02);{`"diceNotation`":`"$TotalDamage02`",`"rollType`":`"damage`",`"rollAction`":`"$AttackName02`",`"rollDamageType`":`"$DamageType02`"}[/rollable] $DamageType02 damage." | clip
	}
	else {
		Write-Output "$AttackName. Melee Weapon Attack: [rollable]+$ToHit;{`"diceNotation`":`"1d20+$ToHit`",`"rollType`":`"to hit`",`"rollAction`":`"$AttackName`"}[/rollable] to hit, reach $Range ft., one target. Hit: $AverageDamage01 [rollable]($TotalDamage01);{`"diceNotation`":`"$TotalDamage01`",`"rollType`":`"damage`",`"rollAction`":`"$AttackName01`",`"rollDamageType`":`"$DamageType01`"}[/rollable] $DamageType01 damage." | clip
	}
	
	Write-Host "The string is now copied to your clipboard, you can now paste it into the Actions Description window on DnDBeyond, and format it as needed."
	
	($Answer = Read-Host "Do you want to create another attack? (Y/N))")
	
} until ($Answer -eq 'N')
	
Write-Host "Thank you for using this tool, please call again!"

Sleep 5
