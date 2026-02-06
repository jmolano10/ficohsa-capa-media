xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTasaCambio1" element="ns0:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaTasaCambio/xsd/ConsultaTasaCambio_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaTasaCambio";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaTasaCambio/xq/consultaTasaCambioIn/";

declare function xf:consultaTasaCambioIn($consultaTasaCambio1 as element(ns0:consultaTasaCambio))
    as element(ns1:InputParameters) {
        let $consultaTasaCambio := $consultaTasaCambio1
        return
            <ns1:InputParameters>
                <ns1:FROM_CURRENCY>{ data($consultaTasaCambio/SOURCE_CURRENCY) }</ns1:FROM_CURRENCY>
                <ns1:TO_CURRENCY>{ data($consultaTasaCambio/TARGET_CURRENCY) }</ns1:TO_CURRENCY>
                <ns1:EXCHANGE_TYPE></ns1:EXCHANGE_TYPE>
                <ns1:EXCHANGE_DATE></ns1:EXCHANGE_DATE>
            </ns1:InputParameters>
            
};

declare variable $consultaTasaCambio1 as element(ns0:consultaTasaCambio) external;

xf:consultaTasaCambioIn($consultaTasaCambio1)