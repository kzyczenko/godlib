**************************************************************************************
*	ASPRIT_S.S
*
*	assembly true colour sprite routs
*
*	[c] 2005 Reservoir Gods
**************************************************************************************

**************************************************************************************
;	EXPORTS / IMPORTS
**************************************************************************************

	XDEF	_AsmSprite_Draw
	XDEF	_AsmSprite_DrawClip


**************************************************************************************
;	STRUCTS
**************************************************************************************

    rsreset

sAsmSprite_mColours:   rs.l    13
sAsmSprite_mWidth:     rs.w    1
sAsmSprite_mHeight:    rs.w    1
sAsmSprite_mfLines:    rs.w    1

**************************************************************************************
	TEXT
**************************************************************************************

*------------------------------------------------------------------------------------*
* FUNCTION : _AsmSprite_Draw( const sAsmSprite * apSprite,U16 * apScreen,U32 aScreenWidth )
* ACTION   : _AsmSprite_Draw
* CREATION : 10.04.2005 PNK
*------------------------------------------------------------------------------------*

_AsmSprite_Draw:
	movem.l	d0-d7/a0-a6,-(a7)
	bsr		AsmSprite_Show
	movem.l	(a7)+,d0-d7/a0-a6
	rts

AsmSprite_Show:
	ext.l	d0
	sub.w	sAsmSprite_mWidth(a0),d0
	add.l	d0,d0
	move.l	#sAsmSprite_mfLines,d1
	move.l	(a0,d1.l),-(a7)
	movem.l	(a0),d1-d7/a0/a2-a6
	rts



*------------------------------------------------------------------------------------*
* FUNCTION : _AsmSprite_DrawClip( const sAsmSprite * apSprite,U16 * apScreen,U32 aScreenWidth,S16 aTopLine,S16 aBotLine )
* ACTION   : _AsmSprite_DrawClip
* CREATION : 10.04.2005 PNK
*------------------------------------------------------------------------------------*

_AsmSprite_DrawClip:

	rts


