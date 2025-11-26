(:: pragma bea:global-element-parameter parameter="$depositoChequeCajaFCY" element="ns0:depositoChequeCajaFCY" location="../../xsds/DepositoChequeCajaFCY/DepositoChequeCajaFCY.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeCajaFCYTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeCajaFCY/DepositoChequeCajaFCYValidate/";

declare function xf:DepositoChequeCajaFCYValidate($depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY))
    as xs:string {
        if (fn:string($depositoChequeCajaFCY/CHECK_CURRENCY/text()) = "" or 
        	fn:string($depositoChequeCajaFCY/CHECK_AMOUNT/text()) = "" or 
        	fn:string($depositoChequeCajaFCY/CHECK_NUMBER/text()) = "" or 
        	fn:string($depositoChequeCajaFCY/BANK_CODE/text()) = "" or 
        	fn:string($depositoChequeCajaFCY/DEPOSIT_ACCOUNT/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        	
        )
};

declare variable $depositoChequeCajaFCY as element(ns0:depositoChequeCajaFCY) external;

xf:DepositoChequeCajaFCYValidate($depositoChequeCajaFCY)