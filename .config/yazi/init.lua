require("session"):setup {
	sync_yanked = true,
}



THEME.git = THEME.git or {}

THEME.git.added_sign     = "A"
THEME.git.deleted_sign   = "D"
THEME.git.ignored_sign   = "I"
THEME.git.modified_sign  = "M"
THEME.git.untracked_sign = "?"
THEME.git.updated_sign   = "U"

THEME.git.added     = ui.Style():fg("")
THEME.git.deleted   = ui.Style():fg("")
THEME.git.ignored   = ui.Style():fg("")
THEME.git.modified  = ui.Style():fg("")
THEME.git.untracked = ui.Style():fg("")
THEME.git.updated   = ui.Style():fg("")

require("git"):setup()



require("zoxide"):setup({
	update_db = true,
})



require("starship"):setup()
