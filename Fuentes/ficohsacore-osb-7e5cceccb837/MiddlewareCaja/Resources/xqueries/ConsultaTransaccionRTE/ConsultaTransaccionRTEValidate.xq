(:: pragma bea:global-element-parameter parameter="$consultaTransaccionRTE" element="ns0:consultaTransaccionRTE" location="../../xsds/ConsultaTransaccionRTE/ConsultaTransaccionRTE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTransaccionRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaTransaccionRTE/ConsultaTransaccionRTEValidate/";

declare function xf:ConsultaTransaccionRTEValidate($consultaTransaccionRTE as element(ns0:consultaTransaccionRTE))
    as xs:string {
        if (fn:string($consultaTransaccionRTE/TRANSACTION_ID/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
		) else if ( not( substring($consultaTransaccionRTE/TRANSACTION_ID/text(), 1, 2) = "TT" or
						 substring($consultaTransaccionRTE/TRANSACTION_ID/text(), 1, 3) = "TFS") ) then (
			"ONLY AVAILABLE FOR TT AND TFS TRANSACTION"
		        	
        ) else (
        	""
        )
};

declare variable $consultaTransaccionRTE as element(ns0:consultaTransaccionRTE) external;

xf:ConsultaTransaccionRTEValidate($consultaTransaccionRTE)