
#ifndef	INCLUDED_ACH_UNLK_H
#define	INCLUDED_ACH_UNLK_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>
#include	<godlib/asset/package.h>
#include	<godlib/clock/clock.h>
#include	<godlib/input/input.h>


/* ###################################################################################
#  PROTOTYPES
################################################################################### */

void	Achieve_UnLocked_AppInit( void );
void	Achieve_UnLocked_AppDeInit( void );

void	Achieve_UnLocked_Init( void );
void	Achieve_UnLocked_DeInit( void );

U16		Achieve_UnLocked_Update( sInput * apInput );


/* ################################################################################ */

#endif	/*	INCLUDED_ACH_UNLK_H	*/
