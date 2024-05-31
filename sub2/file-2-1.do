//file-2-1




capture program drop easymerge
program define easymerge
		version 11

	    gettoken mtype 0 : 0				// 1:m, 1:1, ...
		gettoken masterid 0 : 0			
		gettoken usingid 0 : 0
		gettoken _using 0 : 0				// just intermediate var
		gettoken data 0: 0, parse(", ")					// using data
		
		
		qui{
			rename `masterid' `usingid'
		}
		
		capture merge `mtype' `usingid' using `data' `0'	
		local errorcode =  _rc

		
		rename `usingid' `masterid'
		
		
		if (_rc != 0){
			error `errorcode'
		}
end


	