(:: pragma bea:global-element-parameter parameter="$requestHeaderCPB" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoBeneficio/xq/consultaCtaBeneHeaderIn/";

declare function xf:consultaCtaBeneHeaderIn($requestHeaderCPB as element(ns0:RequestHeader))
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            {
                let $Authentication := $requestHeaderCPB/Authentication
                return
                    <Authentication>
                        <UserName>{ data($Authentication/UserName) }</UserName>
                        <Password>{ data($Authentication/Password) }</Password>
                    </Authentication>
            }
            {
                let $Region := $requestHeaderCPB/Region
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

declare variable $requestHeaderCPB as element(ns0:RequestHeader) external;

xf:consultaCtaBeneHeaderIn($requestHeaderCPB)