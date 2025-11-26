(:: pragma bea:global-element-parameter parameter="$searchResponse" element="ns0:SearchResponse" location="../../../BusinessServices/FX/deal/wsdl/deal.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaDealResponse" location="../xsd/consultaDealTypes.xsd" ::)

declare namespace ns0 = "http://ficohsa.fx.webservices/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeal/xq/consultaDealOut/";

declare function xf:consultaDealOut($searchResponse as element(ns0:SearchResponse))
    as element(ns1:consultaDealResponse) {
        <ns1:consultaDealResponse>
            {
                for $Contract in $searchResponse/ns0:SearchResult/ns0:Contract
                return
                    <CONTRACT_ID>{ data($Contract) }</CONTRACT_ID>
            }
            {
                for $Country in $searchResponse/ns0:SearchResult/ns0:Country
                return
                    <COUNTRY>{ data($Country) }</COUNTRY>
            }
            <CUSTOMER_ID>{ data($searchResponse/ns0:SearchResult/ns0:ClientId) }</CUSTOMER_ID>
            <RATE>{ data($searchResponse/ns0:SearchResult/ns0:Rate) }</RATE>
            <SOURCE_AMOUNT>{ data($searchResponse/ns0:SearchResult/ns0:SourceAmount) }</SOURCE_AMOUNT>
            <SOURCE_CURRENCY>{ data($searchResponse/ns0:SearchResult/ns0:SourceCurrency) }</SOURCE_CURRENCY>
            <STATUS>{ data($searchResponse/ns0:SearchResult/ns0:Status) }</STATUS>
            <TARGET_AMOUNT>{ data($searchResponse/ns0:SearchResult/ns0:TargetAmount) }</TARGET_AMOUNT>
            <TARGET_CURRENCY>{ data($searchResponse/ns0:SearchResult/ns0:TargetCurrency) }</TARGET_CURRENCY>
        </ns1:consultaDealResponse>
};

declare variable $searchResponse as element(ns0:SearchResponse) external;

xf:consultaDealOut($searchResponse)