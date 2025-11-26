xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;

declare function local:func($transfersLocalAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::)) as xs:string {
    
    
    if (fn:string($transfersLocalAccountRequest/ns1:DebitAccount/text()) = "" or 
    fn:string($transfersLocalAccountRequest/ns1:CreditAccount/text()) = "" or 
    fn:string($transfersLocalAccountRequest/ns1:TransferAmmount/text()) = "") then (
    "REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else if (not(fn:string($transfersLocalAccountRequest/ns1:DebitCredit/text()) = ("DEBIT","CREDIT",""))) then (
        	"DEBIT_CREDIT NOT SUPPORTED"
        	
        ) else (
        	""
        )
};

local:func($transfersLocalAccountRequest)
