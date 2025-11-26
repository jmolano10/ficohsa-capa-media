(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../xsd/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transferenciaentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoAuthIn/";

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
declare function splitString($String as xs:string?, $length as xs:integer) as xs:string* {
  if (exists($String) and string-length($String) > $length) then 
    (substring($String,1,$length), splitString(substring($String,$length+1),$length)) 
  else $String
};

declare function xf:pagoPrestamoAuthIn($requestHeader as element(ns2:RequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $creditAccount as xs:string,
    $transactionType as xs:string,
    $uuid as xs:string,
    $auth as xs:string)
    as element(ns1:Transferenciaentrecuentas) {
        <ns1:Transferenciaentrecuentas>
            <WebRequestCommon>
                <userName>
                    {
                        fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/UserName))
                    }
                </userName>
                <password>
                    {
                        fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                        data($requestHeader/Authentication/Password))
                    }
                </password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
                <noOfAuth>{ $auth }</noOfAuth>
            </OfsFunction>
            <FUNDSTRANSFERRETAILSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                {
                    for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                    return
                        <DEBITACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBITACCOUNT>
                }
                <DEBITAMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCOUNT>{ $creditAccount }</CREDITACCOUNT>
            </FUNDSTRANSFERRETAILSALEWSType>
        </ns1:Transferenciaentrecuentas>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $creditAccount as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;
declare variable $auth as xs:string external;

xf:pagoPrestamoAuthIn($requestHeader,
    $pagoPrestamo,
    $creditAccount,
    $transactionType,
    $uuid,
    $auth)
