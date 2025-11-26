(:: pragma bea:global-element-parameter parameter="$reversarTransaccion1" element="ns1:reversarTransaccion" location="../../../../Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/xsd/registrarReversionTCCB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarReversionTCCB";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reversarTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaTransaccion/xq/registrarReversionTCCB/";

declare function xf:registrarReversionTCCB($reversarTransaccion1 as element(ns1:reversarTransaccion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_TRANSACTION_ID>{ data($reversarTransaccion1/TRANSACTION_ID) }</ns0:PV_TRANSACTION_ID>
        </ns0:InputParameters>
};

declare variable $reversarTransaccion1 as element(ns1:reversarTransaccion) external;

xf:registrarReversionTCCB($reversarTransaccion1)
