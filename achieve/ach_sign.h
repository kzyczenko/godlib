
#ifndef	INCLUDED_ACH_SIGN_H
#define	INCLUDED_ACH_SIGN_H

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

void	Achieve_SignIn_AppInit( void );
void	Achieve_SignIn_AppDeInit( void );

void	Achieve_SignIn_Init( void );
void	Achieve_SignIn_DeInit( void );

U16		Achieve_SignIn_Update( sInput * apInput );


/* ################################################################################ */

#endif	/*	INCLUDED_SIGN_H	*/
