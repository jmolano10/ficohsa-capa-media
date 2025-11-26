xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/transferenciasACHNIValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";

declare function xf:transferenciasACHNIValidate($transferenciasACHRequest as element(ns0:transferenciasACHRequest))
    as xs:string {
        if(fn:string($transferenciasACHRequest/ACCOUNT_TYPE/text()) = "" or
       	   fn:string($transferenciasACHRequest/CREDIT_ACCOUNT/text()) = "" or
           fn:string($transferenciasACHRequest/DEBIT_ACCOUNT/text()) = "" or
           fn:string($transferenciasACHRequest/TRANSFER_AMOUNT/text()) = "" or
           fn:string($transferenciasACHRequest/DESTINATION_BANK/text()) = "" or
           fn:string($transferenciasACHRequest/TRANSACTION_DESCRIPTION/text()) = "" or
           fn:string($transferenciasACHRequest/CREDIT_CURRENCY/text()) = "" or
           fn:string($transferenciasACHRequest/BENEFICIARY_NAME/text()) = "" or
           fn:string($transferenciasACHRequest/DEBIT_CREDIT/text())= "" ) then (
            "REQUIRED FIELDS NOT SUPPLIED"
           ) else if (not(fn:string($transferenciasACHRequest/ACCOUNT_TYPE/text()) = ("Savings","Checking","Loanpayment","Creditca"))) then (
	            "INVALID VALUE FOR ACCOUNT TYPE"
           ) else (
        	""
           )
           
};

declare variable $transferenciasACHRequest as element(ns0:transferenciasACHRequest) external;

xf:transferenciasACHNIValidate($transferenciasACHRequest)