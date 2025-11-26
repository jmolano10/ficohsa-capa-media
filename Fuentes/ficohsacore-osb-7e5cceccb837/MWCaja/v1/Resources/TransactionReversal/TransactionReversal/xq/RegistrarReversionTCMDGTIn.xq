(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../../Middleware/v3/BusinessServices/MasterData/conReversionPagoTCRG/xsd/conReversarPagoTCRG_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conReversarPagoTCRG";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/TransactionReversal/TransactionReversal/xq/RegistrarReversionTCMDGTIn/";

declare function xf:RegistrarReversionTCMDGTIn($idTransaction as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:Pais>GTM</ns0:Pais>
            <ns0:SecuenciaMovimiento>{ $idTransaction }</ns0:SecuenciaMovimiento>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $idTransaction as xs:string external;

xf:RegistrarReversionTCMDGTIn($idTransaction)
