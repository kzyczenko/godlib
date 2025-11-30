**************************************************************************************
*	VBL_S.S
*
*	vbl based functions
*
*	[c] 2000 Reservoir Gods
**************************************************************************************



**************************************************************************************
;	EXPORTS / IMPORTS
**************************************************************************************

	XDEF	_Vbl_GetHandler
	XDEF	_Vbl_SetHandler
	XDEF	_Vbl_HandlerST
	XDEF	_Vbl_HandlerSTE
	XDEF	_Vbl_HandlerTT
	XDEF	_Vbl_HandlerFalcon
	XDEF	_Vbl_GetCounter
	XDEF	_Vbl_WaitVbl
	XDEF	_Vbl_Handler

	XDEF	_gVblHbiCounter

	XDEF	_Vbl_DummyFunc

	XREF	_gVbl



**************************************************************************************
;	STRUCTS
**************************************************************************************

    rsreset

sVBL_LockFlag:         rs.b    1
sVBL_TimerBScanLine:   rs.b    1
sVBL_HbiCounterStart:  rs.w    1
sVBL_HbiCounter:       rs.w    1
sVBL_CallCount:        rs.w    1
sVBL_pHbi:             rs.l    1
sVBL_pTimerBFunc:      rs.l    1
sVBL_pVideoFunc:       rs.l    1
sVBL_pCalls:           rs.l    1

**************************************************************************************
	TEXT
**************************************************************************************

*------------------------------------------------------------------------------------*
* Function:    void (*Get_VblHander( void ))()
*
* Action:      returns pointer to current vbl handler function
*
* Created:     24.03.00 PNK
*------------------------------------------------------------------------------------*

_Vbl_GetHandler:
	move.l	$70.w,a0
	rts


*------------------------------------------------------------------------------------*
* Function:    void Vbl_SetHander( void (*apHandler()) )
*
* Action:      returns pointer to current vbl handler function
*
* Created:     24.03.00 PNK
*------------------------------------------------------------------------------------*

_Vbl_SetHandler:
	move.w	sr,-(a7)
	ori.w	#$0700,sr

	move.l	a0,$70.w

	move.w	(a7)+,sr
	rts


*------------------------------------------------------------------------------------*
* Function:    Vbl_GetCounter()
* Action:      returns current vbl counter
* Created:     27.11.00 PNK
*------------------------------------------------------------------------------------*

_Vbl_GetCounter:
	move.l	$466.w,d0
	rts


*------------------------------------------------------------------------------------*
* Function:    Vbl_WaitVbl()
* Action:      waits for vertical blank
* Created:     27.11.00 PNK
*------------------------------------------------------------------------------------*

_Vbl_WaitVbl:
	move.l	a2,-(a7)

	move.w	#37,-(a7)
	trap	#14
	addq.l	#2,a7

	move.l	(a7)+,a2
	rts

	move.l	$466.w,d0
.vbl_wait:
	cmp.l	$466.w,d0
	beq.s	.vbl_wait
	rts


*------------------------------------------------------------------------------------*
* Function:    Vbl_Handler()
* Action:      generic vbl handler
* Created:     02.01.03 PNK
*------------------------------------------------------------------------------------*

_Vbl_Handler:
	ori.w	#$0700,sr						; don't interrupt me

	tst.l	_gVbl+sVBL_pHbi
	beq.s	.no_hbi

	move.w	_gVbl+sVBL_HbiCounterStart,_gVbl+sVBL_HbiCounter
	move.l	_gVbl+sVBL_pHbi,$68.w

.no_hbi:

	tst.l	_gVbl+sVBL_pTimerBFunc
	beq.s	.no_tb
	clr.b	$FFFFFA1B.w								; timer B off
	move.l	_gVbl+sVBL_pTimerBFunc,$120.w			; new timer B routine
	move.b	_gVbl+sVBL_TimerBScanLine,$FFFFFA21.w	; first scanline for timer B
	move.b	#8,$FFFFFA1B.w							; start timer B
.no_tb:

	tas		_gVbl+sVBL_LockFlag				; already in vbl interrupt?
	bne.s	.vbl_locked						; don't interrupt yourself
	movem.l	d0-d7/a0-a6,-(a7)				; save register

	move.l	_gVbl+sVBL_pVideoFunc,a0
	jsr		(a0)

	move.w	#$2400,sr

	move.w	_gVbl+sVBL_CallCount,d7			; call count
	lea		_gVbl+sVBL_pCalls,a6				; start of vbl function table
	bra.s	.first							; begin the call
.call_loop:
	move.l	(a6)+,a0						; get function address
	jsr		(a0)							; call function
.first:
	dbra	d7,.call_loop					; loop for all functions

	movem.l	(a7)+,d0-d7/a0-a6				; restore registers
	clr.b	_gVbl+sVBL_LockFlag				; unlock vbl
.vbl_locked:
	addq.l	#1,$466.w						; update vbl counter
	rte										; return from exception


*------------------------------------------------------------------------------------*
* Function:    Vbl_DummyFunc( void )
* Action:      dummy function
* Created:     02.01.03 PNK
*------------------------------------------------------------------------------------*

_Vbl_DummyFunc:
	rts


**************************************************************************************
	DATA
**************************************************************************************

_gVblHbiCounter:	dc.w	0