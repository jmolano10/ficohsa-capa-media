(:: pragma bea:global-element-parameter parameter="$consultaActivosClienteRequest1" element="ns1:consultaActivosClienteRequest" location="../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKGT/consultaActivosCliente/xsd/consultaActivosCliente_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaActivosCliente/sjConsultaActivosClientesIn/";

declare function xf:sjConsultaActivosClientesIn($consultaActivosClienteRequest1 as element(ns1:consultaActivosClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CUSTOMER_ID>{ data($consultaActivosClienteRequest1/CUSTOMER_ID) }</ns0:PV_CUSTOMER_ID>
            <ns0:PV_ASSET_TYPE>{ data($consultaActivosClienteRequest1/ASSET_TYPE) }</ns0:PV_ASSET_TYPE>
        </ns0:InputParameters>
};

declare variable $consultaActivosClienteRequest1 as element(ns1:consultaActivosClienteRequest) external;

xf:sjConsultaActivosClientesIn($consultaActivosClienteRequest1)