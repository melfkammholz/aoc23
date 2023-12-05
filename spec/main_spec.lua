local util = require("util")

describe("util", function()
    it("util.tablecmp", function()
      -- less then
      assert.is_true(util.tablecmp({1}, {2}))
      assert.is_true(util.tablecmp({1}, {1, 2}))

      -- equal
      assert.is_false(util.tablecmp({}, {}))
      assert.is_false(util.tablecmp({1}, {1}))
      assert.is_false(util.tablecmp({1, 2}, {1, 2}))

      -- greater than
      assert.is_false(util.tablecmp({2}, {1}))
      assert.is_false(util.tablecmp({1, 2}, {1}))
    end)
end)

