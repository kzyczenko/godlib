#ifndef	INCLUDED_R_GUI_H
#define	INCLUDED_R_GUI_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>
#include	<godlib/graphic/graphic.h>
#include	<godlib/gui/gui.h>


/* ###################################################################################
#  PROTOTYPES
################################################################################### */

typedef	void	(*fRenderGui)( sGraphicCanvas * apLogic, sGuiButton * apButton, const U16 aRedrawFlag );

void	RenderGui_Init( void );
void	RenderGui_DeInit( void );

void	RenderGui_SetCustomRender( fRenderGui aCustomRender );
void	RenderGui_Update( sGraphicCanvas * apLogic );

U16		RenderGui_GetScreenIndex( void );


/* ################################################################################ */

#endif	/* INCLUDED_R_GUI_H */
