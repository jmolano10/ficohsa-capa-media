(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/xq/sjConsultaSaldosTCHeaderIn/";

declare function xf:sjConsultaSaldosTCHeaderIn($requestHeader1 as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ data($requestHeader1/Authentication/UserName) }</UserName>
                <Password>{ data($requestHeader1/Authentication/Password) }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ data($requestHeader1/Region/SourceBank) }</SourceBank>
                {
                    for $DestinationBank in $requestHeader1/Region/DestinationBank
                    return
                        <DestinationBank>{ data($DestinationBank) }</DestinationBank>
                }
            </Region>
        </ns0:RequestHeader>
};

declare variable $requestHeader1 as element(ns0:RequestHeader) external;

xf:sjConsultaSaldosTCHeaderIn($requestHeader1)