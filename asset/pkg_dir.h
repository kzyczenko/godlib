#ifndef	INCLUDED_PKG_DIR_H
#define	INCLUDED_PKG_DIR_H

/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	<godlib/base/base.h>

#include	"package.h"


/* ###################################################################################
#  PROTOTYPES
################################################################################### */

U32		PackageDir_Load( sPackage * apPackage, const char * apDirName );
void	PackageDir_Destroy( sPackage * apPackage );

/* ################################################################################ */

#endif	/* INCLUDED_PKG_DIR_H */
