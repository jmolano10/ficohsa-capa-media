xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/transferLocalAccountTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transferLocalAccountTypes.xsd" ::)

declare variable $transfersAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::) external;
declare variable $user as xs:string external;

declare function local:func($transfersAccountRequest as element() (:: schema-element(ns1:transfersLocalAccountRequest) ::), 
                            $user as xs:string) 
                            as xs:string {
        let $TRANSFER_DETAILS := fn:string($transfersAccountRequest/ns1:TransferDetails/text())
    	let $USERNAME := upper-case($user)
    	let $CUSTOM_TXN := upper-case(substring-before(substring-after($TRANSFER_DETAILS, '['),']'))
    	return
    		if ($CUSTOM_TXN != "") then (
    			concat("T24T057.",$CUSTOM_TXN,".TXNTYPE")
    		) else (
    			concat("T24T057.",$USERNAME,".TXNTYPE")
    		)
};

local:func($transfersAccountRequest, $user)
