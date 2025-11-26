(:: pragma bea:global-element-parameter parameter="$registrarRTE" element="ns0:registrarRTE" location="../../xsds/RegistrarRTE/RegistrarRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/RegistrarRTE/ConsultarInfoClientesRTE/FLINK_OSB_CONSULTAR_INFO_CLIENTE_RTE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_CONSULTAR_INFO_CLIENTE_RTE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/registrarRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistrarRTE/ConsultarInfoClientesRTEIn/";

declare function xf:ConsultarInfoClientesRTEIn($registrarRTE as element(ns0:registrarRTE))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:NUMEROS_IDS>
                <ns1:ITEM>{ data($registrarRTE/ID_NUMBER) }</ns1:ITEM>
                <ns1:ITEM>{ data($registrarRTE/BEHALF_ID_NUMBER) }</ns1:ITEM>
                <ns1:ITEM>{ data($registrarRTE/BEN_ID_NUMBER) }</ns1:ITEM>
            </ns1:NUMEROS_IDS>
        </ns1:InputParameters>
};

declare variable $registrarRTE as element(ns0:registrarRTE) external;

xf:ConsultarInfoClientesRTEIn($registrarRTE)