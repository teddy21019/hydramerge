# HydraMerge and HeracleSplit

`hydramerge` is a lightweight Stata program that integrates all source code from a folder and its subfolders into a single text file. The package also provides a decoder, `heraclesplit`, to reconstruct the project structure from the combined text file.

# Why Even Bother Doing This?

While its functionality may seem superfluous, this packages is extremely useful if exporting a project from a restricted data center necessitates substantial amount of paperwork, which grows proportionally with the file count.

Empirical research typically involves multiple do-files with specific tasks, such as data wrangling, descriptive statistics, baseline analysis and some robustness checks. For a well designed Stata project, such as those published in the top-tier journals, do-files are written with high-coheision, where each do-file concentrates in one dedicated task. This design usually comes with even more separated do files which are integrated in a master do-file.

To reduce time in filling in the paperwork, it is optimal to integrate all files into a single text file. This could be done manually, but as the project expands, with files locating in subfolders within subfolders, this process can be annoying and error-prone.

To automate this procedure, I developed two simple commands -- `hydramerge` and `heraclesplit`.

# HydraMerge -- Integrating files

Consider the following directory tree:

```
project_trade/
    |---master.do
    |programs/
        |---cleaning.do
        |---baselines/
            |---OLS.do
            |---IV.do
```

`hydramerge` integrates all do files into a target file with the following command:

```

hydramerge, fromdir(project_trade) saving(trade_code) replace
```

This creates (and replaces) a file `trade_code.txt`, which integrates all do files from folder `project_trade`.

The file `trace_code.txt` wraps all do-files in an tag, with an attribute indicating its original relative location:

```
<file path = 'programs/baselines/OLSs.do'>
/* file content here */
</file>

<file path = 'programs/baseline/IV.do'>
/* file content here */
</file>
```

# HeracleSplit -- Reconstruct the Integrated File

One the merged file is brought out of the data center, use the command `heraclesplit` to reconstruct the entire folder:

```
local wd = "(your target directory)"
heraclesplit using trade_code.txt, todir("`wd'")
```

This command then creates a replication of the original project folder originally located in the data center.