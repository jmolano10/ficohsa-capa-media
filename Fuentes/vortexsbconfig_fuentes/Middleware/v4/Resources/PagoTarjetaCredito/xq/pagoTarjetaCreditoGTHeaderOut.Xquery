<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../v3/BusinessServices/ABKGT/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoGTHeaderOut/";

declare function xf:pagoTarjetaCreditoGTHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <transactionId>{ data($outputParameters/ns1:PN_NUMEROREFERENCIA) }</transactionId>
            {
                for $PV_ERRORCODE in $outputParameters/ns1:PV_ERRORCODE
                return
                    <successIndicator>Success</successIndicator>
            }
            {
                for $PV_ERRORMESSAGE in $outputParameters/ns1:PV_ERRORMESSAGE
                return
                    <messages>{ data($PV_ERRORMESSAGE) }</messages>
            }
            {
                for $PV_DATETIME in $outputParameters/ns1:PV_DATETIME
                return
                    <valueDate>{ substring(data($PV_DATETIME), 1, 8) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:pagoTarjetaCreditoGTHeaderOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../../v3/BusinessServices/ABKGT/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp.xsd">
        <con:schema ref="Middleware/v3/BusinessServices/ABKGT/pagoTarjetaCredito/xsd/pagoTarjetaCredito_sp"/>
    </con:dependency>
    <con:dependency location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>