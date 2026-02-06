xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:getPointDetails" location="../../../BusinessServices/Mastercard/CustomerService/xsd/CustomerService.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsInGT/";
declare namespace ns0 = "http://customer.ws.mcrewards.mastercard.com/";

declare function xf:getPointDetailsInGT()
as element(ns0:getPointDetails) {
    <ns0:getPointDetails>
        <ns0:components>currentBalance</ns0:components>
    </ns0:getPointDetails>
};


xf:getPointDetailsInGT()