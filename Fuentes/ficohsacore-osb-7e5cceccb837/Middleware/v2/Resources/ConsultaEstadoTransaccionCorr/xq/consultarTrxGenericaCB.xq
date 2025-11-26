(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/TransaccionesGenericasEEH/ConsultaTransaccionesGenericas/xsd/consultaTransaccionesGenericas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTransaccionesGenericas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoTransaccionCorr/xq/consultarTrxGenericaCB/";

declare function xf:consultarTrxGenericaCB($id_transaccion as xs:string,
    $tipoconsulta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_ID_TRANSACCION>{ $id_transaccion }</ns0:PV_ID_TRANSACCION>
            <ns0:PN_TIPO_CONSULTA>{ $tipoconsulta }</ns0:PN_TIPO_CONSULTA>
        </ns0:InputParameters>
};

declare variable $UUID as xs:string external;
declare variable $tipoconsulta as xs:string external;

xf:consultarTrxGenericaCB($UUID,
    $tipoconsulta)