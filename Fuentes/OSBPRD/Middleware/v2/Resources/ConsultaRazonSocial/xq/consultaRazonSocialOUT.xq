(:: pragma bea:global-element-return element="ns0:consultaRazonSocialResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRazonSocial/xq/consultaRazonSocialOUT/";

declare function xf:consultaRazonSocialOUT($RazonSocial as xs:string)
    as element(ns0:consultaRazonSocialResponse) {
        <ns0:consultaRazonSocialResponse>
            <BUSINESS_NAME>{ $RazonSocial }</BUSINESS_NAME>
        </ns0:consultaRazonSocialResponse>
};

declare variable $RazonSocial as xs:string external;

xf:consultaRazonSocialOUT($RazonSocial)