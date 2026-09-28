(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosGT" element="ns0:sjConsultaMultipleProductosGT" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaTasaCambioHeaderIn/";

declare function xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosGT as element(ns0:sjConsultaMultipleProductosGT))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaMultipleProductosGT/ns0:USERNAME) }</UserName>
                <Password>{ data($sjConsultaMultipleProductosGT/ns0:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>GT01</SourceBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $sjConsultaMultipleProductosGT as element(ns0:sjConsultaMultipleProductosGT) external;

xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosGT)