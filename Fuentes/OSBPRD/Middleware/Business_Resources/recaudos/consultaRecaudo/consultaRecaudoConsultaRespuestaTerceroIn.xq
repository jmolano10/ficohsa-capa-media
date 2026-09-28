(:: pragma bea:global-element-parameter parameter="$consultaRecaudoResponse" element="ns1:consultaRecaudoResponse" location="consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../Resources/ConsultarRespuestaTercero/xsd/FLINK_OSB_CONSULTAR_RPTA_TERCERO.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_RPTA_TERCERO/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoConsultaRespuestaTerceroIn/";

declare function xf:consultaRecaudoConsultaRespuestaTerceroIn($consultaRecaudoResponse as element(ns1:consultaRecaudoResponse))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $DEBTOR_NAME in $consultaRecaudoResponse/DEBTOR_NAME
                return
                    <ns0:SOLICITUD_ID>{ fn-bea:fail-over(fn:tokenize($DEBTOR_NAME, "//")[1],"") }</ns0:SOLICITUD_ID>
            }
            {
                for $DEBTOR_NAME in $consultaRecaudoResponse/DEBTOR_NAME
                return
                    <ns0:COD_OPERACION>{ fn-bea:fail-over(fn:tokenize($DEBTOR_NAME, "//")[2],"") }</ns0:COD_OPERACION>
            }
        </ns0:InputParameters>
};

declare variable $consultaRecaudoResponse as element(ns1:consultaRecaudoResponse) external;

xf:consultaRecaudoConsultaRespuestaTerceroIn($consultaRecaudoResponse)