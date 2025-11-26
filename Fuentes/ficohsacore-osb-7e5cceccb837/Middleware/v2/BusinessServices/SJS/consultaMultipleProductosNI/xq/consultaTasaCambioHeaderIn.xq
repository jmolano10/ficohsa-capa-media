(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductosNI" element="ns0:sjConsultaMultipleProductosNI" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)
(:: pragma bea:global-element-return element="ns1:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaTasaCambioHeaderIn/";

declare function xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosNI as element(ns0:sjConsultaMultipleProductosNI))
    as element(ns1:RequestHeader) {
        <ns1:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaMultipleProductosNI/ns0:USERNAME) }</UserName>
                <Password>{ data($sjConsultaMultipleProductosNI/ns0:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>NI01</SourceBank>
            </Region>
        </ns1:RequestHeader>
};

declare variable $sjConsultaMultipleProductosNI as element(ns0:sjConsultaMultipleProductosNI) external;

xf:consultaTasaCambioHeaderIn($sjConsultaMultipleProductosNI)