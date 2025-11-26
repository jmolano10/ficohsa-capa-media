(:: pragma bea:global-element-parameter parameter="$pagoRecaudo1" element="ns1:pagoRecaudo" location="pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../recaudos/Resources/RegistrarReqConsultaRecaudo/xsd/OSB_REG_BITACORA_RECAUDO_REQ.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReqConsultaRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoRegistrarReq/";

declare function xf:pagoRecaudoRegistrarReq($pagoRecaudo1 as element(ns1:pagoRecaudo),
    $string1 as xs:string,
    $string2 as xs:string,
    $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_UUID>{ $string1 }</ns0:P_UUID>
            <ns0:P_CODIGO_CONVENIO>{ data($pagoRecaudo1/CONTRACT_ID) }</ns0:P_CODIGO_CONVENIO>
            <ns0:P_CODIGO_DEUDOR>{ data($pagoRecaudo1/DEBTOR_CODE) }</ns0:P_CODIGO_DEUDOR>
            <ns0:P_CODIGO_OPERACION>2</ns0:P_CODIGO_OPERACION>
            <ns0:P_FECHA>{ $string2 }</ns0:P_FECHA>
            <ns0:P_USUARIO>{ data($autenticacionRequestHeader1/UserName) }</ns0:P_USUARIO>
            <ns0:P_REQUEST>{ $pagoRecaudo1 }</ns0:P_REQUEST>
        </ns0:InputParameters>
};

declare variable $pagoRecaudo1 as element(ns1:pagoRecaudo) external;
declare variable $string1 as xs:string external;
declare variable $string2 as xs:string external;
declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;

xf:pagoRecaudoRegistrarReq($pagoRecaudo1,
    $string1,
    $string2,
    $autenticacionRequestHeader1)