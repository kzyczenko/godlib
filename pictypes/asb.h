#ifndef	INCLUDED_ASB_H
#define	INCLUDED_ASB_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>


/* ###################################################################################
#  STRUCTS
################################################################################### */

typedef	struct sAsbHeader
{
	U16	mFrameCount;
	U16	mReserved;
	U16	mWidth;
	U16	mHeight;
	U16	mPalette[ 16 ];
} sAsbHeader;


typedef	struct sAsbFrame
{
	U16	mWidth;
	U16	mHeight;
	U16	mReserved;
	U16	mPixels[ 1 ];
} sAsbFrame;


/* ################################################################################ */

#endif	/*	INCLUDED_ASB_H */