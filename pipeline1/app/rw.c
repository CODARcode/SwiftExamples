
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>

#include <mpi.h>

static int verbosity = 0;
static void verbose(char* fmt, ...);
static void crash(char* fmt, ...);

static void get_args(int argc, char** argv);
static char* input_file = NULL;
static char* output_file = NULL;

static char* slurp(const char* filename);
static void copy(const char* input, const char* output);

int
main(int argc, char* argv[])
{
  get_args(argc, argv);
  copy(input_file, output_file);
  return EXIT_SUCCESS;
}

static void
copy(const char* input, const char* output)
{
  char* data = slurp(input);
  if (data == NULL) crash("could not read: %s", input);
  size_t length = strlen(data)+1;
  FILE* fp = fopen(output, "w");
  if (fp == NULL) crash("could not open for write: %s", output); 
  size_t count = fwrite(data, 1, length, fp);
  if (count != length) crash("could not write: %s", output); 
  fclose(fp);
  free(data);
}

static void
get_args(int argc, char** argv)
{
  if (argc != 3)
    crash("requires 2 arguments -- received %i", argc);
  input_file  = argv[1];
  output_file = argv[2];
}

static void
verbose(char* fmt, ...)
{
  if (verbosity == 0) return;

  printf("py-eval: ");
  va_list ap;
  va_start(ap, fmt);
  vprintf(fmt, ap);
  va_end(ap);
  printf("\n");
  fflush(stdout);
}

static void
crash(char* fmt, ...)
{
  printf("py-eval: abort: ");
  va_list ap;
  va_start(ap, fmt);
  vprintf(fmt, ap);
  va_end(ap);
  printf("\n");

  exit(EXIT_FAILURE);
}

static char*
slurp(const char* filename)
{
  FILE* file = fopen(filename, "r");
  if (file == NULL)
  {
    printf("slurp(): could not read from: %s\n", filename);
    return NULL;
  }

  struct stat s;
  int rc = stat(filename, &s);
  if (rc != 0)
  {
    printf("slurp(): could not stat: %s\n", filename);
    return NULL;
  }

  size_t length = s.st_size;
  char* result = malloc(length+1);
  if (result == NULL)
  {
    printf("slurp(): could not allocate memory for: %s\n", filename);
    return NULL;
  }

  char* p = result;
  size_t actual = fread(p, sizeof(char), length, file);
  if (actual != length)
  {
    printf("could not read all %zi bytes from file: %s\n",
           length, filename);
    free(result);
    return NULL;
  }
  result[length] = '\0';

  fclose(file);
  return result;
}
