<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$clientesBancarazionResponse1" element="ns1:ClientesBancarazionResponse" location="../../../BusinessServices/T24/consultaClienteBancarizacion/xsd/svcBancarizacionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteBancarizacion/xq/ConsultaClienteBancarizacionHeaderOut/";

declare function xf:ConsultaClienteBancarizacionHeaderOut($clientesBancarazionResponse1 as element(ns1:ClientesBancarazionResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $transactionId in $clientesBancarazionResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $clientesBancarazionResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $clientesBancarazionResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $clientesBancarazionResponse1 as element(ns1:ClientesBancarazionResponse) external;

xf:ConsultaClienteBancarizacionHeaderOut($clientesBancarazionResponse1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/T24/consultaClienteBancarizacion/xsd/svcBancarizacionTypes.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/T24/consultaClienteBancarizacion/xsd/svcBancarizacionTypes"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>