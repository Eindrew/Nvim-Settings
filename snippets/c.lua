local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt -- For easier formatting

return {
	s("labhead", {
		t({ "/**", "* @file    " }),
		i(1, "filename.c"),
		t({ "", "*", "* @author  " }),
		i(2, "Your Name"),
		t({ "", "*", "* @date    " }),
		i(3, "Date"),
		t({ "", " */", "" }),
		t({ "", "" }),
		t({ "// **** Include libraries here ****", "" }),
		t({ "// Standard libraries.", "#include <stdint.h>", "#include <stdio.h>", "" }),
		t({ "", "" }),
		t({
			"// Course library.",
			"#include <Adc.h>",
			"#include <Ascii.h>",
			"#include <BOARD.h>",
			"#include <Buttons.h>",
			"#include <Leds.h>",
			"#include <Oled.h>",
			"#include <Timers.h>",
			"",
		}),

		i(0),
	}, {
		descr = "Setup Lab documents",
	}),
}
