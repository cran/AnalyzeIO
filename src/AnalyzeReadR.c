/* C functions for use in AnalyzeIO*/
/* This is a library of functions that enable ANALYZE image format files to be read into R*/

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <R.h>
#include <string.h>
#include <limits.h>


void read2byte(long*, char**, long*, long, long);
void read4byte(long*, char**, long*, long, long);
void readfloat(float*, char**, long*, long, long);
void readdouble(double*, char**, long*, long, long);
void read2byte1(long*, char**, long*, long*, long*);
void read4byte1(long*, char**, long*, long*, long*);
void readfloat1(float*, char**, long*, long*, long*);
void readdouble1(double*, char**, long*, long*, long*);

void swap(void*, int);

void swaptest(unsigned long *ans, char **name)
{
  /*This function tests for the endian-ness of the files by checking the first field of the .hdr file which is always 348 (i.e. the header file length in bytes)*/
  int fd, i;
  unsigned long t1, t2, t3, t4;
  char *p, buf[4];
  long nread;
  
  fd = open(name[0], O_RDONLY);
  if(fd < 0) {
    PROBLEM "can't open file" RECOVER(NULL_ENTRY);
  }
  lseek(fd, 0, SEEK_SET);
  
  nread = read(fd, buf, 4);
  p = buf;
  t1 = (long) (*p++);
  t2 = (long) (*p++);
  t3 = (long) (*p++);
  t4 = (long) (*p++);
  /* *ans = 256*256*256*t4+256*256*t3+256*t2 + t1;*/
  *ans = 256*256*256*t1+256*256*t2+256*t3 + t4;
  close(fd);
}

void swap(void *result, int size)
{
  /* Swaps the bytes when required */
    int i;
    char *p = result, tmp;

    if (size == 1) return;
    for (i = 0; i < size/2; i++) {
	tmp = p[i];
	p[i] = p[size - i - 1];
	p[size - i - 1] = tmp;
    }}


void read2byte(long *ans, char **name, long *swapbytes, long n, long offset)
{
  /* Reads in a sequence of 2 byte short integers */
  int fd, i;
  short buf;
  long nread;
  
  fd = open(name[0], O_RDONLY);
  if(fd < 0) {
    PROBLEM "can't open file" RECOVER(NULL_ENTRY);
  }
  lseek(fd, offset, SEEK_SET);
  
  for(i=0;i<n;i++){
    nread=read(fd,&buf,2);
    if (*swapbytes==1) swap(&buf, 2);
    *(ans+i)= (long) buf;
  }

  close(fd);
}



void read4byte(long *ans, char **name, long *swapbytes, long n, long offset)
{
  /* Reads in a sequence of 4 byte integers */
  int fd, i;
  long buf,nread;
  
  fd = open(name[0], O_RDONLY);
  if(fd < 0) {
    PROBLEM "can't open file" RECOVER(NULL_ENTRY);
  }
  lseek(fd, offset, SEEK_SET);
  
  for(i=0;i<n;i++){
    nread=read(fd,&buf,4);
    if (*swapbytes==1) swap(&buf, 4);
    *(ans+i)= buf;
  }

  close(fd);
}



void readfloat(float *ans, char **name, long *swapbytes, long n, long offset)
{
  /* Reads in a sequence of 4 byte floats */
  int fd, i;
  float buf;
  long nread;
  
  fd = open(name[0], O_RDONLY);
  if(fd < 0) {
    PROBLEM "can't open file" RECOVER(NULL_ENTRY);
  }
  lseek(fd, offset, SEEK_SET);
  
  for(i=0;i<n;i++){
    nread=read(fd,&buf,4);
    if (*swapbytes==1) swap(&buf, 4);
    *(ans+i)= buf;
  }

  close(fd);
}

void readdouble(double *ans, char **name, long *swapbytes, long n, long offset)
{
  /* Reads in a sequence of 8 byte doubles */
  int fd, i;
  double buf;
  long nread;
  
  fd = open(name[0], O_RDONLY);
  if(fd < 0) {
    PROBLEM "can't open file" RECOVER(NULL_ENTRY);
  }
  lseek(fd, offset, SEEK_SET);
 
  for(i=0;i<n;i++){
    nread=read(fd,&buf,8);
    if (*swapbytes==1) swap(&buf, 8);
    *(ans+i)= buf;
  }

  close(fd);
}


void read2byte1(long *ans, char **name, long *swapbytes, long *n, long *offset){
  read2byte(ans, name, swapbytes, *n, *offset);} 

void read4byte1(long *ans, char **name, long *swapbytes, long *n, long *offset){
  read4byte(ans, name, swapbytes, *n, *offset);}

void readfloat1(float *ans, char **name, long *swapbytes, long *n, long *offset){
  readfloat(ans, name, swapbytes, *n, *offset);}

void readdouble1(double *ans, char **name, long *swapbytes, long *n, long *offset){
  readdouble(ans, name, swapbytes, *n, *offset);}


