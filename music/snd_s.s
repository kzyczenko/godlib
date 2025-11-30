**************************************************************************************
*	SND_S.S
*
*	SND player functions
*
*	[c] 2001 Reservoir Gods
**************************************************************************************

**************************************************************************************
;	EXPORTS / IMPORTS
**************************************************************************************

	XDEF	_Snd_CallFunction
	XDEF	_Snd_Player
	XDEF	_Snd_SetpPlayFunc
	XDEF	_Snd_SetpChaserFunc


**************************************************************************************
	TEXT
**************************************************************************************

*------------------------------------------------------------------------------------*
* FUNCTION : _Snd_CallFunction( void (*apFunc)(void) )
* ACTION   : saves regs and calls a function
* CREATION : 02.02.01 PNK
*------------------------------------------------------------------------------------*

_Snd_CallFunction:
	movem.l	d0-a6,-(a7)
	jsr		(a0)
	movem.l	(a7)+,d0-a6
	rts


*------------------------------------------------------------------------------------*
* FUNCTION : _Snd_Player( void )
* ACTION   : saves regs and calls a function
* CREATION : 02.02.01 PNK
*------------------------------------------------------------------------------------*

_Snd_Player:

	movem.l	d0-a6,-(a7)
	move.l	Snd_pPlayFunc,a0
	jsr		(a0)
	move.l	Snd_pChaserFunc,a0
	jsr		(a0)
	movem.l	(a7)+,d0-a6

Snd_Rts:
	rts


*------------------------------------------------------------------------------------*
* FUNCTION : _Snd_SetpPlayFunc( void (*aPlayFunc)(void) )
* ACTION   : sets current SND play function
* CREATION : 02.02.01 PNK
*------------------------------------------------------------------------------------*

_Snd_SetpPlayFunc:
	move.l	a0,Snd_pPlayFunc
	rts


*------------------------------------------------------------------------------------*
* FUNCTION : _Snd_SetpChaserFunc( void (*aPlayFunc)(void) )
* ACTION   : sets current SND FX function
* CREATION : 02.02.01 PNK
*------------------------------------------------------------------------------------*

_Snd_SetpChaserFunc:
	move.l	a0,Snd_pChaserFunc
	rts


Snd_pPlayFunc:		dc.l	Snd_Rts
Snd_pChaserFunc:	dc.l	Snd_Rts
