program define heraclesplit

	cap	file close toread
	cap file close dofile

	syntax using/, Todir(string) [force]

	cap mkdir "`todir'"
	local dir_exist = _rc != 0

	local  dlist: dir "`todir'" dirs "*"
	local  flist: dir "`todir'" file "*.do"
	local dir_not_empty = `"`dlist'`flist'"' != ""

	if (`dir_not_empty'){
		if "`force'" == ""{		// if no option force
			di as error "Folder `todir' already exist!  Please specify option {opt force} to force procedere. Note that contents might be concatenating on existing files."
			error 602
		}
		else{
			di as error "WARNING!!! Folder `todir' already exist! Contents might be concatenating on existing files. "
		}
	}

	file open toread using "`using'", read

	file read toread line

	local reading = 0

	while r(eof) == 0{
		// find a new file, having <file_start path='`filepath''>
		if regexm(`"`line'"', "<file path='([^']*)'>"){
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
		else if regexm(`"`line'"', "^</file>"){
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
