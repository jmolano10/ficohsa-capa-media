(:: pragma bea:global-element-parameter parameter="$consultaReciboTransaccionRTE" element="ns0:consultaReciboTransaccionRTE" location="../../xsds/ConsultaReciboTransaccionRTE/ConsultaReciboTransaccionRTE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaReciboTransaccionRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboTransaccionRTE/ConsultaReciboTransaccionRTEValidate/";

declare function xf:ConsultaReciboTransaccionRTEValidate($consultaReciboTransaccionRTE as element(ns0:consultaReciboTransaccionRTE))
    as xs:string {
        if (fn:string($consultaReciboTransaccionRTE/TRANSACTION_ID/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
		) else if ( not(fn:substring($consultaReciboTransaccionRTE/TRANSACTION_ID, 1, 3) = "TFS" or fn:substring($consultaReciboTransaccionRTE/TRANSACTION_ID, 1, 2) = "TT") ) then (
			"ONLY AVAILABLE FOR TT OR TFS TRANSACTIONS"
		        	
        ) else (
        	""
        )
};

declare variable $consultaReciboTransaccionRTE as element(ns0:consultaReciboTransaccionRTE) external;

xf:ConsultaReciboTransaccionRTEValidate($consultaReciboTransaccionRTE)