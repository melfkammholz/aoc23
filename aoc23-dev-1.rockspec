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
    ["day06.A"] = "day06/A.lua",
    ["day06.B"] = "day06/B.lua",
    ["day07.A"] = "day07/A.lua",
    ["day07.B"] = "day07/B.lua",
    ["day08.A"] = "day08/A.lua",
    ["day08.B"] = "day08/B.lua",
    ["day09.A"] = "day09/A.lua",
    ["day09.B"] = "day09/B.lua",
    ["day10.A"] = "day10/A.lua",
    ["day10.B"] = "day10/B.lua",
    ["util"] = "util.lua"
  }
}

dependencies = {
  "lua >= 5.4",
  "fun",
  "lanes",
  "inspect"
}

test_dependencies = {
  "busted"
}

test = {
  type = "busted"
}

