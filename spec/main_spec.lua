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

  it("util.heap", function()
    for n = 1, 50 do
      local h = util.heap:new(function(a, b) return a < b end)
      local a = {}
      for _ = 1, n do
        a[#a + 1] = math.random(1, n * 10)
        h:push(a[#a])
      end
      table.sort(a)
      for i = 1, n do
        assert.is_equal(a[i], h:pop())
      end
    end
  end)

end)

