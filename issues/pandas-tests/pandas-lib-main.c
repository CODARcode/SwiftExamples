
#include <stdio.h>
#include <stdlib.h>

#include "pandas-lib.h"

int main()
{
  // Initialize
  printf("pandas-lib.x...\n");
  try_python_pandas();
  printf("pandas-lib.x: success\n");
  return EXIT_SUCCESS;
}
