#include <dos.h>
#include <stdio.h>
#include <string.h>

int main(int argc,char** argv) {

	char pdi[128],ima[128],buf[27];
	int ch,pos=0,rep=0,prev=-1,i;
	FILE *in,*out;
	char* dot;

	printf("\nPDI to IMA file converter v0.1\n\n");

	// check for input file parameter
	if (argc!=2) {
		printf("Usage: PDI2IMA filename[.pdi]\n");
		return 1;
	}

	// arrange input and output filenames
	strcpy(pdi,argv[1]);
	for (i=0;i<strlen(pdi);i++) pdi[i]=toupper(pdi[i]);
	dot=strchr(pdi,'.');
	if (dot) {
		strncpy(ima,pdi,dot-pdi);
		ima[dot-pdi]=0;
	} else {
		strcpy(ima,pdi);
		strcat(pdi,".PDI");
	}
	strcat(ima,".IMA");

	// open input PDI file
	if ((in=fopen(pdi,"rb"))==NULL) {
		printf("Error: Unable to open input file %s\n",pdi);
		return 2;
	}

	// read PDI header
	if (!fread(buf,27,1,in)) {
		printf("Error: input file too small\n");
		return 3;
	}

	// check PDI header strings
	if (strncmp((char*)buf,"PDITYPE1",8) || strncmp((char*)buf+19,"MAINDATA",8)) {
		printf("Error: Unrecognized PDI header\n");
		return 4;
	}

	// create output IMA file
	if ((out=fopen(ima,"wb+"))==NULL) {
		printf("Error: Unable to create output file %s\n",ima);
		return 5;
	}

	printf("Converting %s to %s ... ",pdi,ima);

	do {
		// read an input byte
		ch=fgetc(in);

		// check for end of file
		if (ch==EOF) {
			if (pos==5) {
				// check for END marker
				if (buf[0]==0 && buf[1]=='E' && buf[2]=='N' && buf[3]=='D' && buf[4]==0) {
					// success
					printf("Done\n");
					return 0;
				}
				printf("Error: Unrecognized END marker\n");
				return 6;
			} else {
				printf("Error: Unexpected EOF\n");
				return 7;
			}
		}

		// check for repeated byte
		if (ch==prev) rep++;
		else rep=0;
		prev=ch;

		// shift buffer if full
		if (pos==5) {
			fputc(buf[0],out);
			for (i=0;i<4;i++) buf[i]=buf[i+1];
			pos--;
		}

		// store byte in buffer
		buf[pos++]=ch;

		// process repeated byte
		if (rep==2) {
			fwrite(buf,pos,1,out) ;
			pos=0;
			rep=fgetc(in);
			for (i=0;i<rep;i++) fputc(ch,out);
			rep=0;
			prev=-1;
		}

	} while (1);

}
