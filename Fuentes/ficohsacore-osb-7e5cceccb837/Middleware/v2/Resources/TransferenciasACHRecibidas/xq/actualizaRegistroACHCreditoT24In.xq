(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ACH/Recibido/ActualizaRegistroACHCreditoT24/xsd/actualizaRegistroACHCreditoT24_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaRegistroACHCreditoT24";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACHRecibidas/xq/actualizaRegistroACHCreditoT24In/";

declare function xf:actualizaRegistroACHCreditoT24In($achSecuencia as xs:decimal,
    $codigoProceso as xs:decimal,
    $idCliente as xs:string,
    $refControlT24 as xs:string,
    $refTransaccionT24 as xs:string,
    $estadoProceso as xs:string,
    $codigoErrorProceso as xs:string,
    $mensajeErrorProceso as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_ACHSECUENCIA>{ $achSecuencia }</ns0:PN_ACHSECUENCIA>
            <ns0:PN_CODIGOPROCESO>{ $codigoProceso }</ns0:PN_CODIGOPROCESO>
            <ns0:PV_IDCLIENTE>{ $idCliente }</ns0:PV_IDCLIENTE>
            <ns0:PV_REFCONTROLT24>{ $refControlT24 }</ns0:PV_REFCONTROLT24>
            <ns0:PV_REFTRANSACCIONT24>{ $refTransaccionT24 }</ns0:PV_REFTRANSACCIONT24>
            <ns0:PV_ESTADOPROCESO>{ $estadoProceso }</ns0:PV_ESTADOPROCESO>
            <ns0:PV_CODIGOERRORPROCESO>{ $codigoErrorProceso }</ns0:PV_CODIGOERRORPROCESO>
            <ns0:PV_MENSAJEERRORPROCESO>{ $mensajeErrorProceso }</ns0:PV_MENSAJEERRORPROCESO>
        </ns0:InputParameters>
};

declare variable $achSecuencia as xs:decimal external;
declare variable $codigoProceso as xs:decimal external;
declare variable $idCliente as xs:string external;
declare variable $refControlT24 as xs:string external;
declare variable $refTransaccionT24 as xs:string external;
declare variable $estadoProceso as xs:string external;
declare variable $codigoErrorProceso as xs:string external;
declare variable $mensajeErrorProceso as xs:string external;

xf:actualizaRegistroACHCreditoT24In($achSecuencia,
    $codigoProceso,
    $idCliente,
    $refControlT24,
    $refTransaccionT24,
    $estadoProceso,
    $codigoErrorProceso,
    $mensajeErrorProceso)
