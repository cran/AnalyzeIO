/* C functions for use in AnalyzeIO*/
/* This is a library of functions that enable ANALYZE image format files to be written from R*/

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <R.h>
#include <string.h>
#include <limits.h>
#define PERMS 0666



void write2byte(int *imp, char **name, int *n)
{
  /* Writes in a sequence of 2 byte short integers */
  FILE *fp;
  short *temp;
  int i;

  temp = Calloc(*n, short);

  for(i = 0; i < *n; i++) {
  *(temp+i)=(short) *(imp+i);
  }

  fp = fopen(name[0], "w");
  
  fwrite(temp,2,*n,fp);

  Free(temp);
  fclose(fp);
}

void writefloat(float *imp, char **name, int *n)
{
  /* Writes a sequence of 4 byte floats  */
  FILE *fp;
  
  fp = fopen(name[0], "w");
  
  fwrite(imp,4,*n,fp);

  fclose(fp);
}



void write_analyze_header(char **name, 
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
			  long *smin)
{

  /*Writes all the fields of a .hdr header file*/
  FILE *fp;
  int i; 
  short dim1[8];

  for(i = 0; i < 8; i++) {
  dim1[i] = (short) *(dim+i);
  }

  fp = fopen(name[0], "w");
  
  fwrite(sizeof_hdr, 4, 1, fp);
  
  for(i = 0; i < 10; i++) {
  fwrite(*(data_type)+i,1,1,fp);
  }

  for(i = 0; i < 18; i++) {
  fwrite(*(db_name)+i,1,1,fp);
  }

  fwrite(extents, 4, 1, fp);

  fwrite(session_error, 2, 1, fp);

  fwrite(*(regular),1,1,fp);
  fwrite(*(hkey_un0),1,1,fp);

  fwrite(&dim1,2,8,fp);

  for(i = 0; i < 4; i++) {
  fwrite(*(vox_units)+i,1,1,fp);
  }

  for(i = 0; i < 8; i++) {
  fwrite(*(cal_units)+i,1,1,fp);
  }

  fwrite(unused1,2,1,fp);

  fwrite(datatype,2,1,fp);

  fwrite(bitpix,2,1,fp);

  fwrite(dim_un0,2,1,fp);


  fwrite(pixdim,4,8,fp);

  fwrite(vox_offset,4,1,fp);

  fwrite(funused1,4,1,fp);

  fwrite(funused2,4,1,fp);

  fwrite(funused3,4,1,fp);

  fwrite(cal_max,4,1,fp);

  fwrite(cal_min,4,1,fp);

  fwrite(compressed,4,1,fp);

  fwrite(verified,4,1,fp);

  fwrite(glmax, 4, 1, fp);

  fwrite(glmin, 4, 1, fp);

  for(i = 0; i < 80; i++) {
  fwrite(*(descrip)+i,1,1,fp);
  }
  for(i = 0; i < 24; i++) {
  fwrite(*(aux_file)+i,1,1,fp);
  }


  fwrite(*orient,1,1,fp);

  for(i = 0; i < 10; i++) {
  fwrite(*(originator)+i,1,1,fp);
  }

  for(i = 0; i < 10; i++) {
  fwrite(*(generated)+i,1,1,fp);
  }

  for(i = 0; i < 10; i++) {
  fwrite(*(scannum)+i,1,1,fp);
  }

  for(i = 0; i < 10; i++) {
  fwrite(*(patient_id)+i,1,1,fp);
  }

  for(i = 0; i < 10; i++) {
  fwrite(*(exp_date)+i,1,1,fp);
  }

  for(i = 0; i < 10; i++) {
  fwrite(*(exp_time)+i,1,1,fp);
  }

  for(i = 0; i < 3; i++) {
  fwrite(*(hist_un0)+i,1,1,fp);
  }

  
  fwrite(views, 4, 1, fp);
  fwrite(vols_added, 4, 1, fp);
  fwrite(start_field, 4, 1, fp);
  fwrite(field_skip, 4, 1, fp);
  fwrite(omax, 4, 1, fp);
  fwrite(omin, 4, 1, fp);
  fwrite(smax, 4, 1, fp);
  fwrite(smin, 4, 1, fp);

  fclose(fp);
}
