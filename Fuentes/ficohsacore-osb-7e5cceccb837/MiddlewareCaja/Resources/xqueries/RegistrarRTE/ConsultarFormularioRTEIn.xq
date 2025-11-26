(:: pragma bea:global-element-parameter parameter="$registrarRTE" element="ns0:registrarRTE" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/RegistrarRTE/ConsultarFormularioRTE/FLINK_OSB_CONSULTAR_FORMULARIO_RTE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_FORMULARIO_RTE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/ConsultarFormularioRTEIn/";

declare function xf:ConsultarFormularioRTEIn($registrarRTE as element(ns0:registrarRTE))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:SECUENCIAL>{ data($registrarRTE/TELLER_TRANS_ID) }</ns1:SECUENCIAL>
        </ns1:InputParameters>
};

declare variable $registrarRTE as element(ns0:registrarRTE) external;

xf:ConsultarFormularioRTEIn($registrarRTE)