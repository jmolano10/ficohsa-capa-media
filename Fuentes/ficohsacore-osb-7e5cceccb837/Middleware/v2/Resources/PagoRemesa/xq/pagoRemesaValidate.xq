(:: pragma bea:global-element-parameter parameter="$pagoRemesas1" element="ns0:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaValidate/";

declare function xf:pagoRemesaValidate($pagoRemesas1 as element(ns0:pagoRemesas))
    as xs:string {
        if (fn:string($pagoRemesas1/REMITTANCE_ID/text()) = "" or
        	fn:string($pagoRemesas1/BENEFICIARY_INFO/ID/text()) = "" or
        	fn:string($pagoRemesas1/BENEFICIARY_INFO/ID_TYPE/text()) = "" or
        	fn:string($pagoRemesas1/BENEFICIARY_INFO/CITY/text()) = "" or
        	fn:string($pagoRemesas1/BENEFICIARY_INFO/STATE/text()) = "" or
        	fn:string($pagoRemesas1/BENEFICIARY_INFO/COUNTRY/text()) = "" or
        	fn:string($pagoRemesas1/BENEFICIARY_INFO/PHONE_NUMBER/text()) = "" ) then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else ( 
        	""
        )
};

declare variable $pagoRemesas1 as element(ns0:pagoRemesas) external;

xf:pagoRemesaValidate($pagoRemesas1)