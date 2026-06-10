<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjPagoMultipleRecaudoResponse" element="ns1:sjPagoMultipleRecaudoResponse" location="../../../BusinessServices/SJS/pagoMultipleRecaudo/xsd/sjPagoMultipleRecaudo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjPagoMultipleRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoMultipleRecaudo/xq/pagoMultipleRecaudoHeaderOut/";

declare function xf:pagoMultipleRecaudoHeaderOut($sjPagoMultipleRecaudoResponse as element(ns1:sjPagoMultipleRecaudoResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>{ data($sjPagoMultipleRecaudoResponse/SUCCESS_INDICATOR) }</successIndicator>
            {
                for $ERROR_MESSAGE in $sjPagoMultipleRecaudoResponse/ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $sjPagoMultipleRecaudoResponse as element(ns1:sjPagoMultipleRecaudoResponse) external;

xf:pagoMultipleRecaudoHeaderOut($sjPagoMultipleRecaudoResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/SJS/pagoMultipleRecaudo/xsd/sjPagoMultipleRecaudo.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/pagoMultipleRecaudo/xsd/sjPagoMultipleRecaudo"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>