/* ###################################################################################
#  INCLUDES
################################################################################### */

#include	"platform.h"

#include	<godlib/asset/package.h>
#include	<godlib/asset/relocate.h>
#include	<godlib/audio/audio.h>
#include	<godlib/audio/amixer.h>
#include	<godlib/audio/rel_spl.h>
#include	<godlib/clock/clock.h>
#include	<godlib/cutscene/cut_sys.h>
#include	<godlib/cutscene/rel_cut.h>
#include	<godlib/debug/dbgchan.h>
#include	<godlib/except/except.h>
#include	<godlib/fade/fade.h>
#include	<godlib/fe/rel_fed.h>
#include	<godlib/file/file.h>
#include	<godlib/font/rel_bfb.h>
#include	<godlib/font/font.h>
#include	<godlib/graphic/graphic.h>
#include	<godlib/ikbd/ikbd.h>
#include	<godlib/memory/memory.h>
#include	<godlib/profiler/profiler.h>
#include	<godlib/random/random.h>
#include	<godlib/scrngrab/scrngrab.h>
#include	<godlib/sprite/rel_asb.h>
#include	<godlib/sprite/rel_bsb.h>
#include	<godlib/sprite/rel_rsb.h>
#include	<godlib/system/system.h>
#include	<godlib/vbl/vbl.h>
#include	<godlib/video/video.h>

#ifdef	dGODLIB_SYSTEM_SDL
#pragma pack(push,4)
#include	"sdl.h"
#pragma pack(pop)
#endif

/* ###################################################################################
#  CODE
################################################################################### */

/*-----------------------------------------------------------------------------------*
* FUNCTION : Platform_Init( void )
* ACTION   : calls all initialisation routines
* CREATION : 21.11.01 PNK
*-----------------------------------------------------------------------------------*/

void	Platform_Init( void )
{
/*	DebugLog_Init( "PLAT.LOG" );*/
	DebugChannel_Printf0( eDEBUGCHANNEL_GODLIB, "Platform_Init()" );
	Memory_Init();

#ifdef	dGODLIB_SYSTEM_SDL
	SDL_Init(SDL_INIT_VIDEO);
	SDL_WM_SetCaption("SDL GodLib", "GodLib");
#endif

	Platform_Hardware_Init();

#ifdef	dPROFILER
	Profiler_Init( 0, 0 );
#endif

#ifdef	dSCREENGRAB
	ScreenGrab_Init();
	ScreenGrab_SetDirectory( "SCRNGRAB\\" );
	ScreenGrab_Enable();
#endif

	Random_Init();

#ifdef dGODLIB_CUTSCENE
	CutScene_System_AppInit();
#endif

#ifdef dGODLIB_PACKAGEMANGER
	PackageManager_Init();
	RelocaterManager_Init();
	Relocator_ASB_Init();
	Relocator_BSB_Init();
	Relocator_BFB_Init();
	Relocator_CUT_Init();
	Relocator_FED_Init();
	Relocator_RSB_Init();
	Relocator_SPL_Init();

	PackageManager_SetFilePath( "UNLINK" );
	PackageManager_SetLinkPath( "DATA" );
#endif

}


/*-----------------------------------------------------------------------------------*
* FUNCTION : Platform_DeInit( void )
* ACTION   : calls all de-initialisation routines
* CREATION : 21.11.01 PNK
*-----------------------------------------------------------------------------------*/

void	Platform_DeInit( void )
{
#ifdef dGODLIB_CUTSCENE
	CutScene_System_AppDeInit();
#endif

#ifdef	dSCREENGRAB
	ScreenGrab_Disable();
	ScreenGrab_DeInit();
#endif

#ifdef	dPROFILER
	Profiler_DeInit();
#endif

	Platform_Hardware_DeInit();

#ifdef dGODLIB_PACKAGEMANGER
	PackageManager_DeInit();
	Relocator_ASB_DeInit();
	Relocator_BSB_DeInit();
	Relocator_BFB_DeInit();
	Relocator_CUT_DeInit();
	Relocator_FED_DeInit();
	Relocator_RSB_DeInit();
	Relocator_SPL_DeInit();
	RelocaterManager_DeInit();
#endif

/*	DebugLog_Init( "MEMORY.LOG" );
	Memory_ShowCurrentRecords();
	DebugLog_DeInit();*/
#ifdef	dGODLIB_SYSTEM_SDL
	SDL_Quit();
#endif

	Memory_DeInit();
}


/*-----------------------------------------------------------------------------------*
* FUNCTION : Platform_Hardware_Init( void )
* ACTION   : Platform_Hardware_Init
* CREATION : 26.1.2008 PNK
*-----------------------------------------------------------------------------------*/

void	Platform_Hardware_Init( void )
{
	System_Init();

#ifdef	dGODLIB_EXCEPTION_SCREEN
	Except_Init();
#endif

	Vbl_Init();
	Video_Init();

	IKBD_Init();

	Audio_Init();
#ifdef	dGODLIB_AUDIO_MIXER
	AudioMixer_Init();
	AudioMixer_Enable();
#endif

	System_DataCacheDisable();
	System_InstructionCacheDisable();
	System_SetCPUSpeed( 16 );

	IKBD_EnableJoysticks();

	Graphic_Init();

#ifdef	dGODLIB_FADE
	Fade_Init();
#endif
#ifdef	dGODLIB_CLOCK
	Clock_Init();
#endif
}


/*-----------------------------------------------------------------------------------*
* FUNCTION : Platform_Hardware_DeInit( void )
* ACTION   : Platform_Hardware_DeInit
* CREATION : 26.1.2008 PNK
*-----------------------------------------------------------------------------------*/

void	Platform_Hardware_DeInit( void )
{
#ifdef dGODLIB_CLOCK
	Clock_DeInit();
#endif
#ifdef dGODLIB_FADE
	Fade_DeInit();
#endif
	Graphic_DeInit();
#ifdef	dGODLIB_AUDIO_MIXER
	AudioMixer_DeInit();
#endif
	Audio_DeInit();
	IKBD_EnableMouse();

	IKBD_DeInit();

	Video_DeInit();
	Vbl_DeInit();

#ifdef	dGODLIB_EXCEPTION_SCREEN
	Except_DeInit();
#endif

	System_DeInit();
	Vbl_WaitVbl();
	IKBD_FlushGemdos();

	Audio_SoundChipOff();
}


/* ################################################################################ */
