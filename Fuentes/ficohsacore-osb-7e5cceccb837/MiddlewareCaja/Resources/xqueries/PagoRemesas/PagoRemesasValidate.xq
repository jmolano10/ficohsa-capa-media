(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns0:pagoRemesas" location="../../xsds/PagoRemesas/PagoRemesas.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRemesas/PagoRemesasValidate/";

declare function xf:PagoRemesasValidate($pagoRemesas as element(ns0:pagoRemesas))
    as xs:string {
        if (fn:string($pagoRemesas/REMITTANCE_ID/text()) = "" or
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_ID/text()) = "" or
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_ID_TYPE/text()) = "" or 
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_CITY/text()) = "" or  
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_STATE/text()) = "" or
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_COUNTRY/text()) = "" or 
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_PHONE_NUMBER/text()) = "" or 
        	fn:string($pagoRemesas/BENEFICIARY_INFO/BENEF_ADDRESS/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $pagoRemesas as element(ns0:pagoRemesas) external;

xf:PagoRemesasValidate($pagoRemesas)