(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/AbanksGT/ReversionTXNTC/xsd/TransactionReversal_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TransactionReversal";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/TransactionReversal/TransactionReversal/xq/RegistrarReversionTCGTIn/";

declare function xf:RegistrarReversionTCGTIn($TxnID as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PN_SECUENCIAMOVIMIENTO>{ fn:number($TxnID) }</ns0:PN_SECUENCIAMOVIMIENTO>
        </ns0:InputParameters>
};

declare variable $TxnID as xs:string external;

xf:RegistrarReversionTCGTIn($TxnID)