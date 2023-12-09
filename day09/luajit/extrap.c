#include <stdio.h>
#include <stdint.h>

int solve(int *a, int n) {
  int res = 0;
  for (int i = 0; i < n; i++) {
    res += a[n - i - 1];
    for (int j = 0; j + 1 < n - i; j++) {
      a[j] = a[j + 1] - a[j];
    }
  }
  return res;
}

