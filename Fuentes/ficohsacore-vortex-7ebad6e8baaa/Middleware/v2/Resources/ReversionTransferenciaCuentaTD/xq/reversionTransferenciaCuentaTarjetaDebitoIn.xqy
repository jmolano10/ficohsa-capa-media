xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$reversionTransferenciaCuentaTD" element="ns1:reversionTransferenciaCuentaTD" location="../xsd/reversionTransferenciaCuentaTDTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ReversionTransferenciaCuentaTD" location="../../../BusinessServices/T24/svcTransferenciasTD/xsd/XMLSchema_-207313410.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversionTransferenciaCuentaTDTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionTransferenciaCuentaTD/xq/reversionTransferenciaCuentaTarjetaDebitoIn/";

declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:reversionTransferenciaCuentaTarjetaDebitoIn($txnTypeReversion as xs:string,
    $serviceAccountName as xs:string,
    $reversionTransferenciaCuentaTD as element(ns1:reversionTransferenciaCuentaTD))
    as element(ns0:ReversionTransferenciaCuentaTD) {
        <ns0:ReversionTransferenciaCuentaTD>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername($serviceAccountName), $serviceAccountName) }</userName>
                <password>{ fn-bea:fail-over( getPassword($serviceAccountName), '') }</password>
            </WebRequestCommon>
            <OfsFunction>
                	<gtsControl/>
                	<messageId/>
                	<noOfAuth/>
                	<replace/>
            </OfsFunction>
            <FUNDSTRANSFERVISAFASTFUNDSREVERSALType>
                <TransactionType>{ $txnTypeReversion }</TransactionType>
                <LRCARDNUMBER>{ data($reversionTransferenciaCuentaTD/CARD_NUMBER) }</LRCARDNUMBER>
                <SYSTRACEAUDN>{ data($reversionTransferenciaCuentaTD/TERMINAL_REFERENCE) }</SYSTRACEAUDN>
                <RETRIEVALREFN>{ data($reversionTransferenciaCuentaTD/RETRIEVAL_REF_NO) }</RETRIEVALREFN>
            </FUNDSTRANSFERVISAFASTFUNDSREVERSALType>
        </ns0:ReversionTransferenciaCuentaTD>
};

declare variable $txnTypeReversion as xs:string external;
declare variable $serviceAccountName as xs:string external;
declare variable $reversionTransferenciaCuentaTD as element(ns1:reversionTransferenciaCuentaTD) external;

xf:reversionTransferenciaCuentaTarjetaDebitoIn($txnTypeReversion,
    $serviceAccountName,
    $reversionTransferenciaCuentaTD)