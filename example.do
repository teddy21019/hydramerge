* start from the current directory
local cdir = "C:\Users\tedb0\Documents\Code\manydo"

cd "C:\Users\tedb0\Documents\Code"

* list all files
hydramerge, fromdir("`cdir'") saving(dirs) replace
heraclesplit using dirs.txt, todir("C:\Users\tedb0\Documents\Code\recovermanydo")