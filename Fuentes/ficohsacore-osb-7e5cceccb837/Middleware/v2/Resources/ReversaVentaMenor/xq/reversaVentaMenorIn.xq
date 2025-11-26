(:: pragma bea:global-element-parameter parameter="$reversaVentaMenor" element="ns0:reversaVentaMenor" location="../xsd/reversaVentaMenorTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DCP/reversaVentaMenor/xsd/reversarVentaMenor_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversaVentaMenorTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reversarVentaMenor";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaVentaMenor/xq/reversaVentaMenorIn/";

declare function xf:reversaVentaMenorIn($reversaVentaMenor as element(ns0:reversaVentaMenor))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PRCV>{ data($reversaVentaMenor/REVERSION_ID) }</ns1:PRCV>
            <ns1:PVFC>{ data($reversaVentaMenor/TRANSACTION_DATE) }</ns1:PVFC>
            <ns1:PVUB>{ data($reversaVentaMenor/USER_ID) }</ns1:PVUB>
            <ns1:PVAB>{ data($reversaVentaMenor/BRANCH) }</ns1:PVAB>
            <ns1:PTRX>{ data($reversaVentaMenor/TRANSACTION_ID) }</ns1:PTRX>
        </ns1:InputParameters>
};

declare variable $reversaVentaMenor as element(ns0:reversaVentaMenor) external;

xf:reversaVentaMenorIn($reversaVentaMenor)