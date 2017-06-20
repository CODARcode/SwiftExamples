
#include <errno.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>

#include <mpi.h>

static int verbosity = 1;
static void verbose(char* fmt, ...);
static void crash(char* fmt, ...);
static void crash_perror(char* fmt, ...);

static void get_args(int argc, char** argv);
static char* input_file = NULL;
static char* output_file = NULL;

static void copy(const char* input, const char* output);

static int mpi_rank = 0;

int
main(int argc, char* argv[])
{
  MPI_Init(0, 0);
  MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
  if (mpi_rank == 0)
  {
    get_args(argc, argv);
    copy(input_file, output_file);
  }
  MPI_Finalize();
  return EXIT_SUCCESS;
}

static void wait_for_file(const char* filename);
static char* slurp(const char* filename);

static void
copy(const char* input, const char* output)
{
  wait_for_file(input);
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
wait_for_file(const char* filename)
{
  while (true)
  {
    struct stat s;
    verbose("checking for file: %s", filename);
    int rc = stat(filename, &s);
    if (rc == 0)
      break;
    if (errno == ENOENT)
    {
      sleep(1);
      continue;
    }
    else
      crash_perror("failed waiting for file: %s", filename);
  }
}

static void
get_args(int argc, char** argv)
{
  if (argc != 3)
    crash("requires 2 arguments -- received %i", argc-1);
  input_file  = argv[1];
  output_file = argv[2];
}

static void
verbose(char* fmt, ...)
{
  if (verbosity == 0) return;

  printf("rw: ");
  va_list ap;
  va_start(ap, fmt);
  vprintf(fmt, ap);
  va_end(ap);
  printf("\n");
  fflush(stdout);
}

static void vcrash(const char* fmt, va_list ap);
#define VCRASH va_list ap; va_start(ap, fmt); vcrash(fmt, ap);
static void
crash(char* fmt, ...)
{
  VCRASH;
}
static void
crash_perror(char* fmt, ...)
{
  perror("encountered error");
  VCRASH;
}
static void
vcrash(const char* fmt, va_list ap)
{
  printf("rw: abort: ");
  vprintf(fmt, ap);
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
