#include <stdio.h>

#define MAGICKEY 0

typedef unsigned char BYTE;

static int read(char *path, BYTE *buf, size_t len) {
	FILE *fp = fopen(path, "rb");
	size_t result;
	if (fp == NULL) {
		printf("file open error %s", path);
		return	0;
	}
	result = fread(buf, 1, len, fp);
	fclose(fp);
	if (len != result) {
		printf("file read error %s", path);
		return 0;
	}
	return 1;
}

static int write(char *path, BYTE *buf, size_t len) {
	FILE *fp = fopen(path, "wb");
	size_t result;
	if (fp == NULL) {
		printf("file open error %s", path);
		return	0;
	}
	result = fwrite(buf, 1, len, fp);
	fclose(fp);
	if (len != result) {
		printf("file write error %s", path);
		return 0;
	}
	return 1;
}

static unsigned getword(BYTE *p)
{
	return p[0] | (p[1] << 8);
}

static void patchbyte(unsigned bank, BYTE *base, unsigned address, unsigned value)
{
	BYTE *p = base + (bank * 0x4000) + (address & 0x3fff);
	p[0] = (BYTE)value;
}

static void patchcall(unsigned bank, BYTE *base, unsigned address, unsigned value)
{
	BYTE *p = base + (bank * 0x4000) + (address & 0x3fff);
	p[1] = (BYTE)(value >> 0);
	p[2] = (BYTE)(value >> 8);
}

enum {
	SUCCESS = 0,
	ERROR_ARG,
	ERROR_READ,
	ERROR_WRITE,
};

static BYTE gfss402e[] = {
#include "z80/gfss402e.h"
};
static BYTE gfssb97c[] = {
#include "z80/gfssb97c.h"
};
static BYTE gfssbd25[] = {
#include "z80/gfssbd25.h"
};
static BYTE gfssbd90[] = {
#include "z80/gfssbd90.h"
};
#if MAGICKEY
static BYTE gfmk6e3d[] = {
#include "z80/gfmk6e3d.h"
};
#endif

int main(int argc, char **argv) {
	unsigned LDIRVM_EX = 0xBD25;
	unsigned LDIRMV_EX = 0xBD48;
	unsigned FILVRM_EX = 0xBD6E;

	unsigned SETRD_EX = 0xBE48;
	unsigned SETWRT_EX = 0xBE58;
	
	unsigned WRTVRM_EX;
	unsigned RDVRM_EX;

	unsigned current_bank;
	unsigned set_name_table_base;
	unsigned patched_init_bank0;
	unsigned moved_set_pattern_1;
	unsigned moved_set_pattern_2;
	unsigned patched_graphic_init;
	unsigned patched_sprite_update;
	unsigned new_sprite_update;

	BYTE gf[128*1024];
	BYTE gfss[256*1024];

	if (argc != 3) {
		printf("%s [inputfile] [outputfile]", argv[0]);
		return ERROR_ARG;
	}

	current_bank = getword(&gfssb97c[sizeof(gfssb97c)-2*10]);
	set_name_table_base = getword(&gfssb97c[sizeof(gfssb97c)-2*9]);
	patched_init_bank0 = getword(&gfssb97c[sizeof(gfssb97c)-2*8]);
	moved_set_pattern_1 = getword(&gfssb97c[sizeof(gfssb97c)-2*4]);
	moved_set_pattern_2 = getword(&gfssb97c[sizeof(gfssb97c)-2*3]);
	patched_graphic_init = getword(&gfssb97c[sizeof(gfssb97c)-2*2]);
	patched_sprite_update = getword(&gfssb97c[sizeof(gfssb97c)-2*1]);
	new_sprite_update = getword(&gfssb97c[sizeof(gfssb97c)-2*5]);
	WRTVRM_EX = getword(&gfssb97c[sizeof(gfssb97c)-2*6]);
	RDVRM_EX = getword(&gfssb97c[sizeof(gfssb97c)-2*7]);

	if (!read(argv[1], gf, sizeof(gf))) {
		return ERROR_READ;
	}
	memset(gfss, 0xff, sizeof(gfss));
	memcpy(gfss, gf, sizeof(gf));

	memcpy(&gfssb97c[sizeof(gfssb97c)-sizeof(gfssbd90)], &gf[0xbd90 & 0x3fff], sizeof(gfssbd90));
	
	memcpy(&gfss[0x402e & 0x3fff], gfss402e, sizeof(gfss402e));
	memcpy(&gfss[0xbd25 & 0x3fff], gfssbd25, sizeof(gfssbd25));
	memcpy(&gfss[0xbd90 & 0x3fff], gfssbd90, sizeof(gfssbd90));

	patchcall(0, gfss, 0x403b, patched_init_bank0);
	patchcall(0, gfss, 0x806f, patched_graphic_init);
	patchcall(0, gfss, 0x8182, patched_sprite_update);
	patchcall(0, gfss, 0x8240, patched_sprite_update);

	patchcall(0, gfss, 0xbd22, RDVRM_EX);

	patchcall(0, gfss, 0xbd18, WRTVRM_EX);
	patchcall(6, gfss, 0x6e75, WRTVRM_EX);
	patchcall(6, gfss, 0x6ffa, WRTVRM_EX);
	patchcall(6, gfss, 0x7172, WRTVRM_EX);
	patchcall(6, gfss, 0x7177, WRTVRM_EX);
	patchcall(6, gfss, 0x7183, WRTVRM_EX);

	patchcall(0, gfss, 0x80e4, FILVRM_EX);
	patchcall(6, gfss, 0x6d73, FILVRM_EX);
	patchcall(6, gfss, 0x72ee, FILVRM_EX);

	patchcall(0, gfss, 0x9ab7, LDIRVM_EX);
	patchcall(0, gfss, 0x9cc4, LDIRVM_EX);
	patchcall(0, gfss, 0x9e06, LDIRVM_EX);
	patchcall(0, gfss, 0xb7f1, LDIRVM_EX);

	patchcall(6, gfss, 0x6d5e, LDIRVM_EX);
	patchcall(6, gfss, 0x6e84, LDIRVM_EX);
	patchcall(6, gfss, 0x72d6, LDIRVM_EX);
	
	patchcall(0, gfss, 0x8d16, SETWRT_EX);
	patchcall(0, gfss, 0x9211, SETWRT_EX);

	patchcall(0, gfss, 0x80d9, moved_set_pattern_1);
	patchcall(0, gfss, 0x8799, moved_set_pattern_1);
	patchcall(0, gfss, 0x80d5, moved_set_pattern_2);
	patchcall(0, gfss, 0x8767, moved_set_pattern_2);

	patchcall(0, gfss, 0x88f4, set_name_table_base);
	patchcall(0, gfss, 0x8a38, set_name_table_base);

	patchbyte(0, gfss, 0xbf6a, 0xC9);

	memcpy(&gfss[0x4000*8], &gfss[0x4000*0], 0x4000);

	patchbyte(8, gfss, current_bank, 8);

	memcpy(&gfss[0xb97c & 0x3fff], gfssb97c, sizeof(gfssb97c));

#if MAGICKEY
	/* SECRET MAGIC KEY */
	memcpy(&gfss[(0x6e3d & 0x3fff) + 6 * 0x4000], gfmk6e3d, sizeof(gfmk6e3d));
#endif

	if (!write(argv[2], gfss, sizeof(gfss)))
	{
		return ERROR_WRITE;
	}

	return SUCCESS;
}
