
/** NOOP
 *  Very simple MPI program.
 *  Use -v or -v -v for more output.
 */

#include <assert.h>
#include <ctype.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <mpi.h>

static int mpi_rank = -1;
static int mpi_size = -1;

void scan_opts(int argc, char** argv);

static int verbosity = 0;
static void verbose(char* fmt, ...);

int
main(int argc, char* argv[])
{
  MPI_Init(0, 0);
  MPI_Comm_rank(MPI_COMM_WORLD, &mpi_rank);
  MPI_Comm_size(MPI_COMM_WORLD, &mpi_size);

  scan_opts(argc, argv);

  if (verbosity == 2 || mpi_rank == 0)
    verbose("rank: %i/%i", mpi_rank, mpi_size);

  MPI_Finalize();
  return EXIT_SUCCESS;
}

void
scan_opts(int argc, char** argv)
{
  int c;
  while ((c = getopt (argc, argv, "v")) != -1)
    switch (c)
    {
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
  printf("noop: ");
  va_list ap;
  va_start(ap, fmt);
  vprintf(fmt, ap);
  va_end(ap);
  printf("\n");
  fflush(stdout);
}
