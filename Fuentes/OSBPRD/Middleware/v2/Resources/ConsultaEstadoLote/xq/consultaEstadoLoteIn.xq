(:: pragma bea:global-element-parameter parameter="$consultaEstadoLote" element="ns0:consultaEstadoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/consultaEstadoLote/xsd/consultarEstadoLote_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarEstadoLote";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteIn/";

declare function xf:consultaEstadoLoteIn($consultaEstadoLote as element(ns0:consultaEstadoLote))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGOCLIENTE>{ data($consultaEstadoLote/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PN_NUMEROLOTE>{ data($consultaEstadoLote/BANK_BATCH_ID) }</ns1:PN_NUMEROLOTE>
            <ns1:PD_FECINGRESO>{ data($consultaEstadoLote/UPLOAD_DATE) }</ns1:PD_FECINGRESO>
        </ns1:InputParameters>
};

declare variable $consultaEstadoLote as element(ns0:consultaEstadoLote) external;

xf:consultaEstadoLoteIn($consultaEstadoLote)