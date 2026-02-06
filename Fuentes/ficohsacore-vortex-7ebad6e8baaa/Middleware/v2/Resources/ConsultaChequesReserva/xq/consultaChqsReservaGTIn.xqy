xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaChequesReserva1" element="ns0:consultaChequesReserva" location="../../../../Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaChequesReserva/xsd/consultaChequesReserva_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaChequesReserva";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaChequesReserva/xq/consultaChequesReservaIn/";

declare function xf:consultaChequesReservaIn($consultaChequesReserva1 as element(ns0:consultaChequesReserva))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaChequesReserva1/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $consultaChequesReserva1 as element(ns0:consultaChequesReserva) external;

xf:consultaChequesReservaIn($consultaChequesReserva1)