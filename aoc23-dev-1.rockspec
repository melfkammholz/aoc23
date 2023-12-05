rockspec_format = "3.0"
package = "aoc23"
version = "dev-1"

source = {
  url = "git+ssh://git@github.com/melfkammholz/aoc23.git"
}

description = {
  summary = "Advent of Code 2023 solutions in Lua",
  license = "MIT"
}

build = {
  type = "builtin",
  modules = {
    ["day01.A"] = "day01/A.lua",
    ["day01.B"] = "day01/B.lua",
    ["day02.A"] = "day02/A.lua",
    ["day02.B"] = "day02/B.lua",
    ["day03.A"] = "day03/A.lua",
    ["day03.B"] = "day03/B.lua",
    ["day04.A"] = "day04/A.lua",
    ["day04.B"] = "day04/B.lua",
    ["day05.A"] = "day05/A.lua",
    ["day05.B"] = "day05/B.lua",
    ["util"] = "util.lua"
  }
}

dependencies = {
  "lua >= 5.4",
  "inspect"
}

test_dependencies = {
  "busted"
}

test = {
  type = "busted"
}

