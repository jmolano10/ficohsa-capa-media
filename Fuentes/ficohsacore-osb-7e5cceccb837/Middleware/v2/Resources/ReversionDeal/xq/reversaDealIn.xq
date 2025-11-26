(:: pragma bea:global-element-parameter parameter="$reversionDeal" element="ns0:reversionDeal" location="../xsd/reversionDealTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Reverse" location="../../../BusinessServices/FX/deal/wsdl/deal.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionDealTypes";
declare namespace ns1 = "http://ficohsa.fx.webservices/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionDeal/xq/reversaDealIn/";

declare function xf:reversaDealIn($reversionDeal as element(ns0:reversionDeal))
    as element(ns1:Reverse) {
        <ns1:Reverse>
            <ns1:model>
                {
                    for $COUNTRY in $reversionDeal/COUNTRY
                    return
                        <ns1:Country>{ data($COUNTRY) }</ns1:Country>
                }
                {
                    for $CONTRACT_ID in $reversionDeal/CONTRACT_ID
                    return
                        <ns1:Contract>{ data($CONTRACT_ID) }</ns1:Contract>
                }
            </ns1:model>
        </ns1:Reverse>
};

declare variable $reversionDeal as element(ns0:reversionDeal) external;

xf:reversaDealIn($reversionDeal)
