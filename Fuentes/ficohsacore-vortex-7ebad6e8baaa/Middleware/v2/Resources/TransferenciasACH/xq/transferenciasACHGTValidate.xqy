xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/transferenciasACH/xq/transferenciasACHValidate/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";

declare function xf:transferenciasACHValidate($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest))
    as xs:string {
        if(fn:string($transferenciasACHRequest1/DEBIT_ACCOUNT/text()) = "" or
           fn:string($transferenciasACHRequest1/DESTINATION_BANK/text()) = "" or
           fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "" or
           fn:string($transferenciasACHRequest1/CREDIT_ACCOUNT/text()) = "" or
           fn:string($transferenciasACHRequest1/BENEFICIARY_NAME/text()) = "" or
           fn:string($transferenciasACHRequest1/TRANSFER_AMOUNT/text()) = "" or
           fn:string($transferenciasACHRequest1/TRANSACTION_DESCRIPTION/text()) = "") then (
            "REQUIRED FIELDS NOT SUPPLIED"
           ) else (
        	""
           )
           
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;

xf:transferenciasACHValidate($transferenciasACHRequest1)