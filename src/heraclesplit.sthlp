{smcl}

{p2col:{bf:heraclesplit}} Reconstructing files

{title:Syntax}

{p}

{cmd:heraclesplit} {cmd:using} {it:filename}, {opt todir(string)}

{title:Description}

{pstd}

{cmd:heraclesplit} reconstructs the original directory structure from a merged file created by {cmd:hydramerge}. This command is useful for replicating the project folder structure outside the original environment where the .do files were merged.

{title:Options}

{phang}{opt todir(string)} specifies the target directory to reconstruct the original folder structure. This option is required.

{title:Example}

{hline}


{phang2}{cmd:. local wd = "(your target directory)"}
{phang2}{cmd:. heraclesplit using trade_code.txt, todir("`wd'")}

{pstd}This command reconstructs the original folder structure in the specified target directory.

{hline}