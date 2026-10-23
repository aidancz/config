return
{
	{
		body =
[[
\input texinfo

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
@top $TM_FILENAME_BASE]],
		prefix = "t",
	},
	{
		body =
[[
${0|@chapter ,@unnumbered ,@appendix ,@chapheading |}]],
		prefix = "#",
	},
	{
		body =
[[
${0|@section ,@unnumberedsec ,@appendixsec ,@heading |}]],
		prefix = "##",
	},
	{
		body =
[[
${0|@subsection ,@unnumberedsubsec ,@appendixsubsec ,@subheading |}]],
		prefix = "###",
	},
	{
		body =
[[
${0|@subsubsection ,@unnumberedsubsubsec ,@appendixsubsubsec ,@subsubheading |}]],
		prefix = "####",
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
@${1:name}
$0
@end $1]],
		prefix = "s",
	},
}
