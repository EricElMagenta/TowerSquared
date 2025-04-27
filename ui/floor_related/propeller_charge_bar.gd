extends Node2D

func fill_charge_bar(progress:int):
	$PropellerChargeBar.value = abs(progress)

func delete_charge_bar():
	queue_free()
