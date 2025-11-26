(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito1" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataPA/conOrgSequence/xsd/conOrgSequence_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conOrgSequence";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/conOrgSequenceIn/";

declare function xf:conOrgSequenceIn($retiroTarjetaCredito1 as element(ns1:retiroTarjetaCredito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CURRENCY>{ data($retiroTarjetaCredito1/CURRENCY) }</ns0:CURRENCY>
            <ns0:CREDIT_CARD>{ data($retiroTarjetaCredito1/CREDIT_CARD_INFO/VALUE) }</ns0:CREDIT_CARD>
        </ns0:InputParameters>
};

declare variable $retiroTarjetaCredito1 as element(ns1:retiroTarjetaCredito) external;

xf:conOrgSequenceIn($retiroTarjetaCredito1)