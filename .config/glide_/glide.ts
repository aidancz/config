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

glide.prefs.set("general.smoothScroll", true);

glide.o.hint_size = "16px";
glide.o.hint_chars = "kdjflsieowmv";
glide.o.which_key_delay = 0;
glide.o.switch_mode_on_focus = false;

glide.keymaps.set(["normal", "insert"], "<C-w>", () => {});
glide.keymaps.set(["normal", "insert"], "<C-Esc>", "blur");

for (const map of glide.keymaps.list("normal")) {
  if (
    map.lhs.startsWith("g")
    ||
    map.lhs.startsWith("y")
    ||
    map.lhs.startsWith("<leader>")
  ) {
    glide.keymaps.del(map.mode, map.lhs);
  }
}

glide.keymaps.set(["normal", "insert"], "<F1>", "tab_close");
glide.keymaps.set(["normal", "insert"], "<F2><F1>", "quit");
glide.keymaps.set(["normal", "insert"], "<C-F1>", "config_reload");

glide.keymaps.set("normal", "j", "keys <Tab>");
glide.keymaps.set("normal", "k", "keys <S-Tab>");
glide.keymaps.set("normal", "l", "forward");
glide.keymaps.set("normal", "h", "back");

glide.keymaps.set("normal", "f", "scroll_page_down");
glide.keymaps.set("normal", "d", "scroll_page_up");
glide.keymaps.set("normal", "g", "scroll_bottom");
glide.keymaps.set("normal", "s", "scroll_top");

glide.keymaps.set("normal", "<C-f>", "scroll_half_page_down");
glide.keymaps.set("normal", "<C-d>", "scroll_half_page_up");
glide.keymaps.set("normal", "<C-g>", "caret_move down");
glide.keymaps.set("normal", "<C-s>", "caret_move up");

glide.keymaps.set("normal", "i", "tab_next");
glide.keymaps.set("normal", "e", "tab_prev");
glide.keymaps.set("normal", "o", "jumplist_forward");
glide.keymaps.set("normal", "w", "jumplist_back");

glide.keymaps.set("normal", "/", () => glide.findbar.open({mode: "normal", highlight_all: true}));
glide.keymaps.set("normal", "n", () => glide.findbar.next_match());
glide.keymaps.set("normal", "b", () => glide.findbar.previous_match());

glide.keymaps.set("normal", "t", "tab_duplicate");
glide.keymaps.set("normal", "y", "url_yank");

glide.keymaps.set("normal", "m",         "hint");
glide.keymaps.set("normal", "<leader>m", "hint --action=newtab-click");
glide.keymaps.set("normal", "M",         "hint --location=browser-ui");

glide.keymaps.set("normal", "r", "clear");
glide.keymaps.set("normal", "c", "commandline_show tab ");

// glide.keymaps.set("normal", "<Esc>", "blur");

// glide.keymaps.set("normal", "<C-e>", () => {
// });

// glide.keymaps.set(["insert", "visual", "op-pending"], "<Esc>", "mode_change normal; blur");
// glide.keymaps.del(["insert", "visual", "op-pending"], "<Esc>");

const getAllBookmarks = async function() {
  const tree = await browser.bookmarks.getTree();
  const result = [];

  const walk = function(nodes) {
    for (const node of nodes) {
      if (node.url) {
        result.push(node);
      }
      if (node.children) {
        walk(node.children);
      }
    }
  }

  walk(tree);
  return result;
}

glide.keymaps.set("normal", "x", async () => {
  const bookmarks = await getAllBookmarks();
  glide.commandline.show({
    title: "bookmarks",
    options: bookmarks.map((i) => ({
      label: i.title.padEnd(64, ".") + i.url,
      execute: async function() {
        await browser.tabs.create({
          active: true,
          url: i.url,
        });
      },
    })),
  });
});

glide.keymaps.set("normal", "v", async () => {
  const history = await browser.history.search({
    text: "",
    startTime: 0,
    maxResults: 100000000,
  })
  glide.commandline.show({
    title: "history",
    options: history.map((i) => ({
      label: (i.title ?? "").padEnd(64, ".") + i.url,
      execute: async function() {
        await browser.tabs.create({
          active: true,
          url: i.url,
        });
      },
    })),
  });
});

glide.keymaps.set("insert", "<C-w>", "keys <C-BS>");
