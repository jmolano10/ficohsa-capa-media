(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../xsd/pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoCuentaInt/";


(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };
 
 
declare function xf:debitoPrestamoCuentaInt($requestHeader as element(ns2:RequestHeader),
    $pagoPrestamo as element(ns0:pagoPrestamo),
    $creditAccount as xs:string,
    $accountCurrency as xs:string,
    $transactionType as xs:string,
    $uuid as xs:string)
    as element(ns1:Transfmodelbankentrecuentas) {
        <ns1:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <messageId>{ $uuid }</messageId>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $transactionType }</TRANSACTIONTYPE>
                {
                    for $DEBIT_ACCOUNT in $pagoPrestamo/DEBIT_ACCOUNT
                    return
                        <DEBITACCTNO>{ data($DEBIT_ACCOUNT) }</DEBITACCTNO>
                }
                <DEBITCURRENCY>{ $accountCurrency }</DEBITCURRENCY>
                <DEBITAMOUNT>{ data($pagoPrestamo/PAYMENT_AMOUNT) }</DEBITAMOUNT>
                <CREDITACCTNO>{ $creditAccount }</CREDITACCTNO>
                {
                	if( substring($pagoPrestamo/DEBIT_ACCOUNT,1,3) = ("HNL","USD") ) then (
		                <gORDERINGBANK g = "1">
		                    <ORDERINGBANK>999999</ORDERINGBANK>
		                </gORDERINGBANK>
                	) else()
                }
                <gPAYMENTDETAILS g="1">
                {
                    for $LOAN_NUMBER in $pagoPrestamo/LOAN_NUMBER
                    return
                    <PAYMENTDETAILS>{ fn:concat("PTM-",data($LOAN_NUMBER)) }</PAYMENTDETAILS>    
                }     	        	
               	</gPAYMENTDETAILS>  
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns1:Transfmodelbankentrecuentas>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;
declare variable $creditAccount as xs:string external;
declare variable $accountCurrency as xs:string external;
declare variable $transactionType as xs:string external;
declare variable $uuid as xs:string external;

xf:debitoPrestamoCuentaInt($requestHeader,
    $pagoPrestamo,
    $creditAccount,
    $accountCurrency,
    $transactionType,
    $uuid)
