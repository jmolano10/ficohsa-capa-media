xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/xq/validarCrucePaisEmpresa/";

declare function xf:validarCrucePaisEmpresa($requestHeader as element(ns0:RequestHeader))
    as xs:string {
        if (fn:string($requestHeader/Region/SourceBank/text()) = fn:string($requestHeader/Region/DestinationBank/text())) then 
        	 "YES"
        else
        	"NO"
};

declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:validarCrucePaisEmpresa($requestHeader)