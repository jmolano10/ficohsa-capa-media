xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns2:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/recaudos/Resources/RegistrarReqConsultaRecaudo/xsd/OSB_REG_BITACORA_RECAUDO_REQ.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoRegistrarReq/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReqConsultaRecaudo";

declare function xf:consultaRecaudoRegistrarReq($requestHeader as element(ns0:RequestHeader),
    $consultaRecaudo as element(ns2:consultaRecaudo),
    $string1 as xs:string,
    $string2 as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:P_UUID>{ $string1 }</ns1:P_UUID>
            <ns1:P_CODIGO_CONVENIO>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:P_CODIGO_CONVENIO>
            <ns1:P_CODIGO_DEUDOR>{ data($consultaRecaudo/DEBTOR_CODE) }</ns1:P_CODIGO_DEUDOR>
            <ns1:P_CODIGO_OPERACION>1</ns1:P_CODIGO_OPERACION>
            <ns1:P_FECHA>{ $string2 }</ns1:P_FECHA>
            <ns1:P_USUARIO>{ data($requestHeader/Authentication/UserName) }</ns1:P_USUARIO>
            <ns1:P_REQUEST>{ $consultaRecaudo }</ns1:P_REQUEST>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaRecaudo as element(ns2:consultaRecaudo) external;
declare variable $string1 as xs:string external;
declare variable $string2 as xs:string external;

xf:consultaRecaudoRegistrarReq($requestHeader,
    $consultaRecaudo,
    $string1,
    $string2)