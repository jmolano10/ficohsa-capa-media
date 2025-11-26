(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCreditoCB/xq/PagoTarjetaCreditoCBHdrIn/";

declare function xf:PagoTarjetaCreditoCBHdrIn($requestHeader1 as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($requestHeader1/Authentication/UserName) }</UserName>
                <Password>{ data($requestHeader1/Authentication/Password) }</Password>
            </Authentication>
        </ns0:RequestHeader>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;

xf:PagoTarjetaCreditoCBHdrIn($requestHeader1)