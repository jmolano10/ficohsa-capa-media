(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns1:consultaRecaudo" location="consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/RegistrarReqConsultaRecaudo/xsd/OSB_REG_BITACORA_RECAUDO_REQ.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReqConsultaRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoRegistrarReq/";

declare function xf:consultaRecaudoRegistrarReq($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudo1 as element(ns1:consultaRecaudo),
    $string1 as xs:string,
    $string2 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:P_UUID>{ $string1 }</ns0:P_UUID>
            <ns0:P_CODIGO_CONVENIO>{ data($consultaRecaudo1/CONTRACT_ID) }</ns0:P_CODIGO_CONVENIO>
            <ns0:P_CODIGO_DEUDOR>{ data($consultaRecaudo1/DEBTOR_CODE) }</ns0:P_CODIGO_DEUDOR>
            <ns0:P_CODIGO_OPERACION>1</ns0:P_CODIGO_OPERACION>
            <ns0:P_FECHA>{ $string2 }</ns0:P_FECHA>
            <ns0:P_USUARIO>{ data($autenticacionRequestHeader1/UserName) }</ns0:P_USUARIO>
            <ns0:P_REQUEST>{ $consultaRecaudo1 }</ns0:P_REQUEST>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudo1 as element(ns1:consultaRecaudo) external;
declare variable $string1 as xs:string external;
declare variable $string2 as xs:string external;

xf:consultaRecaudoRegistrarReq($autenticacionRequestHeader1,
    $consultaRecaudo1,
    $string1,
    $string2)