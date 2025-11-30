/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	"pkg_dir.h"

#include	"relocate.h"

#include	<godlib/debug/dbgchan.h>
#include	<godlib/cli/cli.h>
#include	<godlib/file/file.h>
#include	<godlib/file/file_ptn.h>
#include	<godlib/gemdos/gemdos.h>
#include	<godlib/linkfile/linkfile.h>
#include	<godlib/memory/memory.h>
#include	<godlib/string/string.h>


/* ###################################################################################
#  DATA
################################################################################### */

sGemDosDTA	gPackageDirDTA;


/* ###################################################################################
#  CODE
################################################################################### */

/*-----------------------------------------------------------------------------------*
* FUNCTION : PackageDir_Load( sPackage * apPackage, const char * apDirName )
* ACTION   : PackageDir_Load
* CREATION : 30.11.2003 PNK
*-----------------------------------------------------------------------------------*/

U32	PackageDir_Load( sPackage * apPackage, const char * apDirName )
{
	sFilePattern pattern;
	U16 resolved = 0;

	apPackage->mFileCount = 0;
	if( FilePattern_Init( &pattern, apDirName ) )
	{
		while( FilePattern_Next( &pattern ) )
			apPackage->mFileCount++;
	}

	if( FilePattern_Init( &pattern, apDirName ) )
	{
		U16 itemIndex = 0;
		apPackage->mpItems = (sAssetItem*)mMEMCALLOC( sizeof(sAssetItem) * apPackage->mFileCount );
		for( ;FilePattern_Next( &pattern ) && (itemIndex<apPackage->mFileCount); itemIndex++ )
		{
			sAssetItem * item = &apPackage->mpItems[ itemIndex ];
			const char * pExt = StringPath_GetpExt(pattern.mPath.mChars);

			item->mSize = File_GetSize( pattern.mPath.mChars );
			item->mpData = File_Load( pattern.mPath.mChars );
			item->mHashKey = Asset_BuildHash( StringPath_GetpFileName(pattern.mPath.mChars), 12 );
			item->mStatusBits = eASSET_STATUS_BIT_LOADED;
			if( pExt )
			{
				if( '.' == *pExt )
					pExt++;
				item->mExtension = Asset_BuildHash( pExt, 4 );
			}

			RelocaterManager_DoRelocate( item );
			RelocaterManager_DoInit( item );
		}


		/* pass two - service clients */
		/* techinically this should iterate until no more clients need to be services, as deps could be multiple levels deep */

		for( itemIndex=0; itemIndex<apPackage->mFileCount; itemIndex++ )
		{
			sAssetItem * item = &apPackage->mpItems[ itemIndex ];
			sAssetClient * client = Context_AssetClient_Find( apPackage->mpContext, item->mHashKey );
			if( client )
			{
				AssetClients_OnLoad( client, item);
			}
		}


	do
	{
		resolved = 0;

		for( itemIndex=0; itemIndex<apPackage->mFileCount; itemIndex++ )
		{
			sAssetItem * item = &apPackage->mpItems[ itemIndex ];
			sAssetClient * client = Context_AssetClient_Find( apPackage->mpContext, item->mHashKey );
			sAssetClient * c;
			U8 needLoad = 0;

			for( c=client; c; c=c->mpNext )
			{
				if( !c->mpAsset )
				{
					needLoad = 1;
					break;
				}
			}

			if( needLoad )
			{
				AssetClients_OnLoad( client, item );
				resolved = 1;
			}
		}
	} while (resolved);


	}

	return 1;
}


/*-----------------------------------------------------------------------------------*
* FUNCTION : PackageDir_UnLoad( sPackage * apPackage )
* ACTION   : PackageDir_UnLoad
* CREATION : 30.11.2003 PNK
*-----------------------------------------------------------------------------------*/

U32	PackageDir_UnLoad( sPackage * apPackage )
{
	U16 i;

	/* pass one - invoke unloads */

	for( i=0; i<apPackage->mFileCount; i++ )
	{
		sAssetItem * item = &apPackage->mpItems[ i ];
		sAssetClient * client = Context_AssetClient_Find( apPackage->mpContext, item->mHashKey );
		if( client )
		{
			AssetClients_OnUnLoad( client );
		}
	}

	/* pass two - invoke relocators */
	for( i=0; i<apPackage->mFileCount; i++ )
	{
		sAssetItem * item = &apPackage->mpItems[ i ];
		
		RelocaterManager_DoDeInit( item );
		RelocaterManager_DoDelocate( item );

		File_UnLoad( item->mpData );

		item->mpData = 0;
		item->mSize = 0;
	}

	return 1;
}


/*-----------------------------------------------------------------------------------*
* FUNCTION : PackageDir_Destroy( sPackage * apPackage )
* ACTION   : PackageDir_Destroy
* CREATION : 30.11.2003 PNK
*-----------------------------------------------------------------------------------*/

void	PackageDir_Destroy( sPackage * apPackage )
{
	PackageDir_UnLoad( apPackage );
	if( apPackage->mpItems )
	{
		mMEMFREE( apPackage->mpItems );
	}
	apPackage->mFileCount = 0;
}


/* ################################################################################ */
