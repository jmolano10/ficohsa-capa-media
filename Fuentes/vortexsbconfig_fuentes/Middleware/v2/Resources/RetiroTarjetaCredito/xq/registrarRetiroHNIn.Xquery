<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:registrarRetiro" location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/registrarRetiroIn/";

declare function xf:registrarRetiroIn($retiroTarjetaCredito as element(ns1:retiroTarjetaCredito),
    $requestHeader as element(ns2:RequestHeader),
    $secuenciaIdRetiro as xs:string)
    as element(ns0:registrarRetiro) {
        <ns0:registrarRetiro>
            <ns0:noTarjetaCredito>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/VALUE) }</ns0:noTarjetaCredito>
            {
                for $EXPIRATION_DATE in $retiroTarjetaCredito/CREDIT_CARD_INFO/EXPIRATION_DATE
                return
                    <ns0:fechaExpiracion>{ data($EXPIRATION_DATE) }</ns0:fechaExpiracion>
            }
            <ns0:montoRetiro>{ data($retiroTarjetaCredito/AMOUNT) }</ns0:montoRetiro>
            <ns0:monedaRetiro>
                {
                    let $currency  := (fn:string($retiroTarjetaCredito/CURRENCY/text()))  
                    return
                        if ($currency = "HNL") then
                            (340)
                        else 
                            if ($currency = "USD") then
                                (840)
                            else 
                                0
                }
			</ns0:monedaRetiro>
            <ns0:canalRetiro>{ data($requestHeader/Authentication/UserName) }</ns0:canalRetiro>
            <ns0:fechaRetiro>{ fn-bea:date-to-string-with-format('MMddyyyy', fn:current-date()) }</ns0:fechaRetiro>
            <ns0:idRefRetiro>{ $secuenciaIdRetiro }</ns0:idRefRetiro>
        </ns0:registrarRetiro>
};

declare variable $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito) external;
declare variable $requestHeader as element(ns2:RequestHeader) external;
declare variable $secuenciaIdRetiro as xs:string external;

xf:registrarRetiroIn($retiroTarjetaCredito,
    $requestHeader,
    $secuenciaIdRetiro)]]></con:xquery>
    <con:dependency location="../xsd/retiroTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroTarjetaCredito/xsd/retiroTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ALCN/tarjetaCredito/wsdl/TarjetaDeCredito"/>
    </con:dependency>
</con:xqueryEntry>