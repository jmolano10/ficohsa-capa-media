(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/consultaDatosTC/xsd/consultaDatosTC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTCIn/";

declare function xf:consultaDatosTCIn($cardNumber as xs:string,
    $requestHeader as element(ns1:RequestHeader))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ $cardNumber }</ns0:PV_NUMERO_TARJETA>
            <ns0:PV_COUNTRY_CODE>{ data($requestHeader/Region/SourceBank) }</ns0:PV_COUNTRY_CODE>
            
            
            <ns0:PV_USER_NAME>{ data($requestHeader/Authentication/UserName) }</ns0:PV_USER_NAME>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $requestHeader as element(ns1:RequestHeader) external;

xf:consultaDatosTCIn($cardNumber,
    $requestHeader)