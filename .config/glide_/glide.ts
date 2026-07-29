// Config docs:
//
//   https://glide-browser.app/config
//
// API reference:
//
//   https://glide-browser.app/api
//
// Default config files can be found here:
//
//   https://github.com/glide-browser/glide/tree/main/src/glide/browser/base/content/plugins
//
// Most default keymappings are defined here:
//
//   https://github.com/glide-browser/glide/blob/main/src/glide/browser/base/content/plugins/keymaps.mts
//
// Try typing `glide.` and see what you can do!

glide.o.hint_size = "16px";
glide.o.hint_chars = "kdjflsieowmv";
glide.o.which_key_delay = 0;
glide.o.switch_mode_on_focus = true;

// for (const map of glide.keymaps.list("normal")) {
//   if (map.lhs.startsWith("g") || map.lhs.startsWith("y")) {
//     glide.keymaps.del(map.mode, map.lhs);
//   }
// }

glide.keymaps.set("normal", "<F1>", "tab_close");
glide.keymaps.set("normal", "<F2><F1>", "quit");

glide.keymaps.set("normal", "f", "scroll_page_down");
glide.keymaps.set("normal", "d", "scroll_page_up");
glide.keymaps.set("normal", "g", "scroll_bottom");
glide.keymaps.set("normal", "s", "scroll_top");

glide.keymaps.set("normal", "j", "caret_move down");
glide.keymaps.set("normal", "k", "caret_move up");
glide.keymaps.set("normal", "l", "caret_move right");
glide.keymaps.set("normal", "h", "caret_move left");

glide.keymaps.set("normal", "t", "tab_duplicate");
glide.keymaps.set("normal", "y", "url_yank");

glide.keymaps.set("normal", "r", "clear");

// glide.keymaps.set("normal", "<Esc>", "blur");

// glide.keymaps.set("normal", "<C-e>", () => {
// });

// glide.keymaps.set(["insert", "visual", "op-pending"], "<Esc>", "mode_change normal; blur");
// glide.keymaps.del(["insert", "visual", "op-pending"], "<Esc>");
