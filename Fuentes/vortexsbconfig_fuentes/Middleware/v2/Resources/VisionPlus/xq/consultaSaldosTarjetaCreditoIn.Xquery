<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ConsultaSaldosTarjetaCredito" location="../../../BusinessServices/VisionPlus/consultaSaldosTarjetaCredito/xsd/ConsultaSaldosTarjetaCreditoService_v2.xsd" ::)

declare namespace ns2 = "http://schemas.datacontract.org/2004/07/Business.Entities";
declare namespace ns1 = "http://schemas.datacontract.org/2004/07/Core.Entities";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VisionPlusNI/xq/consultaSaldosTarjetaCreditoInNI/";

declare function xf:consultaSaldosTarjetaCreditoInNI($org as xs:string,
    $cardNumber as xs:string,
    $sourceBank as xs:string)
    as element(ns0:ConsultaSaldosTarjetaCredito) {
        <ns0:ConsultaSaldosTarjetaCredito>
            <ns0:request>
                <ns2:ConsultaSaldosTarjetaCreditoRequest>
                    <ns2:CardNumber>{ $cardNumber }</ns2:CardNumber>
                    <ns2:Organizacion>{ $org }</ns2:Organizacion>
                </ns2:ConsultaSaldosTarjetaCreditoRequest>
                <ns2:MensajeEntradaInfo>
                    <ns1:Pais>{ $sourceBank }</ns1:Pais>
                </ns2:MensajeEntradaInfo>
            </ns0:request>
        </ns0:ConsultaSaldosTarjetaCredito>
};

declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $sourceBank as xs:string external;

xf:consultaSaldosTarjetaCreditoInNI($org,
    $cardNumber,
    $sourceBank)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisionPlus/consultaSaldosTarjetaCredito/xsd/ConsultaSaldosTarjetaCreditoService_v2.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/VisionPlus/consultaSaldosTarjetaCredito/xsd/ConsultaSaldosTarjetaCreditoService_v2"/>
    </con:dependency>
</con:xqueryEntry>