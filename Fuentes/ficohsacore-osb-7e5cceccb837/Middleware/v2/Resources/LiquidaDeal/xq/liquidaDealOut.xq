(:: pragma bea:global-element-parameter parameter="$clearResponse1" element="ns0:ClearResponse" location="../../../BusinessServices/FX/deal/wsdl/deal.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:liquidaDealResponse" location="../xsd/liquidaDealTypes.xsd" ::)

declare namespace ns0 = "http://ficohsa.fx.webservices/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LiquidaDeal/xq/liquidaDealOut/";

declare function xf:liquidaDealOut($clearResponse1 as element(ns0:ClearResponse))
    as element(ns1:liquidaDealResponse) {
        <ns1:liquidaDealResponse>
            <CONTRACT_ID>{ data($clearResponse1/ns0:ClearResult/ns0:Contract) }</CONTRACT_ID>
            {
                for $Country in $clearResponse1/ns0:ClearResult/ns0:Country
                return
                    <COUNTRY>{ data($Country) }</COUNTRY>
            }
        </ns1:liquidaDealResponse>
};

declare variable $clearResponse1 as element(ns0:ClearResponse) external;

xf:liquidaDealOut($clearResponse1)