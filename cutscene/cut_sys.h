#ifndef	INCLUDED_CUT_SYS_H
#define	INCLUDED_CUT_SYS_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>
#include	<godlib/cutscene/cutscene.h>
#include	<godlib/hashtree/hashtree.h>


/* ###################################################################################
#  DEFINES
################################################################################### */


/* ###################################################################################
#  STRUCTS
################################################################################### */


/* ###################################################################################
#  PROTOTYPES
################################################################################### */

void		CutScene_System_AppInit( void );
void		CutScene_System_AppDeInit( void );

U8			CutScene_System_Update( void );
void		CutScene_System_Render( void );

void		CutScene_System_ScriptInit( sCutScene * apCut, char * apScriptName );
void		CutScene_System_SetpHashTree( sHashTree * apTree );
sHashTree *	CutScene_System_GetpHashTree( void );
U8			CutScene_System_IsScriptFinished( void );


/* ################################################################################ */

#endif	/* INCLUDED_CUT_SYS_H */
