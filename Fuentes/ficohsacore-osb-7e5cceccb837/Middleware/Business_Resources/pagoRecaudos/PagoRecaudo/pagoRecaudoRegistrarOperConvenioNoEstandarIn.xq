(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../recaudos/Resources/RegistrarOperacionConvenioNoEstandar/xsd/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoRegistrarOperConvenioNoEstandarIn/";

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

declare function xf:pagoRecaudoRegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $pagoRecaudo as element(ns1:pagoRecaudo),
    $tipoOperacion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($pagoRecaudo/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            <ns0:CHANNEL_CODE>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</ns0:CHANNEL_CODE>
            <ns0:USER_ID>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</ns0:USER_ID>
            {
                for $PAYMENT_AMOUNT in $pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT
                return
                    <ns0:TOTAL_AMOUNT>{ data($PAYMENT_AMOUNT) }</ns0:TOTAL_AMOUNT>
            }
            <ns0:CURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:CURRENCY>
            <ns0:OPERATION_CODE>{ $tipoOperacion }</ns0:OPERATION_CODE>
            <ns0:ADDITIONAL_INFO>
                {
                    for $DATA in $pagoRecaudo/ADDITIONAL_INFO/DATA
                    return
                        <ns0:ITEM>{ data($DATA) }</ns0:ITEM>
                }
            </ns0:ADDITIONAL_INFO>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $tipoOperacion as xs:string external;

xf:pagoRecaudoRegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader,
    $pagoRecaudo,
    $tipoOperacion)