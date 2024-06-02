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

		file write concated `"<file path='`filepath''>"' _n

		file open toread using "`_masterdir'/`filepath'", read
		file read toread line
		while r(eof) == 0{
			file write concated `"`line'"' _n
			file read toread line
		}

		file write concated "</file>" _n _n

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