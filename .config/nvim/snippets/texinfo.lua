return
{
	{
		body =
[[
\input texinfo

@node Top
@top $TM_FILENAME_BASE

$0

@bye]],
		prefix = [[\]],
	},
	{
		body =
[[
@dircategory ${1:default}
@direntry
* $TM_FILENAME_BASE: ($TM_FILENAME_BASE).
@end direntry]],
		prefix = "dd",
	},
	{
		body =
[[
@node ${1:name}
@chapter $1]],
		prefix = "nc",
	},
	{
		body =
[[
@node ${1:name}
@section $1]],
		prefix = "ns",
	},
	{
		body =
[[
@node ${1:name}
@subsection $1]],
		prefix = "nss",
	},
	{
		body =
[[
@example ${1:lang}
$0
@end example]],
		prefix = "e",
	},
	{
		body =
[[
@verbatim
$0
@end verbatim]],
		prefix = "v",
	},
-- 	{
-- 		body =
-- [[
-- @example ${1:lang}
-- @verbatim
-- $0
-- @end verbatim
-- @end example]],
-- 		prefix = "ev",
-- 	},
	{
		body =
[[
@display
$0
@end display]],
		prefix = "d",
	},
	{
		body =
[[
@format
$0
@end format]],
		prefix = "f",
	},
}
