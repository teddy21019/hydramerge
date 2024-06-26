# HydraMerge and HeracleSplit
![](https://repository-images.githubusercontent.com/808578896/dfcd4f20-17a0-4f09-94d0-f6d338e870a7)

`hydramerge` is a lightweight Stata program that integrates all source code from a folder and its subfolders into a single text file. The package also provides a decoder, `heraclesplit`, to reconstruct the project structure from the combined text file.

# Why Even Bother?

While its functionality may seem superfluous, this packages is extremely useful if exporting a project from a restricted data center necessitates substantial amount of paperwork, which increases proportionally with the file count.

Empirical research typically involves multiple do-files, each dedicated to  specific tasks like data wrangling, descriptive statistics, baseline analysis and robustness checks. In a well designed Stata project, such as those published in top-tier journals, do-files are written with high-cohesion, where each do-file concentrates on a singular task. This design usually results in a greater number of do files, alll orchestrated through a master do-file.

To minimize the time spent on paperwork, it is advisable to consolidate all files into a single text file. While this could be accomplished manually, the task becomes tedious and susceptible to errors as the project grows and files are nested with multiple folders.

To automate this procedure, I developed two simple commands -- `hydramerge` and `heraclesplit`, akin to Hydra's multiple heads and Heracles' legendary feats drawn on the Greek mythology.

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

Once the merged file is brought out of the data center, use the command `heraclesplit` to reconstruct the entire project folder created by `hydramerge`:

```
local wd = "(your target directory)"
heraclesplit using trade_code.txt, todir("`wd'")
```

This command then creates a replication of the original project.

# Future Work
- Beyond `.do` files. Currently the command supports only do files. I haven't found a way to let `local dlist: dir "xxx" files "*" work with other filespec.
- A `.gitignore` like functionality that ignores files matching certain pattern. (Looking for a `Stata` implementation)