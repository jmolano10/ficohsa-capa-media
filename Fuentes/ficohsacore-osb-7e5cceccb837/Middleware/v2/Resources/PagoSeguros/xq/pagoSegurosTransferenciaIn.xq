(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoSeguro1" element="ns1:pagoSeguro" location="../xsd/pagoSeguroTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Transfmodelbankentrecuentas" location="../../../../Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/pagoSegurosTransferenciaIn2/";

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

declare function xf:pagoSegurosTransferenciaIn2($requestHeader1 as element(ns2:RequestHeader),
    $pagoSeguro1 as element(ns1:pagoSeguro),
    $codigoTransaccion as xs:string,
    $monedaCuentaDebito as xs:string,
    $CuentaCredito as xs:string,
    $uuid as xs:string,
    $nombreProducto as xs:string)
    as element(ns0:Transfmodelbankentrecuentas) {
        <ns0:Transfmodelbankentrecuentas>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <gtsControl/>
                <messageId>{ $uuid }</messageId>
                <noOfAuth/>
                <replace/>
            </OfsFunction>
            <FUNDSTRANSFERRETAILINTSALEWSType>
                <TRANSACTIONTYPE>{ $codigoTransaccion }</TRANSACTIONTYPE>
                {
                    for $DEBIT_ACCOUNT in $pagoSeguro1/DEBIT_ACCOUNT
                    return
                        <DEBITACCTNO>{ data($DEBIT_ACCOUNT) }</DEBITACCTNO>
                }
                <DEBITCURRENCY>{ $monedaCuentaDebito }</DEBITCURRENCY>
                {
                    for $INSTALLMENT_AMOUNT in $pagoSeguro1/INSTALLMENT_AMOUNT
                    return
                        <DEBITAMOUNT>{ data($INSTALLMENT_AMOUNT) }</DEBITAMOUNT>
                }
                <CREDITACCTNO>{ $CuentaCredito }</CREDITACCTNO>
                <gPAYMENTDETAILS>
                	<PAYMENTDETAILS>{ $nombreProducto }</PAYMENTDETAILS>
                </gPAYMENTDETAILS>
            </FUNDSTRANSFERRETAILINTSALEWSType>
        </ns0:Transfmodelbankentrecuentas>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $pagoSeguro1 as element(ns1:pagoSeguro) external;
declare variable $codigoTransaccion as xs:string external;
declare variable $monedaCuentaDebito as xs:string external;
declare variable $CuentaCredito as xs:string external;
declare variable $uuid as xs:string external;
declare variable $nombreProducto as xs:string external;

xf:pagoSegurosTransferenciaIn2($requestHeader1,
    $pagoSeguro1,
    $codigoTransaccion,
    $monedaCuentaDebito,
    $CuentaCredito,
    $uuid,
    $nombreProducto)