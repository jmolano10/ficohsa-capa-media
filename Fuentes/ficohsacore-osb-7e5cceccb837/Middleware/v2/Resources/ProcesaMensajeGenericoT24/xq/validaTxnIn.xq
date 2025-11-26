(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/consultarTxnGenericaT24/xsd/consultarTxnGenericaT24_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTxnGenericaT24";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/validaTxnIn/";

declare function xf:validaTxnIn($transactionId as xs:integer,
    $sourceBank as xs:string,
    $destinationBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:PN_IDTRANSACCION>{ $transactionId }</ns0:PN_IDTRANSACCION>
            <ns0:PV_BANCOORIGEN>{ $sourceBank }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ $destinationBank }</ns0:PV_BANCODESTINO>
        </ns0:InputParameters>
};

declare variable $transactionId as xs:integer external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;

xf:validaTxnIn($transactionId,
    $sourceBank,
    $destinationBank)