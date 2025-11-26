(:: pragma bea:global-element-parameter parameter="$pagoChequeCajaFCY" element="ns0:pagoChequeCajaFCY" location="../../xsds/PagoChequeCajaFCY/PagoChequeCajaFCY.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoChequeCajaFCYTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoChequeCajaFCY/PagoChequeCajaFCYValidate/";

declare function xf:PagoChequeCajaFCYValidate($pagoChequeCajaFCY as element(ns0:pagoChequeCajaFCY))
    as xs:string {
        if (fn:string($pagoChequeCajaFCY/CHECK_CURRENCY/text()) = "" or 
        	fn:string($pagoChequeCajaFCY/CHECK_AMOUNT/text()) = "" or 
        	fn:string($pagoChequeCajaFCY/CHECK_NUMBER/text()) = "" or 
        	fn:string($pagoChequeCajaFCY/BANK_CODE/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        ) else (
        	""
        )
};

declare variable $pagoChequeCajaFCY as element(ns0:pagoChequeCajaFCY) external;

xf:PagoChequeCajaFCYValidate($pagoChequeCajaFCY)