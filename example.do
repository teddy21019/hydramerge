* start from the current directory

// cd "project file"

local cwd: pwd

hydramerge, fromdir(test_source) saving (project_code) replace
heraclesplit using project_code.txt, todir("`cwd'/test_target")


* Must add force if folder contains files or dirs.
* Use this command carefully as this cocatenates on old files.
heraclesplit using project_code.txt, todir("$cwd/test_target") force