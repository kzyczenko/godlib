**************************************************************************************
*	FADE_S.S
*
*	interrupt based fade rout
*
*	[c] 2001 Reservoir Gods
**************************************************************************************

**************************************************************************************
;	EXPORTS / IMPORTS
**************************************************************************************

	XDEF	_Fade_Vbl

	XREF	_gFadeVblLockFlag
	XREF	_gFadeVblActiveFlag

	XREF	_Fade_PalSTE
	XREF	_Video_SetNextPalST

	XREF	_gFade


**************************************************************************************
;	STRUCTS
**************************************************************************************

	rsreset

sFade_mGamma:           rs.w    1
sFade_mVblAdd:          rs.l    1
sFade_mVblScale:        rs.l    1
sFade_mpVblTmpPal:      rs.l    1
sFade_mpVblOldPal:      rs.l    1
sFade_mpVblTargetPal:   rs.l    1
sFade_mVblOldPal:       rs.w    16
sFade_mVblTmpPal:       rs.w    16
sFade_mCurrentBasePal:  rs.w    16
sFade_sizeof:           rs.w    1


**************************************************************************************
	TEXT
**************************************************************************************

*------------------------------------------------------------------------------------*
* FUNCTION : _Fade_Vbl
* ACTION   : does a vbl based fade
* CREATION : 11.04.01 PNK
*------------------------------------------------------------------------------------*

_Fade_Vbl:

	tst.b	_gFadeVblActiveFlag
	beq.s	.nofade

	tas		_gFadeVblLockFlag
	bne		.nofade

	movem.l	d0-a6,-(a7)

	move.l	_gFade+sFade_mVblAdd,d0
	add.l	d0,_gFade+sFade_mVblScale

	move.w	_gFade+sFade_mVblScale,d1
	cmp.w	#$100,d1
	blt.s	.less
	move.w	#$100,d1
	clr.b	_gFadeVblActiveFlag
.less:

	move.l	_gFade+sFade_mpVblTmpPal,a0
	move.l	_gFade+sFade_mpVblOldPal,a1
	moveq	#16,d0
	move.l	_gFade+sFade_mpVblTargetPal,-(a7)
	jsr		_Fade_PalSTE
	addq.l	#4,a7

	move.l	_gFade+sFade_mpVblTmpPal,a0
	jsr		_Video_SetNextPalST

	movem.l	(a7)+,d0-a6
	clr.b	_gFadeVblLockFlag

.nofade:
	rts


**************************************************************************************
