(:: pragma bea:global-element-parameter parameter="$consultaComisionMasivos1" element="ns0:ConsultaComisionMasivos" location="../xsd/consultaComisionMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/consultaComisionMasivos/xsd/ConsultaComisionMasivos_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaComisionMasivos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionMasivos/xq/consultaComisionMasivosIn/";

declare function xf:consultaComisionMasivosIn($consultaComisionMasivos1 as element(ns0:ConsultaComisionMasivos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUSTOMER_ID>{ data($consultaComisionMasivos1/CUSTOMER_ID) }</ns1:PV_CUSTOMER_ID>
            <ns1:PV_BATCH_ID>{ data($consultaComisionMasivos1/BATCH_ID) }</ns1:PV_BATCH_ID>
            <ns1:PV_CREATION_DATE>{ data($consultaComisionMasivos1/CREATION_DATE) }</ns1:PV_CREATION_DATE>
        </ns1:InputParameters>
};

declare variable $consultaComisionMasivos1 as element(ns0:ConsultaComisionMasivos) external;

xf:consultaComisionMasivosIn($consultaComisionMasivos1)