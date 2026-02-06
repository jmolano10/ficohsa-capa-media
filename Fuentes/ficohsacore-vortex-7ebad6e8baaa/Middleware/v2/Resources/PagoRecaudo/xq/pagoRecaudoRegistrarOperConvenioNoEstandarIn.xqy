xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../Business_Resources/recaudos/Resources/RegistrarOperacionConvenioNoEstandar/xsd/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRecaudoRegistrarOperConvenioNoEstandarIn/";

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

declare function xf:pagoRecaudoRegistrarOperConvenioNoEstandarIn($requestHeader1 as element(ns2:RequestHeader),
    $pagoRecaudo1 as element(ns1:pagoRecaudo),
    $tipoOperacion as xs:string)
    as element(ns0:InputParameters) {
         <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($pagoRecaudo1/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($pagoRecaudo1/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            <ns0:CHANNEL_CODE>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</ns0:CHANNEL_CODE>
            <ns0:USER_ID>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</ns0:USER_ID>
            {
                for $PAYMENT_AMOUNT in $pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns0:TOTAL_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns0:TOTAL_AMOUNT>
            }
            <ns0:CURRENCY>{ data($pagoRecaudo1/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:CURRENCY>
            <ns0:OPERATION_CODE>{ $tipoOperacion }</ns0:OPERATION_CODE>
            <ns0:ADDITIONAL_INFO>
                {
                    for $DATA in $pagoRecaudo1/ADDITIONAL_INFO/DATA
                    return
                        <ns0:ITEM>{ data($DATA) }</ns0:ITEM>
                }
            </ns0:ADDITIONAL_INFO>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $tipoOperacion as xs:string external;

xf:pagoRecaudoRegistrarOperConvenioNoEstandarIn($requestHeader1,
    $pagoRecaudo1,
    $tipoOperacion)