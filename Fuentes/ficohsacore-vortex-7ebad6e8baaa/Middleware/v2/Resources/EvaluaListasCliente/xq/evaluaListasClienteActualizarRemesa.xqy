xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/SecActualizaSolicitudRemesa/xsd/SecActualizaSolicitudRemesa_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/SecActualizaSolicitudRemesa";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteActualizarRemesa/";

declare function xf:evaluaListasClienteActualizarRemesa($TransactionId as xs:string,
    $Status as xs:string,
    $Observation as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CLAVE>{ $TransactionId }</ns0:PV_CLAVE>
            <ns0:PV_ESTADO>{ $Status }</ns0:PV_ESTADO>
            <ns0:PV_OBSERVACION>{ $Observation }</ns0:PV_OBSERVACION>
        </ns0:InputParameters>
};

declare variable $TransactionId as xs:string external;
declare variable $Status as xs:string external;
declare variable $Observation as xs:string external;

xf:evaluaListasClienteActualizarRemesa($TransactionId,
    $Status,
    $Observation)