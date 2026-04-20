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
	{
		body =
[[
@example ${1:lang}
@verbatim
$0
@end verbatim
@end example]],
		prefix = "ev",
	},
	{
		body =
[[
@display
$0
@end display]],
		prefix = "d",
	},
}
