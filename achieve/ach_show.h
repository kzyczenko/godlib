
#ifndef	INCLUDED_ACH_SHOW_H
#define	INCLUDED_ACH_SHOW_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>
#include	<godlib/asset/package.h>
#include	<godlib/clock/clock.h>
#include	<godlib/graphic/graphic.h>
#include	<godlib/input/input.h>


/* ###################################################################################
#  ENUMS
################################################################################### */

enum
{
	eACH_SHOW_MODE_STATS,
	eACH_SHOW_MODE_TASKS,
	eACH_SHOW_MODE_NEW,
};


/* ###################################################################################
#  PROTOTYPES
################################################################################### */

void	Achieve_Show_AppInit( void );
void	Achieve_Show_AppDeInit( void );

void	Achieve_Show_Init( void );
void	Achieve_Show_DeInit( void );
U16		Achieve_Show_Update( sInput * apInput );

void	Achieve_Show_ButtonRender( sGraphicCanvas * apCanvas, sGraphicPos * apPos, const U16 aTaskIndex );
void	Achieve_Show_SymbolRender( sGraphicCanvas * apCanvas, sGraphicPos * apPos, uU32 * apFrame, const U16 aTaskIndex );


/* ################################################################################ */

#endif	/*	INCLUDED_ACH_SHOW_H	*/
