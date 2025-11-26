(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElementsCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesasCB/xq/consultaRemesaCBHeaderIn/";

declare function xf:consultaRemesaCBHeaderIn($requestHeader as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($requestHeader/Authentication/UserName) }</UserName>
                <Password>{ data($requestHeader/Authentication/Password) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($requestHeader/Region/SourceBank) }</SourceBank>
                {
                    for $DestinationBank in $requestHeader/Region/DestinationBank
                    return
                        <DestinationBank>{ data($DestinationBank) }</DestinationBank>
                }
            </Region>
        </ns0:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:consultaRemesaCBHeaderIn($requestHeader)
