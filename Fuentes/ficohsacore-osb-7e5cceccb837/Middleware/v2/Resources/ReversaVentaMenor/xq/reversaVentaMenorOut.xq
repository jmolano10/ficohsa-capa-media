(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DCP/reversaVentaMenor/xsd/reversarVentaMenor_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:reversaVentaMenorResponse" location="../xsd/reversaVentaMenorTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversaVentaMenorTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reversarVentaMenor";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaVentaMenor/xq/reversaVentaMenorIn/";

declare function xf:reversaVentaMenorIn($outputParameters as element(ns1:OutputParameters))
    as element(ns0:reversaVentaMenorResponse) {
        <ns0:reversaVentaMenorResponse>
            <TRANSACTION_ID>{ data($outputParameters/ns1:PERC) }</TRANSACTION_ID>
            <ERROR_MESSAGE>{ data($outputParameters/ns1:PERM) }</ERROR_MESSAGE>
        </ns0:reversaVentaMenorResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:reversaVentaMenorIn($outputParameters)