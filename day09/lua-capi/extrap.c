#include <stdlib.h>

#include "lua.h"
#include "lauxlib.h"
#include "lualib.h"

static int solve(lua_State *L) {
  lua_Unsigned n = lua_rawlen(L, -1);

  // read data
  lua_Integer *a = (lua_Integer*) malloc(sizeof(lua_Integer) * n);
  for (int i = 1; i <= n; i++) {
    lua_rawgeti(L, -1, i);
    if (lua_isinteger(L, -1)) {
      a[i - 1] = lua_tointeger(L, -1);
    }
    lua_pop(L, 1);
  }

  // compute extrapolation
  lua_Integer res = 0;
  for (lua_Unsigned i = 0; i < n; i++) {
    res += a[n - i - 1];
    for (lua_Unsigned j = 0; j < n - i - 1; j++)
      a[j] = a[j + 1] - a[j];
  }
  lua_pushinteger(L, res);

  free(a);

  return 1;
}

static const struct luaL_Reg libs [] = {
	{"solve", solve},
	{NULL, NULL}
};

int luaopen_extrap(lua_State *L) {
	luaL_newlib(L, libs);
	return 1;
}

