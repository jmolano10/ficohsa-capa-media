xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaFinanciamiento" element="ns2:procesaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaFinanciamiento/xq/transfmodelbankentrecuentasIn/";

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

declare function xf:transfmodelbankentrecuentasIn($transactionType as xs:string,
    $DEBITACCT as xs:string,
    $procesaFinanciamiento as element(ns2:procesaFinanciamiento),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(fn:string($requestHeader/Authentication/UserName/text())), fn:string($requestHeader/Authentication/UserName/text())) }</userName>
                <password>{ fn-bea:fail-over( getPassword(fn:string($requestHeader/Authentication/UserName/text())), fn:string($requestHeader/Authentication/PassWord/text())) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>1</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                <DEBITACCTNO>{ $DEBITACCT }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($procesaFinanciamiento/CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($procesaFinanciamiento/REQUEST_AMOUNT) }</DEBITAMOUNT>
                {
                    for $CREDIT_ACCOUNT in string($procesaFinanciamiento/DISBURSEMENT_INFO/TYPE/text())
                    return
                    	if( $CREDIT_ACCOUNT = 'ACCOUNT_CREDIT') then(
                        	<CREDITACCTNO>{ data($procesaFinanciamiento/DISBURSEMENT_INFO/CREDIT_ACCOUNT) }</CREDITACCTNO>
                        ) else ()
                }
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $transactionType as xs:string external;
declare variable $DEBITACCT as xs:string external;
declare variable $procesaFinanciamiento as element(ns2:procesaFinanciamiento) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:transfmodelbankentrecuentasIn($transactionType,
    $DEBITACCT,
    $procesaFinanciamiento,
    $requestHeader)