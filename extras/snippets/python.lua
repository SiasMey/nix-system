local nl = require("ts-utils.node_locator")

---@return boolean
local function in_class()
  local node = vim.treesitter.get_node()
  if not node then
    return false
  end

  local class = nl.find_class_container(node)
  if class then
    return true
  else
    return false
  end
end

---@return boolean
local function in_match()
  local node = vim.treesitter.get_node()
  if not node then
    return false
  end

  while node do
    if node:type() == "match_statement" then
      return true
    end
    node = node:parent()
  end

  return false
end

---@return string
local function add_self_in_class()
  if in_class() then
    return "self"
  else
    return ""
  end
end

return {
  s("cpy", fmt([[# Copyright 2026 HPE.]], {})),
  s(
    "df",
    fmta(
      [[
  def <>(<><>) ->> <>:
      <>
  ]],
      {
        i(1, "function_name"),
        p(add_self_in_class),
        i(2, ""),
        i(3, "None"),
        i(0, "pass"),
      }
    )
  ),
  s(
    "dt",
    fmta(
      [[
  def test_then_<>(<>given: Given<>) ->> None:
      res = given.fut()

      <>
  ]],
      { i(1, "result_expected"), p(add_self_in_class), i(2), i(0) }
    )
  ),
  s(
    "ct",
    fmta(
      [[
  @typing.final
  class TestGiven<>When<>:
      """<>."""
      @classmethod
      def setup_class(cls) ->> None:
          <>
  ]],
      { i(1, "Case"), i(2, "Invoked"), i(3, "Describe Case"), i(0, "pass") }
    )
  ),
  s(
    "cd",
    fmta(
      [[
  @dataclasses.dataclass(frozen=True, slots=True)
  class <>:
      """<>."""
      <>
  ]],
      { i(1, "name"), i(2, "For?"), i(0, "pass") }
    )
  ),
  s("at", fmta([[<>: <>]], { i(1, "prop_name"), i(2, "type") })),
  s("atd", fmta([[<>: <> = <>]], { i(1, "prop_name"), i(2, "type"), i(3, "default") })),
  s(
    "mt",
    fmta(
      [[
  match <>:
      case <>:
          <>
  ]],
      { i(1, "expression"), i(2, "case_expression"), i(0, "pass") }
    )
  ),
  s(
    "cs",
    fmta(
      [[
  case <>:
      <>
      ]],
      { i(1, "case_expression"), i(0, "pass") },
      {
        show_condition = function(_)
          return in_match()
        end,
      }
    )
  ),
  s(
    "ifm",
    fmta(
      [[
      if __name__ == "__main__":
          <>
      ]],
      { i(0) }
    )
  ),
  s(
    "lgi",
    fmta(
      [[
  msg = f"<>"
  logger.<>(msg,<>)]],
      { i(1, "msg"), i(2, "info"), i(0) }
    )
  ),
  s(
    "ttm",
    fmta(
      [[
  import dataclasses

  import pytest


  @dataclasses.dataclass(frozen=True, slots=True)
  class Given:
      <>

  @pytest.fixture
  def given() ->> Given:
      return Given()

  <>
  ]],
      { i(1, "pass"), i(0) }
    )
  ),
}
