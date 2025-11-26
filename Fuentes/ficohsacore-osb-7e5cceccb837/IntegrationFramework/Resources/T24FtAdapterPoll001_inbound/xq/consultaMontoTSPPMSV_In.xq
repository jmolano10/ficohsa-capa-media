(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaMontoTSPPMSV/xsd/consultaMontoTspMasivos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMontoTspMasivos";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace ns1 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/consultaMontoTSPPMSV_In/";

declare function xf:consultaMontoTSPPMSV_In($t24FTAuthFlow as element(ns2:T24FTAuthFlow),
    $numeroLote as xs:string,
    $codigoCliente as xs:string,
    $fechaLote as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_NUMERO_LOTE>{ data($numeroLote) }</ns0:PN_NUMERO_LOTE>
            <ns0:PV_CODIGO_CLIENTE>{ $codigoCliente }</ns0:PV_CODIGO_CLIENTE>
            <ns0:PD_FECHA_INGRESO>{ data($fechaLote) }</ns0:PD_FECHA_INGRESO>
            <ns0:PV_CUENTA_DEBITO>{ data($t24FTAuthFlow/ns2:debitAcctNo) }</ns0:PV_CUENTA_DEBITO>
        </ns0:InputParameters>
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;
declare variable $numeroLote as xs:string external;
declare variable $codigoCliente as xs:string external;
declare variable $fechaLote as xs:string external;

xf:consultaMontoTSPPMSV_In($t24FTAuthFlow,
    $numeroLote,
    $codigoCliente,
    $fechaLote)