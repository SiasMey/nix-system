return {
  s("fmt", fmta('s("<>", fmt([[<>]], {<>})),', { i(1, "trigger"), i(2, "fmtstr-{}"), i(3, "nodes") })),
  s("fmta", fmta('s("<>", fmta([[<>]], {<>})),', { i(1, "trigger"), i(2, "fmtstr-<>"), i(3, "nodes") })),
}
