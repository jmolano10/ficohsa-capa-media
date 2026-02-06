xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTasaCambioInterPA" element="ns1:consultaTasaCambioInterPA" location="../xsd/consultaTasaCambioInterPATypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaTasaCambioInterPA/xsd/consultaTasaCambioInterPA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTasaCambioInterPA";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioInterPATypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaTasaCambioInterPA/xq/consultaTasaCambioInterPAIn/";

declare function xf:consultaTasaCambioInterPAIn($consultaTasaCambioInterPA as element(ns1:consultaTasaCambioInterPA))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:FROM_CURRENCY>{ data($consultaTasaCambioInterPA/SOURCE_CURRENCY) }</ns0:FROM_CURRENCY>
            <ns0:TO_CURRENCY>{ data($consultaTasaCambioInterPA/TARGET_CURRENCY) }</ns0:TO_CURRENCY>
        </ns0:InputParameters>
};

declare variable $consultaTasaCambioInterPA as element(ns1:consultaTasaCambioInterPA) external;

xf:consultaTasaCambioInterPAIn($consultaTasaCambioInterPA)