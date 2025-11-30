**************************************************************************************
*	PROFILERS.S
*
*	Profiler interrupt
*
*	[c] 2001 Reservoir Gods
**************************************************************************************

**************************************************************************************
;	EXPORTS / IMPORTS
**************************************************************************************

	XDEF	_Profiler_HBL
	XDEF	_Profiler_HBLDummy
	XDEF	_Profiler_VBL

	XREF	_Profiler_Update

	XREF	_gpProfilerBuffer
	XREF	_gProfilerIndex


**************************************************************************************
	TEXT
**************************************************************************************

*------------------------------------------------------------------------------------*
* FUNCTION : _Profiler_HBL
* ACTION   : 68000 version of HBL interrupt
* CREATION : 01.05.01 PNK
*------------------------------------------------------------------------------------*

_Profiler_HBL:
	move.l	d0,-(a7)
	move.l	a0,-(a7)

	move.l	_gProfilerIndex,d0
	move.l	_gpProfilerBuffer,a0
	addq.l	#4,d0
	andi.l	#(32*1024)-1,d0
	move.l	d0,_gProfilerIndex
	move.l	8+2(sp),(a0,d0.l)

	move.l	(a7)+,a0
	move.l	(a7)+,d0

	rte


*------------------------------------------------------------------------------------*
* FUNCTION : _Profiler_HBLDummy
* ACTION   : does nowt
* CREATION : 01.05.01 PNK
*------------------------------------------------------------------------------------*

_Profiler_HBLDummy:

	rte


*------------------------------------------------------------------------------------*
* FUNCTION : _Profiler_VBL
* ACTION   : 68000 version of VBL interrupt
* CREATION : 01.05.01 PNK
*------------------------------------------------------------------------------------*

_Profiler_VBL:
	tas		gProfilerVblLockFlag
	bne.s	.locked
	movem.l	d0-a6,-(a7)
	jsr		_Profiler_Update
	movem.l	(a7)+,d0-a6
	clr.b	gProfilerVblLockFlag

.locked:
	rts

gProfilerVblLockFlag:	ds.b	1