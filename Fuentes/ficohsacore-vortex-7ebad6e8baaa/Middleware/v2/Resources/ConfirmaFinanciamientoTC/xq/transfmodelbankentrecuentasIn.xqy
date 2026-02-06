xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$confirmaFinanciamiento" element="ns2:confirmaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConfirmaFinanciamientoTC/xq/transfmodelbankentrecuentasIn/";

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

declare function xf:transfmodelbankentrecuentasIn($requestHeader as element(ns0:RequestHeader),
    $confirmaFinanciamiento as element(ns2:confirmaFinanciamiento),
    $debitAccount as xs:string,
    $transactionType as xs:string)
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
                <DEBITACCTNO>{ $debitAccount }</DEBITACCTNO>
                <DEBITCURRENCY>{ data($confirmaFinanciamiento/CURRENCY) }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($confirmaFinanciamiento/REQUEST_AMOUNT) }</DEBITAMOUNT>
                {
                    for $CREDIT_ACCOUNT in string($confirmaFinanciamiento/DISBURSEMENT_INFO/TYPE/text())
                    return
                    	if( $CREDIT_ACCOUNT = 'ACCOUNT_CREDIT') then(
                        	<CREDITACCTNO>{ data($confirmaFinanciamiento/DISBURSEMENT_INFO/CREDIT_ACCOUNT) }</CREDITACCTNO>
                        ) else ()
                }
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $confirmaFinanciamiento as element(ns2:confirmaFinanciamiento) external;
declare variable $debitAccount as xs:string external;
declare variable $transactionType as xs:string external;

xf:transfmodelbankentrecuentasIn($requestHeader,
    $confirmaFinanciamiento,
    $debitAccount,
    $transactionType)