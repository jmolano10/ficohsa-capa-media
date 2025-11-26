(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../xsds/General/Autenticacion_v2.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/General/HeaderDeRegionalizacionMWCaja/";

declare function xf:HeaderDeRegionalizacionMWCaja($requestHeader as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($requestHeader/Authentication/UserName) }</UserName>
                <Password>{ data($requestHeader/Authentication/Password) }</Password>
            </Authentication>
            <Region>
                <SourceBank>HN01</SourceBank>
                <DestinationBank>HN01</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:HeaderDeRegionalizacionMWCaja($requestHeader)
