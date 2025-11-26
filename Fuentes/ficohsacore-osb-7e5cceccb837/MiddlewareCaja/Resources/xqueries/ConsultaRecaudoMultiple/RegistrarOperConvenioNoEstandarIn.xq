xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns2:AutenticacionRequestHeader" location="../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultiple" element="ns1:consultaRecaudoMultiple" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/RegistrarOperacionConvenioNoEstandar/FLINK_INT_K_CONVENIOS_NO_ESTANDAR_INT_CV_REGISTRAR_INFO_OPER.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/RegistrarOperConvenioNoEstandarIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/INT_K_CONVENIOS_NO_ESTANDAR/INT_CV_REGISTRAR_INFO_OPER/";

declare function xf:RegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader),
    $consultaRecaudoMultiple as element(ns1:consultaRecaudoMultiple),
    $tipoOperacion as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CONTRACT_ID>{ data($consultaRecaudoMultiple/CONTRACT_ID) }</ns0:CONTRACT_ID>
            <ns0:DEBTOR_CODE>{ data($consultaRecaudoMultiple/DEBTOR_CODE) }</ns0:DEBTOR_CODE>
            <ns0:CHANNEL_CODE>{ data($autenticacionRequestHeader/UserName) }</ns0:CHANNEL_CODE>
            <ns0:USER_ID>{ data($autenticacionRequestHeader/UserName) }</ns0:USER_ID>
            <ns0:CURRENCY>{ data($consultaRecaudoMultiple/CURRENCY) }</ns0:CURRENCY>
            <ns0:OPERATION_CODE>{ $tipoOperacion }</ns0:OPERATION_CODE>
            <ns0:ADDITIONAL_INFO>
                {
                    for $DATA in $consultaRecaudoMultiple/ADDITIONAL_INFO/DATA
                    return
                        <ns0:ITEM>{ data($DATA) }</ns0:ITEM>
                }
            </ns0:ADDITIONAL_INFO>
        </ns0:InputParameters>
};

declare variable $autenticacionRequestHeader as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaRecaudoMultiple as element(ns1:consultaRecaudoMultiple) external;
declare variable $tipoOperacion as xs:string external;

xf:RegistrarOperConvenioNoEstandarIn($autenticacionRequestHeader,
    $consultaRecaudoMultiple,
    $tipoOperacion)