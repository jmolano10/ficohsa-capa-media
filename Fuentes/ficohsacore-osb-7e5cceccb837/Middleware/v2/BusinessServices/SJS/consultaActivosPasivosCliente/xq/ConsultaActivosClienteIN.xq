(:: pragma bea:global-element-parameter parameter="$sjConsultaActivosPasivosClienteIN" element="ns0:sjConsultaActivosPasivosCliente" location="../xsd/sjConsultaActivosPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaActivosClienteRequest" location="../../../../Resources/ConsultaActivosCliente/xsd/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosPasivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaActivosClienteIN/";

declare function xf:ConsultaActivosClienteIN($sjConsultaActivosPasivosClienteIN as element(ns0:sjConsultaActivosPasivosCliente))
    as element(ns1:consultaActivosClienteRequest) {
        <ns1:consultaActivosClienteRequest>
            <CUSTOMER_ID>{ data($sjConsultaActivosPasivosClienteIN/ns0:CUSTOMER_ID) }</CUSTOMER_ID>
            <ASSET_TYPE>{ data($sjConsultaActivosPasivosClienteIN/ns0:ASSET_TYPE) }</ASSET_TYPE>
        </ns1:consultaActivosClienteRequest>
};

declare variable $sjConsultaActivosPasivosClienteIN as element(ns0:sjConsultaActivosPasivosCliente) external;

xf:ConsultaActivosClienteIN($sjConsultaActivosPasivosClienteIN)
