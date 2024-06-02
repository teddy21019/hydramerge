program define heraclesplit

	cap	file close toread
	cap file close dofile

	syntax using/, todir(str)
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
