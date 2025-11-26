(:: pragma bea:global-element-parameter parameter="$consultaComisionSwiftResponse" element="ns1:consultaComisionSwiftResponse" location="../../../../Business_Resources/consultaComisionSWIFT/consultaComisionSwiftTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisionesResponse" location="../xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionSwiftTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisiones/xq/consultaComisionInternacionalPAOut/";

declare function xf:consultaComisionesInternacionalPAOut($consultaComisionSwiftResponse as element(ns1:consultaComisionSwiftResponse))
    as element(ns0:consultaComisionesResponse) {
        <ns0:consultaComisionesResponse>
            <CURRENCY>{ data($consultaComisionSwiftResponse/CHARGE_CURRENCY) }</CURRENCY>
            <AMOUNT>{ data($consultaComisionSwiftResponse/CHARGE_AMOUNT) }</AMOUNT>
        </ns0:consultaComisionesResponse>
};

declare variable $consultaComisionSwiftResponse as element(ns1:consultaComisionSwiftResponse) external;

xf:consultaComisionesInternacionalPAOut($consultaComisionSwiftResponse)