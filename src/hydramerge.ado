cap program drop hydramerge 
cap program drop heraclesplit
cap	file close toread
cap file close concated
cap file close dofile

program define heraclesplit

	cap	file close toread
	cap file close dofile
	
	syntax using/, todir(str)
	
	file open toread using "`using'", read
	
	file read toread line
	
	local reading = 0
	
	while r(eof) == 0{
// 		di as error `"`line'"'
		// find a new file, having <file_start path='`filepath''>
		if regexm(`"`line'"', "<file_start path='([^']*)'>"){	
			local path = regexs(1) 
		
			// try make folder if not exist
			if regexm(`"`path'"', "^.*[\\/]"){
				local this_dir = regexs(0)
				cap mkdir "`todir'/`this_dir'"
			}
			local reading = 1
			file open dofile using "`todir'/`path'", write append
		}
		
		// if </file_start>, then close this dofile
		else if regexm(`"`line'"', "^</file_start>"){
			file close dofile
			local reading = 0

		}
		
		//write contents into the coresponding directory
		else if (`reading' == 1){
			file write dofile `"`line'"' _n
		}

	
		file read toread line

		
	}  // while end of file
	
	file close _all
end


program define hydramerge

	cap	file close toread
	cap file close concated
	
  syntax , fromdir(string) saving(string)  ///
    [pattern(string) PREfix(string) _masterdir(string) replace]

	if "`replace'" != ""{
		capture erase "`saving'.txt"
	}
	// get files in "`fromdir'" using pattern
	if "`pattern'" == "" local pattern "*.do"
	if "`_masterdir'" == "" local _masterdir = "`fromdir'"
	local flist: dir "`fromdir'" files "`pattern'"

	foreach f of local flist{
	// write whatever in the file into a saving file
	local filepath = "`prefix'/`f'"

	file open concated using `saving'.txt, write text append

	file write concated `"<file_start path='`filepath''>"' _n

	file open toread using "`_masterdir'/`filepath'", read
	file read toread line
	while r(eof) == 0{
		file write concated `"`line'"' _n
		file read toread line
	}

	file write concated "</file_start>" _n _n

	file close toread
	file close concated
	}


	// recursively list directories in "`fromdir'"
	local dlist: dir "`fromdir'" dirs "*"
	foreach d of local dlist {
		hydramerge , fromdir("`fromdir'/`d'") saving(`saving') ///
		pattern("`pattern'") prefix(`prefix'/`d') _masterdir(`_masterdir')
	}


  
end

* start from the current directory
local cdir = "C:\Users\tedb0\Documents\Code\manydo"

cd "C:\Users\tedb0\Documents\Code"

* list all files
hydramerge, fromdir("`cdir'") saving(dirs) replace
heraclesplit using dirs.txt, todir("C:\Users\tedb0\Documents\Code\recovermanydo")