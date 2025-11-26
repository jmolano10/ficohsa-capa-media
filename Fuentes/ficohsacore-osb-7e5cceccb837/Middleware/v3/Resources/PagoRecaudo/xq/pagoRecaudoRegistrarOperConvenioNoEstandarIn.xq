xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../Business_Resources/recaudos/Resources/RegistrarOperacionConvenioNoEstandar/xsd/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoRecaudo/xq/pagoRecaudoRegistrarOperConvenioNoEstandarIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";

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
 
declare function xf:pagoRecaudoRegistrarOperConvenioNoEstandarIn($requestHeader as element(ns0:RequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $tipoOperacion as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }</ns2:CONTRACT_ID>
            <ns2:DEBTOR_CODE>{ data($pagoRecaudo/DEBTOR_CODE) }</ns2:DEBTOR_CODE>
            <ns2:CHANNEL_CODE>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</ns2:CHANNEL_CODE>
            <ns2:USER_ID>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</ns2:USER_ID>
            {
                for $PAYMENT_AMOUNT in $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns2:TOTAL_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns2:TOTAL_AMOUNT>
            }
            <ns2:CURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns2:CURRENCY>
            <ns2:OPERATION_CODE>{ $tipoOperacion }</ns2:OPERATION_CODE>
            <ns2:ADDITIONAL_INFO>
                {
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA
                    return
                        <ns2:ITEM>{ data($DATA) }</ns2:ITEM>
                }
            </ns2:ADDITIONAL_INFO>
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $tipoOperacion as xs:string external;

xf:pagoRecaudoRegistrarOperConvenioNoEstandarIn($requestHeader,
    $pagoRecaudo,
    $tipoOperacion)