(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../v2/BusinessServices/CNV/registrarRecibo/xsd/registrarRecibo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarRecibo";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoRegistrarReciboIn/";

declare function xf:pagoRecaudoRegistrarReciboIn($transactionId as xs:string,
    $altTxnId as xs:string,
    $contractId as xs:string,
    $debtorCode as xs:string,
    $txnDate as xs:string,
    $inputter as xs:string,
    $dealslip as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDTRANSACCION>{ $transactionId }</ns0:PV_IDTRANSACCION>
            <ns0:PV_IDTXNALTERNA>{ $altTxnId }</ns0:PV_IDTXNALTERNA>
            <ns0:PV_CODIGOCONVENIO>{ $contractId }</ns0:PV_CODIGOCONVENIO>
            <ns0:PV_CODIGODEUDOR>{ $debtorCode }</ns0:PV_CODIGODEUDOR>
            <ns0:PD_FECHAVALIDA>{ fn:concat(fn:substring($txnDate,1,4),"-",fn:substring($txnDate,5,2),"-",fn:substring($txnDate,7,2)) }</ns0:PD_FECHAVALIDA>
            <ns0:PV_USUARIO>{ $inputter }</ns0:PV_USUARIO>
            <ns0:PV_RECIBO>{ $dealslip }</ns0:PV_RECIBO>
        </ns0:InputParameters>
};

declare variable $transactionId as xs:string external;
declare variable $altTxnId as xs:string external;
declare variable $contractId as xs:string external;
declare variable $debtorCode as xs:string external;
declare variable $txnDate as xs:string external;
declare variable $inputter as xs:string external;
declare variable $dealslip as xs:string external;

xf:pagoRecaudoRegistrarReciboIn($transactionId,
    $altTxnId,
    $contractId,
    $debtorCode,
    $txnDate,
    $inputter,
    $dealslip)