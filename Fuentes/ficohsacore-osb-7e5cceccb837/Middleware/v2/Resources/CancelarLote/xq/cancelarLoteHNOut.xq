(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PMSV/cancelarLote/xsd/cancelarLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelarLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cancelarLote";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarLote/xq/cancelarLoteHNOut/";

declare function xf:cancelarLoteHNOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:cancelarLoteResponse) {
        <ns1:cancelarLoteResponse>
            <BANK_BATCH_ID>{ data($outputParameters/ns0:PN_NUMEROLOTE) }</BANK_BATCH_ID>
            <STATUS>{ data($outputParameters/ns0:PV_ESTADO) }</STATUS>
            <STATUS_DESC>{ data($outputParameters/ns0:PV_DESCRIPCIONESTADO) }</STATUS_DESC>
        </ns1:cancelarLoteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:cancelarLoteHNOut($outputParameters)