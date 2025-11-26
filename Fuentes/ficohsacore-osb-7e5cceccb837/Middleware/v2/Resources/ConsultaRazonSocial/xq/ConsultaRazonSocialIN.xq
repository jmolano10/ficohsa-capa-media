(:: pragma bea:global-element-parameter parameter="$consultaRazonSocialIN" element="ns0:consultaRazonSocial" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/DEI/consultaRazonSocial/xsd/consultaRazonSocial_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRazonSocial";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRazonSocial/xq/ConsultaRazonSocialIN/";

declare function xf:ConsultaRazonSocialIN($consultaRazonSocialIN as element(ns0:consultaRazonSocial))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_RTN>{ data($consultaRazonSocialIN/RTN) }</ns1:PV_RTN>
        </ns1:InputParameters>
};

declare variable $consultaRazonSocialIN as element(ns0:consultaRazonSocial) external;

xf:ConsultaRazonSocialIN($consultaRazonSocialIN)