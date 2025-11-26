(:: pragma bea:global-element-parameter parameter="$consultaComisionesResponse" element="ns0:consultaComisionesResponse" location="../../../../../Middleware/v2/Resources/ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaComisionesH2HResponse" location="../xsd/consultaComisionesH2HTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesH2HTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaComisionesH2H/xq/consultaComisionesH2HOUT/";

declare function xf:consultaComisionesH2HOUT($consultaComisionesResponse as element(ns0:consultaComisionesResponse))
    as element(ns1:consultaComisionesH2HResponse) {
        <ns1:consultaComisionesH2HResponse>
            <CURRENCY>{ data($consultaComisionesResponse/CURRENCY) }</CURRENCY>
            <AMOUNT>{ data($consultaComisionesResponse/AMOUNT) }</AMOUNT>
        </ns1:consultaComisionesH2HResponse>
};

declare variable $consultaComisionesResponse as element(ns0:consultaComisionesResponse) external;

xf:consultaComisionesH2HOUT($consultaComisionesResponse)