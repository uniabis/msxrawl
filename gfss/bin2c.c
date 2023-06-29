#include <stdio.h>

typedef unsigned char BYTE;

enum {
	SUCCESS = 0,
	ERROR_ARG,
	ERROR_READ,
};

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

int main(int argc, char **argv) {
	FILE *fp;

	if (argc != 2) {
		printf("%s [inputfile]", argv[0]);
		return ERROR_ARG;
	}
	fp = fopen(argv[1], "rb");
	if (fp == NULL) {
		return ERROR_READ;
	}
	while (1) {
		BYTE buf[16];
		size_t i, len;
		len = fread(buf, 1, sizeof(buf), fp);
		if (len == 0) {
			break;
		}
		for (i = 0; i < len; i++) {
			printf("0x%02X,", buf[i]);
		}
		putchar('\n');
	}
	fclose(fp);
	return SUCCESS;
}
