(:: pragma bea:global-element-parameter parameter="$transferenciaCuentasRequest" element="ns0:transferenciaCuentasRequest" location="transferenciaCuentasType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasEntreCuentas/transferenciaCuentasValidate/";

declare function xf:transferenciaCuentasValidate($transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest))
    as xs:string {
        if (fn:string($transferenciaCuentasRequest/DEBIT_ACCOUNT/text()) = "" or 
        	fn:string($transferenciaCuentasRequest/CREDIT_ACCOUNT/text()) = "" or 
        	fn:string($transferenciaCuentasRequest/TRANSFER_AMOUNT/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if (not(fn:string($transferenciaCuentasRequest/DEBIT_CREDIT/text()) = ("DEBIT","CREDIT",""))) then (
        	"DEBIT_CREDIT NOT SUPPORTED"
        	
        ) else (
        	""
        )
};

declare variable $transferenciaCuentasRequest as element(ns0:transferenciaCuentasRequest) external;

xf:transferenciaCuentasValidate($transferenciaCuentasRequest)