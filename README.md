# HydraMerge and HeracleSplit

`hydramerge` is a lightweight Stata program that integrates all source code from a folder and its subfolders into a single text file. The package also provides a decoder, `heraclesplit`, to reconstruct the project structure from the combined text file.

# Why Even Bother Doing This?

As its functionality might look useless, this packages is extremely useful if bringing out a project from a restricted data center requires substantial amount of paperwork, which scales with the number of files.

An empirical work typically contains multiple do files with separated tasks, such as data wrangling, descriptive statistics, baseline analysis and some robustness check. For a well designed Stata project, such as those published in the top 5, do-files are written in a highly-cohesive manner; each do-file focuses on one simple task. This design usually comes with even more separated do files which are integrated in a master do-file.

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

This creates (and replace) a file `trade_code.txt`, which integrates all do files from folder `project_trade`.

The file `trace_code.txt`

