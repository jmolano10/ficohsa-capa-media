xquery version "1.0" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesadora/";

declare function xf:validarTipoRemesadora($ClaveRemesa as xs:string)
    as xs:string {
        let $Year := fn:year-from-date(fn:current-date())
        return
        if (fn:string(fn:number($ClaveRemesa)) != 'NaN') then (
	        if ((fn:string-length($ClaveRemesa) = 10 or 
	        	 fn:string-length($ClaveRemesa) = 11 ) 
	        	 and fn:substring($ClaveRemesa,1,1) = "1") then (
	        	"BTS"
	        ) else if (fn:string-length($ClaveRemesa) = 8) then (
	        	"MONEYGRAM"
	        ) else if (fn:string-length($ClaveRemesa) = 10 and 
	        		   fn:substring($ClaveRemesa,1,1) = "5" and 
	        		   fn:substring($ClaveRemesa,2,1) = fn:substring(fn:string($Year),4,1) ) then ( 
	        	"UNITELLER"
	        ) else if (fn:string-length($ClaveRemesa) = 13) then (
	        	"PACIFIC"
	        ) else (
	        	"NA"
	        )
	    ) else (
        	if ( fn:substring($ClaveRemesa,1,1) = "D") then (
        		"FICOREMESA"
        	) else if (fn:upper-case(fn:substring($ClaveRemesa,1,2)) = "RF") then (
	        	"RIA"
	        ) else (
        		"REMESALOCAL"
        	)
        ) 
};

declare variable $ClaveRemesa as xs:string external;

xf:validarTipoRemesadora($ClaveRemesa)