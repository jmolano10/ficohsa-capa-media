<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns0:transferenciasACHRequest" location="transferenciasACHType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Transferencias/TransferenciasACH/transferenciasACHValidate/";

declare function xf:transferenciasACHValidate($transferenciasACHRequest1 as element(ns0:transferenciasACHRequest))
    as xs:string {
        if (fn:string($transferenciasACHRequest1/DEBIT_ACCOUNT/text()) != "" and
        	fn:string($transferenciasACHRequest1/DESTINATION_BANK/text()) != "" and
        	fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) != "" and
        	fn:string($transferenciasACHRequest1/CREDIT_ACCOUNT/text()) != "" and
        	fn:string($transferenciasACHRequest1/BENEFICIARY_NAME/text()) != "" and
        	fn:string($transferenciasACHRequest1/TRANSFER_AMOUNT/text()) != "" and
        	fn:string($transferenciasACHRequest1/TRANSACTION_DESCRIPTION/text()) != "" ) then (
        	""
        ) else (
        	"REQUIRED FIELDS NOT SUPPLIED"
        )
        	
};

declare variable $transferenciasACHRequest1 as element(ns0:transferenciasACHRequest) external;

xf:transferenciasACHValidate($transferenciasACHRequest1)</con:xquery>
    <con:dependency location="transferenciasACHType.xsd">
        <con:schema ref="Middleware/Business_Resources/Transferencias/TransferenciasACH/transferenciasACHType"/>
    </con:dependency>
</con:xqueryEntry>