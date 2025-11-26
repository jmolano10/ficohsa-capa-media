xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultipleResponse" element="ns1:consultaRecaudoMultipleResponse" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/Recaudos/ConsultarRespuestaTercero/FLINK_OSB_CONSULTAR_RPTA_TERCERO.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/ConsultaRespuestaTerceroIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_RPTA_TERCERO/";

declare function xf:ConsultaRespuestaTerceroIn($consultaRecaudoMultipleResponse as element(ns1:consultaRecaudoMultipleResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $DEBTOR_NAME in $consultaRecaudoMultipleResponse/DEBTOR_NAME
                return
                    <ns0:SOLICITUD_ID>{ fn-bea:fail-over(fn:tokenize($DEBTOR_NAME, "//")[1],"") }</ns0:SOLICITUD_ID>
            }
            {
                for $DEBTOR_NAME in $consultaRecaudoMultipleResponse/DEBTOR_NAME
                return
                    <ns0:COD_OPERACION>{ fn-bea:fail-over(fn:tokenize($DEBTOR_NAME, "//")[2],"") }</ns0:COD_OPERACION>
            }
        </ns0:InputParameters>
};

declare variable $consultaRecaudoMultipleResponse as element(ns1:consultaRecaudoMultipleResponse) external;

xf:ConsultaRespuestaTerceroIn($consultaRecaudoMultipleResponse)