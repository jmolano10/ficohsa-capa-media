(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/PagosMasivosBilleteraPuenteHeaderIn/";

declare function xf:PagosMasivosBilleteraPuenteHeaderIn($requestHeader as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            {
                let $Authentication := $requestHeader/Authentication
                return
                    <Authentication>
                        <UserName>{ data($Authentication/UserName) }</UserName>
                        <Password>{ data($Authentication/Password) }</Password>
                    </Authentication>
            }
            {
                let $Region := $requestHeader/Region
                return
                    <Region>
                        <SourceBank>{ data($Region/SourceBank) }</SourceBank>
                        {
                            for $DestinationBank in $Region/DestinationBank
                            return
                                <DestinationBank>{ data($DestinationBank) }</DestinationBank>
                        }
                    </Region>
            }
        </ns0:RequestHeader>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:PagosMasivosBilleteraPuenteHeaderIn($requestHeader)
