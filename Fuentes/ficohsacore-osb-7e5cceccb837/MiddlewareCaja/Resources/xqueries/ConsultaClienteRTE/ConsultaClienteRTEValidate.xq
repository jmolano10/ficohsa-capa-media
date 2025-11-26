(:: pragma bea:global-element-parameter parameter="$consultaClienteRTE" element="ns0:consultaClienteRTE" location="../../xsds/ConsultaClienteRTE/ConsultaClienteRTE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClienteRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaClienteRTE/ConsultaClienteRTEValidate/";

declare function xf:ConsultaClienteRTEValidate($consultaClienteRTE as element(ns0:consultaClienteRTE))
    as xs:string {
        if (fn:string($consultaClienteRTE/CUSTOMER_LEGAL_ID/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        )
};

declare variable $consultaClienteRTE as element(ns0:consultaClienteRTE) external;

xf:ConsultaClienteRTEValidate($consultaClienteRTE)