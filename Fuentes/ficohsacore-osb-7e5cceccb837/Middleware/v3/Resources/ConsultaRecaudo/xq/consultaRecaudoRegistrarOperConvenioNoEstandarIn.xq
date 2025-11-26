xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns1:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../Business_Resources/recaudos/Resources/RegistrarOperacionConvenioNoEstandar/xsd/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoRegistrarOperConvenioNoEstandarIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";

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

declare function xf:consultaRecaudoRegistrarOperConvenioNoEstandarIn($requestHeader as element(ns0:RequestHeader),
    $consultaRecaudo as element(ns1:consultaRecaudo),
    $tipoOperacion as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</ns2:CONTRACT_ID>
            <ns2:DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</ns2:DEBTOR_CODE>
            <ns2:CHANNEL_CODE>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</ns2:CHANNEL_CODE>
            <ns2:USER_ID>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</ns2:USER_ID>
            <ns2:CURRENCY>{ data($consultaRecaudo/CURRENCY) }</ns2:CURRENCY>
            <ns2:OPERATION_CODE>{ $tipoOperacion }</ns2:OPERATION_CODE>
            <ns2:ADDITIONAL_INFO>
                {
                    for $DATA in $consultaRecaudo/ADDITIONAL_INFO/DATA
                    return
                        <ns2:ITEM>{ data($DATA) }</ns2:ITEM>
                }
            </ns2:ADDITIONAL_INFO>
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaRecaudo as element(ns1:consultaRecaudo) external;
declare variable $tipoOperacion as xs:string external;

xf:consultaRecaudoRegistrarOperConvenioNoEstandarIn($requestHeader,
    $consultaRecaudo,
    $tipoOperacion)