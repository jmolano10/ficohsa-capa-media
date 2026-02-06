xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosHN" element="ns1:sjConsultaMultipleProductosHN" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaTasaCambioHeaderIn/";

declare function xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosHN as element(ns1:sjConsultaMultipleProductosHN))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaMultipleProductosHN/ns1:USERNAME) }</UserName>
                <Password>{ data($sjConsultaMultipleProductosHN/ns1:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>HN01</SourceBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $sjConsultaMultipleProductosHN as element(ns1:sjConsultaMultipleProductosHN) external;

xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosHN)