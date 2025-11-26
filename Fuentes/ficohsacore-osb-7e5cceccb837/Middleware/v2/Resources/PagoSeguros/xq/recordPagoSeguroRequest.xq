(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$pagoSeguro1" element="ns0:pagoSeguro" location="../xsd/pagoSeguroTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoSeguroTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoSeguros/xq/recordPagoSeguroRequest/";

declare function xf:recordPagoSeguroRequest($requestHeader1 as element(ns1:RequestHeader),
    $pagoSeguro1 as element(ns0:pagoSeguro))
    as xs:string {
        concat(fn-bea:serialize($requestHeader1), fn-bea:serialize($pagoSeguro1))        
        
};

declare variable $requestHeader1 as element(ns1:RequestHeader) external;
declare variable $pagoSeguro1 as element(ns0:pagoSeguro) external;

xf:recordPagoSeguroRequest($requestHeader1,
    $pagoSeguro1)