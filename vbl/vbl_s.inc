**************************************************************************************
;	STRUCTS
**************************************************************************************

	DATA

    rsreset                     ; zamiast OFFSET – reset licznika offsetu

sVBL_LockFlag:         rs.b    1
sVBL_TimerBScanLine:   rs.b    1
sVBL_HbiCounterStart:  rs.w    1
sVBL_HbiCounter:       rs.w    1
sVBL_CallCount:        rs.w    1
sVBL_pHbi:             rs.l    1
sVBL_pTimerBFunc:      rs.l    1
sVBL_pCalls:           rs.l    1

	EVEN