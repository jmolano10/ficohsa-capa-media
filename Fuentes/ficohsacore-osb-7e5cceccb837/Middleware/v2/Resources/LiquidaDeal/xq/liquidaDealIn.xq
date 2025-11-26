(:: pragma bea:global-element-parameter parameter="$liquidaDeal" element="ns1:liquidaDeal" location="../xsd/liquidaDealTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Clear" location="../../../BusinessServices/FX/deal/wsdl/deal.wsdl" ::)

declare namespace ns0 = "http://ficohsa.fx.webservices/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/LiquidaDeal/xq/liquidaDealIn/";

declare function xf:liquidaDealIn($liquidaDeal as element(ns1:liquidaDeal))
    as element(ns0:Clear) {
        <ns0:Clear>
            <ns0:model>
                <ns0:Country>{ data($liquidaDeal/COUNTRY) }</ns0:Country>
                <ns0:Contract>{ data($liquidaDeal/CONTRACT_ID) }</ns0:Contract>
            </ns0:model>
        </ns0:Clear>
};

declare variable $liquidaDeal as element(ns1:liquidaDeal) external;

xf:liquidaDealIn($liquidaDeal)