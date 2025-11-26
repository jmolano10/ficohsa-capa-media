(:: pragma bea:global-element-parameter parameter="$sjConsultaMultipleProductos" element="ns1:sjConsultaMultipleProductos" location="../xsd/sjConsultaMultipleProductos.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductos";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultiplesProductos/xq/consultaMultiplesProductosInternoHeaderIn/";

declare function xf:consultaMultiplesProductosInternoHeaderIn($sjConsultaMultipleProductos as element(ns1:sjConsultaMultipleProductos),
    $pais as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($sjConsultaMultipleProductos/ns1:USERNAME) }</UserName>
                <Password>{ data($sjConsultaMultipleProductos/ns1:PASSWORD) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ $pais }</SourceBank>
                <DestinationBank>{ $pais }</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $sjConsultaMultipleProductos as element(ns1:sjConsultaMultipleProductos) external;
declare variable $pais as xs:string external;

xf:consultaMultiplesProductosInternoHeaderIn($sjConsultaMultipleProductos,
    $pais)