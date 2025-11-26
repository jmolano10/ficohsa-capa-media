(:: pragma bea:global-element-parameter parameter="$guardarClienteRTE" element="ns0:guardarClienteRTE" location="../../xsds/GuardarClienteRTE/GuardarClienteRTE.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/guardarClienteRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/GuardarClienteRTE/GuardarClienteRTEValidate/";

declare function xf:GuardarClienteRTEValidate($guardarClienteRTE as element(ns0:guardarClienteRTE))
    as xs:string {
        if (fn:string($guardarClienteRTE/TYPE_ID/text()) = "" or 
        	fn:string($guardarClienteRTE/ID_NUMBER/text()) = "" or 
        	fn:string($guardarClienteRTE/FULL_NAME/text()) = "" or 
        	fn:string($guardarClienteRTE/GENDER/text()) = "" or 
        	fn:string($guardarClienteRTE/COUNTRY/text()) = "" or 
        	fn:string($guardarClienteRTE/NATIONALITY/text()) = "" or 
        	fn:string($guardarClienteRTE/DEPARTMENT/text()) = "" or 
        	fn:string($guardarClienteRTE/MUNICIPALITY/text()) = "" or 
        	fn:string($guardarClienteRTE/ADDRESS/text()) = "" or
        	fn:string($guardarClienteRTE/PROFESSION/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $guardarClienteRTE as element(ns0:guardarClienteRTE) external;

xf:GuardarClienteRTEValidate($guardarClienteRTE)