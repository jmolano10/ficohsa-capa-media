(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/actualizaCobroTSPPMSV/xsd/actualizaCobroTSPPMSV_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaCobroTSPPMSV";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace ns1 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/actualizaCobroTSPPMSV/";

declare function xf:actualizaCobroTSPPMSV($t24FTAuthFlow as element(ns2:T24FTAuthFlow),
    $codigoCliente as xs:string,
    $fechaLote as xs:string,
    $numLote as xs:string,
    $estado as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_NUMERO_LOTE>{ data($numLote) }</ns0:PN_NUMERO_LOTE>
            <ns0:PV_CODIGO_CLIENTE>{ $codigoCliente }</ns0:PV_CODIGO_CLIENTE>
            <ns0:PD_FECHA_INGRESO>{ $fechaLote }</ns0:PD_FECHA_INGRESO>
            <ns0:PV_CUENTA_DEBITO>{ data($t24FTAuthFlow/ns2:debitAcctNo) }</ns0:PV_CUENTA_DEBITO>
            <ns0:PV_ESTADO>{ $estado }</ns0:PV_ESTADO>
        </ns0:InputParameters>
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;
declare variable $codigoCliente as xs:string external;
declare variable $fechaLote as xs:string external;
declare variable $numLote as xs:string external;
declare variable $estado as xs:string external;

xf:actualizaCobroTSPPMSV($t24FTAuthFlow,
    $codigoCliente,
    $fechaLote,
    $numLote,
    $estado)