
/** NOOP
 *  Very simple MPI program.
 *  Use -v or -v -v for more output.
 */

#define _GNU_SOURCE // for asprintf()
#include <assert.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <unistd.h>

#include <mpi.h>

static int mpi_rank = -1;
static int mpi_size = -1;

static int   delay = -1;
static char* const EMPTY_STRING = "";
static char* label;
static int   verbosity = 0;

static void verbose(char* fmt, ...);

static void scan_opts(int argc, char** argv);

static void time_delay(void);

int
main(int argc, char* argv[])
{
  MPI_Init(0, 0);
  MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

  label = EMPTY_STRING;
  scan_opts(argc, argv);

  if (verbosity == 2 || mpi_rank == 0)
    verbose("rank: %i/%i", mpi_rank, mpi_size);

  if (delay >= 0)
    time_delay();

  if (label != EMPTY_STRING)
    free(label);

  MPI_Finalize();
  return EXIT_SUCCESS;
}

static void
scan_opts(int argc, char** argv)
{
  int c;
  while ((c = getopt (argc, argv, "d:l:v")) != -1)
    switch (c)
    {
      case 'd':
        sscanf(optarg, "%i", &delay);
        break;
      case 'l':
        asprintf(&label, " %s", optarg);
        break;
      case 'v':
        verbosity++;
        break;
      case '?':
        // The system prints an error message
        exit(EXIT_FAILURE);
      default:
        assert(0);
    }
}

static void
verbose(char* fmt, ...)
{
  if (verbosity == 0) return;
  printf("noop%s: ", label);
  va_list ap;
  va_start(ap, fmt);
  vprintf(fmt, ap);
  va_end(ap);
  printf("\n");
  fflush(stdout);
}

static void
time_delay(void)
{
  if (mpi_rank != 0) return;
  time_t t;
  time(&t);
  verbose("start: %i", t);
  sleep(delay);
  time(&t);
  verbose("stop:  %i", t);
}
