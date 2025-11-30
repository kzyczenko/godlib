#ifndef	INCLUDED_PLATFORM_H
#define	INCLUDED_PLATFORM_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>


/* ###################################################################################
#  PROTOTYPES
################################################################################### */

void	Platform_Init( void );
void	Platform_DeInit( void );
void	Platform_Main( void );

void	Platform_Hardware_Init( void );
void	Platform_Hardware_DeInit( void );


/* ################################################################################ */

#endif	/*	INCLUDED_PLATFORM_H	*/
