glide.keymaps.set("normal", "c", "commandline_show tab ");

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
