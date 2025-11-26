(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDatosTarjetaCredito" element="ns0:consultaDatosTarjetaCredito" location="../xsd/consultaDatosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CLIENTDATA/consultaDatosTC_v2/xsd/consultaDatosTC_V2_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC_V2";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTCIn/";

declare function xf:consultaDatosTCIn($requestHeader as element(ns2:RequestHeader),
    $consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NUMERO_TARJETA>{ data($consultaDatosTarjetaCredito/CARD_NUMBER) }</ns1:PV_NUMERO_TARJETA>
            <ns1:PV_COUNTRY_CODE>{ data($requestHeader/Region/SourceBank) }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};

declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $consultaDatosTarjetaCredito as element(ns0:consultaDatosTarjetaCredito) external;

xf:consultaDatosTCIn($requestHeader,
    $consultaDatosTarjetaCredito)