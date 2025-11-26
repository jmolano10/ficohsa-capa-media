xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/conOrgSequenceGTIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";

declare function xf:conOrgSequenceGTIn($retiroTarjetaCredito as element(ns1:retiroTarjetaCredito))
    as element(ns0:InputParameters) {
         <ns0:InputParameters>
            <ns0:CURRENCY>{ data($retiroTarjetaCredito/CURRENCY) }</ns0:CURRENCY>
            <ns0:CREDIT_CARD>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/VALUE) }</ns0:CREDIT_CARD>
        </ns0:InputParameters>
};

declare variable $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito) external;

xf:conOrgSequenceGTIn($retiroTarjetaCredito)
