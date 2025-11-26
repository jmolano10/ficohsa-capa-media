(:: pragma bea:global-element-parameter parameter="$reverseResponse" element="ns1:ReverseResponse" location="../../../BusinessServices/FX/deal/wsdl/deal.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:reversionDealResponse" location="../xsd/reversionDealTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionDealTypes";
declare namespace ns1 = "http://ficohsa.fx.webservices/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversionDeal/xq/reversionDealOut/";

declare function xf:reversionDealOut($reverseResponse as element(ns1:ReverseResponse))
    as element(ns0:reversionDealResponse) {
        <ns0:reversionDealResponse>
            {
                for $Contract in $reverseResponse/ns1:ReverseResult/ns1:Contract
                return
                    <CONTRACT_ID>{ data($Contract) }</CONTRACT_ID>
            }
            {
                for $Country in $reverseResponse/ns1:ReverseResult/ns1:Country
                return
                    <COUNTRY>{ data($Country) }</COUNTRY>
            }
        </ns0:reversionDealResponse>
};

declare variable $reverseResponse as element(ns1:ReverseResponse) external;

xf:reversionDealOut($reverseResponse)
