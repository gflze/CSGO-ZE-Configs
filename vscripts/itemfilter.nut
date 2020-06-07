;Install as csgo/scripts/vscripts/itemfilter.nut
;Script taken from ze_ffxii_westersand_v8zeta1_b5k

;Used by the following strippers:
;	- ze_LOTR_Helms_Deep_v5_p6
;	- ze_LOTR_Mount_Doom_p3

function filterHolderNoIn() 
{
	if (self.GetMoveParent().GetOwner() == activator)
		EntFireByHandle(self, "FireUser1", "", 0.0, activator, activator)
}