**************************************************************************************
*	_S.S
*
*	 routines
*
*	[c] 2001 Reservoir Gods
**************************************************************************************

**************************************************************************************
;	EXPORTS / IMPORTS
**************************************************************************************

	XDEF	_Clock_TimeVblt

	XREF	_gClockTime
	XREF	_gClockTicks
	XREF	_gClockSubTicks
	XREF	_gClockTickAdd
	XREF	_gClockSubTickAdd
	XREF	_gClockFrameRate


**************************************************************************************
	TEXT
**************************************************************************************

*------------------------------------------------------------------------------------*
* FUNTION  : _Clock_TimeVblt( void )
* ACTION   : updates clock based on vbl timing
* CREATION : 24.01.01 PNK
*------------------------------------------------------------------------------------*

_Clock_TimeVblt:
	move.l	d0,-(a7)						;	save registers
	move.l	d1,-(a7)						;	save registers
	move.l	d2,-(a7)						;	save registers

	move.l	_gClockTime,d0					;	old clock value
	addq.b	#1,d0							;	inc frames
	move.b	_gClockFrameRate,d1
	cmp.b	d1,d0							;	next second reached?
	bls.s	.tc_storeclock					;	no, store clock value
.tc_sectick:
	clr.b	d0								;	reset microseconds counter
	add.w	#256,d0							;	inc second counter
	cmp.w	#(59*256),d0					;	60 second reached?
	bls.s	.tc_storeclock					;	no, store clock value
.tc_mintick:
	clr.w	d0								;	clear seconds
	swap	d0								;	get hours:minutes
	addq.b	#1,d0							;	inc minutes
	cmp.b	#59,d0							;	60 minutes reached?
	bls.s	.tc_swapstore					;	no, swap & store clcok
.tc_hourtick:
	clr.b	d0								;	clear minutes
	add.w	#256,d0							;	inc hours
.tc_swapstore:
	swap	d0								;	hours:minutes into top 16 bits
.tc_storeclock:
	move.l	d0,_gClockTime					;	store clock

	move.l	_gClockTickAdd,d0				;
	move.l	_gClockTicks,d1
	move.l	_gClockSubTickAdd,d2

	add.w	d2,_gClockSubTicks
	addx.l	d0,d1

	move.l	d1,_gClockTicks

	move.l	(a7)+,d2						;	restore registers
	move.l	(a7)+,d1						;	restore registers
	move.l	(a7)+,d0						;	restore registers
	rts


**************************************************************************************
