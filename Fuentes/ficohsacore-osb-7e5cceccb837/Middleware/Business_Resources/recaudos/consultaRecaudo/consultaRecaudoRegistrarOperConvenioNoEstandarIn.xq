(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../Resources/RegistrarOperacionConvenioNoEstandar/xsd/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoRegistrarOperConvenioNoEstandarIn/";

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

declare function xf:consultaRecaudoRegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudo as element(ns0:consultaRecaudo),
    $tipoOperacion as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:CONTRACT_ID>
            <ns1:DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</ns1:DEBTOR_CODE>
            <ns1:CHANNEL_CODE>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</ns1:CHANNEL_CODE>
            <ns1:USER_ID>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader/UserName)), 
												data($autenticacionRequestHeader/UserName)) }</ns1:USER_ID>
            <ns1:CURRENCY>{ data($consultaRecaudo/CURRENCY) }</ns1:CURRENCY>
            <ns1:OPERATION_CODE>{ $tipoOperacion }</ns1:OPERATION_CODE>
            <ns1:ADDITIONAL_INFO>
                {
                    for $DATA in $consultaRecaudo/ADDITIONAL_INFO/DATA
                    return
                        <ns1:ITEM>{ data($DATA) }</ns1:ITEM>
                }
            </ns1:ADDITIONAL_INFO>
        </ns1:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;
declare variable $tipoOperacion as xs:string external;

xf:consultaRecaudoRegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader,
    $consultaRecaudo,
    $tipoOperacion)