(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../xsds/ConsultaRecaudo/ConsultaRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/Recaudos/RegistrarOperacionConvenioNoEstandar/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudo/consultaRecaudoRegistrarOperConvenioNoEstandarIn/";

declare function xf:consultaRecaudoRegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudo as element(ns0:consultaRecaudo),
    $tipoOperacion as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:CONTRACT_ID>{ data($consultaRecaudo/CONTRACT_ID) }</ns1:CONTRACT_ID>
            <ns1:DEBTOR_CODE>{ data($consultaRecaudo/DEBTOR_CODE) }</ns1:DEBTOR_CODE>
            <ns1:CHANNEL_CODE>{ data($autenticacionRequestHeader/UserName) }</ns1:CHANNEL_CODE>
            <ns1:USER_ID>{ data($autenticacionRequestHeader/UserName) }</ns1:USER_ID>
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