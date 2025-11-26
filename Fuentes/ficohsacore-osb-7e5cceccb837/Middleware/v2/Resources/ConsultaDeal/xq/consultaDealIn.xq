(:: pragma bea:global-element-parameter parameter="$consultaDeal" element="ns1:consultaDeal" location="../xsd/consultaDealTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Search" location="../../../BusinessServices/FX/deal/wsdl/deal.wsdl" ::)

declare namespace ns0 = "http://ficohsa.fx.webservices/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDealTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeal/xq/consultaDealIn/";

declare function xf:consultaDealIn($consultaDeal as element(ns1:consultaDeal))
    as element(ns0:Search) {
        <ns0:Search>
            <ns0:model>
                <ns0:Country>{ data($consultaDeal/COUNTRY) }</ns0:Country>
                <ns0:Contract>{ data($consultaDeal/CONTRACT_ID) }</ns0:Contract>
            </ns0:model>
        </ns0:Search>
};

declare variable $consultaDeal as element(ns1:consultaDeal) external;

xf:consultaDealIn($consultaDeal)