<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:getPointDetails" location="../../../BusinessServices/Mastercard/CustomerService/xsd/CustomerService.xsd" ::)

declare namespace ns0 = "http://customer.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsIn/";

declare function xf:getPointDetailsIn()
as element(ns0:getPointDetails) {
    &lt;ns0:getPointDetails>
        &lt;ns0:components>currentBalance&lt;/ns0:components>
    &lt;/ns0:getPointDetails>
};


xf:getPointDetailsIn()</con:xquery>
    <con:dependency location="../../../BusinessServices/Mastercard/CustomerService/xsd/CustomerService.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/Mastercard/CustomerService/xsd/CustomerService"/>
    </con:dependency>
</con:xqueryEntry>