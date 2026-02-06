xquery version "2004-draft" encoding "Cp1252";

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesaLocal/";

declare function xf:validarTipoRemesaLocal($ClaveRemesa as xs:string)
    as xs:string {
        if ( fn:substring($ClaveRemesa,1,2) = "LX") then (
        	"DOLEX"
        ) else if ( fn:substring($ClaveRemesa,1,2) = "RF") then (
        	"RIA"
        ) else if ( fn:substring($ClaveRemesa,1,3) = ("FCX","FTL","FOR","FNJ","TAM","CHA","BRX","HEM","HST","PLF","GNA","NBW","NWO","FNW")) then (
        	"FICOEXP"
        ) else if ( fn:substring($ClaveRemesa,1,3) = "GPX") then (
        	"GROUPEX"
        ) else if ( fn:substring($ClaveRemesa,1,2) = ("RT","US") or 
        			fn:substring($ClaveRemesa,1,3) = ("GMT","IDT")) then (
        	"REMTRAS"
       	) else if ( fn:substring($ClaveRemesa,1,2) = "TF") then (
       		"TRANSFAST"
       	) else if ( fn:substring($ClaveRemesa,1,3) = "SIG") then (
       		"SIGUE"
       	) else if ( fn:substring($ClaveRemesa,1,2) = "GS") then (
       		"GIROSOL"
       	) else (
       		"REMESA NO IDENTIFICADA"
       	)
       	
};

declare variable $ClaveRemesa as xs:string external;

xf:validarTipoRemesaLocal($ClaveRemesa)