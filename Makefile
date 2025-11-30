CC = m68k-atari-mint-gcc-14
LD = m68k-atari-mint-gcc-14
AS = vasmm68k_mot
AR = m68k-atari-mint-ar

SOURCES = achieve/ach_main.c achieve/ach_show.c achieve/ach_sign.c achieve/ach_unlk.c \
	assert/assert.c \
	asset/asset.c asset/context.c asset/package.c asset/pkg_dir.c asset/pkg_lnk.c asset/relocate.c \
	audio/amixer.c audio/audio.c audio/rel_spl.c audio/ssd.c \
	base/base.c \
	blitter/blitter.c \
	chunky/chunky.c \
	cli/cli.c \
	clock/clock.c \
	cookie/cookie.c \
	cutscene/cut_sys.c cutscene/cutparse.c cutscene/cutscene.c cutscene/rel_cut.c \
	debug/debug.c \
	debuglog/debuglog.c \
	drive/drive.c \
	elfhash/elfhash.c \
	encrypt/encrypt.c \
	except/except.c \
	fade/fade.c \
	fe/fed.c fe/fedparse.c fe/r_fed.c fe/rel_fed.c \
	file/file.c \
	font/font.c font/rel_bfb.c \
	font8x8/font8x8.c font8x8/fontdata.c \
	gemdos/gemdos.c \
	graphic/graphic.c graphic/grf_4.c graphic/grf_16.c \
	gui/gui.c gui/guidata.c gui/guiedit.c gui/guifs.c gui/guiparse.c gui/r_gui.c \
	hashlist/hashlist.c \
	hashtree/hashtree.c \
	ikbd/ikbd.c ikbd/ikbd_di.c ikbd/ikbd_sdl.c \
	input/input.c \
	kernel/kernel.c \
	linkfile/linkfile.c \
	main/god_main.c \
	memory/memory.c \
	mfp/mfp.c \
	music/pinknote.c music/snd.c \
	packer/ari_dec.c packer/ari_enc.c packer/bwt_dec.c packer/bwt_enc.c packer/godpack.c packer/lz77_dec.c packer/lz77_enc.c packer/lz77bdec.c packer/lz77benc.c packer/mtf_dec.c packer/mtf_enc.c packer/packer.c packer/rle.c \
	pictypes/art.c pictypes/canvas.c pictypes/canvasic.c pictypes/colquant.c pictypes/degas.c pictypes/gfx.c pictypes/gif.c pictypes/god.c pictypes/gsm.c pictypes/neo.c pictypes/octtree.c pictypes/rel_gsm.c pictypes/tga.c \
	platform/platform.c \
	profiler/profile.c profiler/profiler.c \
	program/program.c \
	random/random.c \
	screen/screen.c \
	scrngrab/scrngrab.c \
	sprite/asprite.c sprite/rel_asb.c sprite/rel_bsb.c sprite/rel_rsb.c sprite/rsprite.c sprite/sprite.c \
	string/string.c string/strlist.c \
	system/system.c \
	tokenise/tokenise.c \
	vbl/vbl.c \
	video/vid_d3d.c video/vid_img.c video/vid_sdl.c video/videl.c video/video.c \
	xbios/xbios.c

SOURCES_S = linea/linea_s.s \
	music/snd_s.s \
	music/pnknot_s.s \
	debuglog/dbglog_s.s \
	sprite/rsprit_s.s \
	sprite/asprit_s.s \
	packer/lz77b_s.s \
	packer/rle_s.s \
	packer/packer_s.s \
	packer/lz77_s.s \
	except/except_s.s \
	wipe/wipe_s.s \
	gemdos/gemdos_s.s \
	pictypes/gfx_s.s \
	chunky/chunky.s \
	chunky/c2p_s.s \
	chunky/chunky_s.s \
	profiler/profiles.s \
	file/file_s.s \
	scrngrab/scrgrabs.s \
	mfp/mfp_s.s \
	system/system_s.s \
	graphic/grf_b4_s.s \
	graphic/grf_4_s.s \
	graphic/grf_tc_s.s \
	graphic/grf_16_s.s \
	clock/clock_s.s \
	program/prog_s.s \
	bios/bios_s.s \
	fade/fade_s.s \
	audio/audio_s.s \
	audio/amixer_s.s \
	audio/ssd_s.s \
	vbl/vbl_s.s \
	maths/fvec_s.s \
	maths/fmat_s.s \
	xbios/xbios_s.s \
	video/video_s.s \
	memory/memory_s.s \
	vector/vector_s.s \
	ikbd/ikbd_s.s \



OBJECTS = $(SOURCES:.c=.o)
OBJECTS_S = $(SOURCES_S:.s=.o)

CFLAGS = -Wall -static -g -D dGODLIB_PLATFORM_ATARI -D dGODLIB_COMPILER_GCC  -I.. -I../cmini/include

LDFLAGS =

OUT = godlib.a

$(OUT): $(OBJECTS)
	$(AR) r $(OUT) $(OBJECTS)

$(OBJECTS): %.o: %.c
	 $(CC) -c $(CFLAGS) $< -o $@

$(OBJECTS_S): %.o: %.s
	 $(AS) -devpac -Faout $< -o $@

clean:
	rm -rf $(OBJECTS) $(OUT)

