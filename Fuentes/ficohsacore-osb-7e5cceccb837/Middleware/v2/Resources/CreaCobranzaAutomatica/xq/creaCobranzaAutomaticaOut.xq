(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/creaCobranzaAutomatica/xsd/creaCobranzaAutomatica_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaCobranzaAutomaticaResponse" location="../xsd/creaCobranzaAutomaticaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/creaCobranzaAutomatica";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/creaCobranzaAutomaticaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCobranzaAutomatica/xq/creaCobranzaAutomaticaOut/";

declare function xf:creaCobranzaAutomaticaOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:creaCobranzaAutomaticaResponse) {
        <ns1:creaCobranzaAutomaticaResponse>
            {
                for $PV_DEBTOR_CODE in $outputParameters/ns0:PV_DEBTOR_CODE
                return
                    <DEBTOR_CODE>{ data($PV_DEBTOR_CODE) }</DEBTOR_CODE>
            }
        </ns1:creaCobranzaAutomaticaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:creaCobranzaAutomaticaOut($outputParameters)
