xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RecordReceipt";
(:: import schema at "../../../../ProviderServices/XSD/RecordReceipt/RecordReceipt_sp.xsd" ::)

declare variable $transactionId as xs:string external;
declare variable $altTxnld as xs:string external;
declare variable $contractId as xs:string external;
declare variable $debtorCode as xs:string external;
declare variable $txnDate as xs:string external;
declare variable $inputter as xs:string external;
declare variable $dealslip as xs:string external;

declare function local:func($transactionId as xs:string, 
                            $altTxnld as xs:string, 
                            $contractId as xs:string, 
                            $debtorCode as xs:string, 
                            $txnDate as xs:string, 
                            $inputter as xs:string, 
                            $dealslip as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
            <ns1:PV_IDTRANSACCION>{ $transactionId }</ns1:PV_IDTRANSACCION>
            <ns1:PV_IDTXNALTERNA>{ $altTxnld }</ns1:PV_IDTXNALTERNA>
            <ns1:PV_CODIGOCONVENIO>{ $contractId }</ns1:PV_CODIGOCONVENIO>
            <ns1:PV_CODIGODEUDOR>{ $debtorCode }</ns1:PV_CODIGODEUDOR>
            <ns1:PD_FECHAVALIDA>{ fn:concat(fn:substring($txnDate,1,4),"-",fn:substring($txnDate,5,2),"-",fn:substring($txnDate,7,2)) }</ns1:PD_FECHAVALIDA>
            <ns1:PV_USUARIO>{ $inputter }</ns1:PV_USUARIO>
            <ns1:PV_RECIBO>{ $dealslip }</ns1:PV_RECIBO>
    </ns1:InputParameters>
};

local:func($transactionId, $altTxnld, $contractId, $debtorCode, $txnDate, $inputter, $dealslip)