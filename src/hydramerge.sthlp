{smcl}

{**! version 0.1 2024}

{p2col:{bf:hydramerge}} Integration of files

{title:Syntax}

{p}

{cmd:hydramerge}{cmd:,} {opt fromdir(string)} {opt saving(string)} [ {opt pattern(string)} {opt replace}]

{title:Description}

{pstd}

{cmd:hydramerge} integrates all .do files from the specified directory and its subdirectories into a single target file. This command is useful for organizing and consolidating Stata code files from a project into one comprehensive file. The resulting file will contain tags indicating the original location of each integrated .do file.

{title:Options}

{phang}{opt fromdir(string)} specifies the root directory from which .do files will be integrated. This option is required.

{phang}{opt saving(string)} specifies the name of the file to save the integrated .do files. This option is required.

{phang}{opt pattern(string)} allows you to specify a pattern to filter the files to be integrated. This option is optional.

{phang}{opt replace} allows the target file to be replaced if it already exists. This option is optional.

{title:Example}

{hline}


{phang2}{cmd:. hydramerge, fromdir(project_trade) saving(trade_code) replace}

{pstd}This command integrates all .do files from the `project_trade` directory into a file named `trade_code.txt`, replacing it if it already exists. The resulting file will contain the content of each .do file wrapped in a tag with an attribute indicating its original relative location.