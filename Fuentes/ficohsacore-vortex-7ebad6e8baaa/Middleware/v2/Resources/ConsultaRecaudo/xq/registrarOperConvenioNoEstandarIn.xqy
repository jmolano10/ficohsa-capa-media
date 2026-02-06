xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns1:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../Business_Resources/recaudos/Resources/RegistrarOperacionConvenioNoEstandar/xsd/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/registrarOperConvenioNoEstandarIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

declare function xf:registrarOperConvenioNoEstandarIn($requestHeader1 as element(ns2:RequestHeader),
    $consultaRecaudo1 as element(ns1:consultaRecaudo),
    $tipoOperacion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($consultaRecaudo1/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($consultaRecaudo1/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            <ns0:CHANNEL_CODE>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</ns0:CHANNEL_CODE>
            <ns0:USER_ID>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</ns0:USER_ID>
            <ns0:CURRENCY>{ data($consultaRecaudo1/CURRENCY) }</ns0:CURRENCY>
            <ns0:OPERATION_CODE>{ $tipoOperacion }</ns0:OPERATION_CODE>
            <ns0:ADDITIONAL_INFO>
                {
                    for $DATA in $consultaRecaudo1/ADDITIONAL_INFO/DATA
                    return
                        <ns0:ITEM>{ data($DATA) }</ns0:ITEM>
                }
            </ns0:ADDITIONAL_INFO>
        </ns0:InputParameters>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $consultaRecaudo1 as element(ns1:consultaRecaudo) external;
declare variable $tipoOperacion as xs:string external;

xf:registrarOperConvenioNoEstandarIn($requestHeader1,
    $consultaRecaudo1,
    $tipoOperacion)