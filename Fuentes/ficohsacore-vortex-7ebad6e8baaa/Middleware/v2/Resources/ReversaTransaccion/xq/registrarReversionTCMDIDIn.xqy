xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conReversionPagoTCRG/xsd/conReversarPagoTCRG_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conReversarPagoTCRG";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCMDIDIn/";

declare function xf:registrarReversionTCMDIDIn($transaccionId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>HND</ns0:Pais>
            <ns0:SecuenciaMovimiento>{ $transaccionId }</ns0:SecuenciaMovimiento>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $transaccionId as xs:string external;

xf:registrarReversionTCMDIDIn($transaccionId)