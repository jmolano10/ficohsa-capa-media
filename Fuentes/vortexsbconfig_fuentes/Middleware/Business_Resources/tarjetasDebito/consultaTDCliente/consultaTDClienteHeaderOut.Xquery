<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse1" element="ns0:ConsultaMaestraTarjetaDebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteHeaderOut/";

declare function xf:consultaTDClienteHeaderOut($consultaMaestraTarjetaDebitoResponse1 as element(ns0:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultaMaestraTarjetaDebitoResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $Status in $consultaMaestraTarjetaDebitoResponse1/Status/messages
                return
                    <messages>{ data($Status) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultaMaestraTarjetaDebitoResponse1 as element(ns0:ConsultaMaestraTarjetaDebitoResponse) external;

xf:consultaTDClienteHeaderOut($consultaMaestraTarjetaDebitoResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-155258746.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>