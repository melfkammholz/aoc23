local util = require("util")
local tablecmp = util.tablecmp

describe("util", function()
    it("util.tablecmp", function()
      -- less then
      assert.is_true(tablecmp({1}, {2}))
      assert.is_true(tablecmp({1}, {1, 2}))
      assert.is_true(tablecmp({1, 1}, {1, 2}))

      -- equal
      assert.is_false(tablecmp({}, {}))
      assert.is_false(tablecmp({1}, {1}))
      assert.is_false(tablecmp({1, 2}, {1, 2}))

      -- greater than
      assert.is_false(tablecmp({2}, {1}))
      assert.is_false(tablecmp({1, 2}, {1, 1}))
      assert.is_false(tablecmp({1, 2}, {1}))
    end)
end)