void read_analyze_header(char **name, long *swapbytes, 
			 long *sizeof_hdr,
			 char **data_type,
			 char **db_name,
			 long *extents,
			 long *session_error,
			 char **regular,
			 char **hkey_un0,
			 long *dim,
			 char **vox_units,
			 char **cal_units,
			 long *unused1,
			 long *datatype,
			 long *bitpix,
			 long *dim_un0,
			 float *pixdim,
			 float *vox_offset,
			 float *funused1,
			 float *funused2,
			 float *funused3,
			 float *cal_max,
			 float *cal_min,
			 float *compressed,
			 float *verified,
			 long *glmax,
			 long *glmin,
			 char **descrip,
			 char **aux_file,
			 char **orient,
			 char **originator,
			 char **generated,
			 char **scannum,
			 char **patient_id,
			 char **exp_date,
			 char **exp_time,
			 char **hist_un0,
			 long *views, 
			 long *vols_added, 
			 long *start_field, 
			 long *field_skip, 
			 long *omax, 
			 long *omin,
			 long *smax,
			 long *smin
			 ) 

{
  /*Reads in all the fields of a .hdr header file*/
  int fd, i;
  unsigned long t1, t2, t3, t4;
  char *p, buf[348],*temp;
  long nread;
  
  fd = open(name[0], O_RDONLY);
  if(fd < 0) {
    PROBLEM "can't open file" RECOVER(NULL_ENTRY);
  }
  close(fd);

  read2byte(sizeof_hdr, name, swapbytes, 1, 0L);
  
  fd = open(name[0], O_RDONLY);
  lseek(fd, 4L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(data_type)+i)=buf[i];}
  close(fd);  
 
  fd = open(name[0], O_RDONLY);
  lseek(fd, 14L, SEEK_SET);
  nread=read(fd,buf,18);
  for(i = 0; i < 18; i++) {
    *(*(db_name)+i)=buf[i];}
  close(fd);    
  
  read4byte(extents, name, swapbytes, 1, 32L);

  read2byte(session_error, name, swapbytes, 1, 36L);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 38L, SEEK_SET);
  nread=read(fd,buf,2);
    **db_name=buf[0];
    **hkey_un0=buf[1];
  close(fd);    
  
  read2byte(dim, name, swapbytes, 8, 40L);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 56L, SEEK_SET);
  nread=read(fd,buf,4);
  for(i = 0; i < 4; i++) {
    *(*(vox_units)+i)=buf[i];}
  close(fd);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 60L, SEEK_SET);
  nread=read(fd,buf,8);
  for(i = 0; i < 8; i++) {
    *(*(cal_units)+i)=buf[i];}
  close(fd);


  read2byte(unused1, name, swapbytes, 1, 68L);

  read2byte(datatype, name, swapbytes, 1, 70L);

  read2byte(bitpix, name, swapbytes, 1, 72L);

  read2byte(dim_un0, name, swapbytes, 1, 74L);

  readfloat(pixdim, name, swapbytes, 8, 76);

  readfloat(vox_offset, name, swapbytes, 1, 108);

  readfloat(funused1, name, swapbytes, 1, 112);
  readfloat(funused2, name, swapbytes, 1, 116);
  readfloat(funused3, name, swapbytes, 1, 120);
  readfloat(cal_max, name, swapbytes, 1, 124);
  readfloat(cal_min, name, swapbytes, 1, 128);
  readfloat(compressed, name, swapbytes, 1, 132);
  readfloat(verified, name, swapbytes, 1, 136);

  read4byte(glmax, name, swapbytes, 1, 140L);
  read4byte(glmin, name, swapbytes, 1, 144L);


  fd = open(name[0], O_RDONLY);
  lseek(fd, 148L, SEEK_SET);
  nread=read(fd,buf,80);
  for(i = 0; i < 80; i++) {
    *(*(descrip)+i)=buf[i];}
  close(fd);


  fd = open(name[0], O_RDONLY);
  lseek(fd, 228L, SEEK_SET);
  nread=read(fd,buf,24);
  for(i = 0; i < 24; i++) {
    *(*(aux_file)+i)=buf[i];}
  close(fd);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 252L, SEEK_SET);
  nread=read(fd,buf,1);
    *(*(orient)+i)=buf[0];
  close(fd);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 253L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(originator)+i)=buf[i];}
  close(fd);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 263L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(generated)+i)=buf[i];}
  close(fd);


  fd = open(name[0], O_RDONLY);
  lseek(fd, 273L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(scannum)+i)=buf[i];}
  close(fd);


  fd = open(name[0], O_RDONLY);
  lseek(fd, 283L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(patient_id)+i)=buf[i];}
  close(fd);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 293L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(exp_date)+i)=buf[i];}
  close(fd);

  fd = open(name[0], O_RDONLY);
  lseek(fd, 303L, SEEK_SET);
  nread=read(fd,buf,10);
  for(i = 0; i < 10; i++) {
    *(*(exp_time)+i)=buf[i];}
  close(fd);


  fd = open(name[0], O_RDONLY);
  lseek(fd, 313L, SEEK_SET);
  nread=read(fd,buf,3);
  for(i = 0; i < 3; i++) {
    *(*(hist_un0)+i)=buf[i];}
  close(fd);


  read4byte(views, name, swapbytes, 1, 316L);
  read4byte(vols_added, name, swapbytes, 1, 320L);
  read4byte(start_field, name, swapbytes, 1, 324L);
  read4byte(field_skip, name, swapbytes, 1, 328L);
  read4byte(omax, name, swapbytes, 1, 332L);
  read4byte(omin, name, swapbytes, 1, 336L);
  read4byte(smax, name, swapbytes, 1, 340L);
  read4byte(smin, name, swapbytes, 1, 344L);

}
