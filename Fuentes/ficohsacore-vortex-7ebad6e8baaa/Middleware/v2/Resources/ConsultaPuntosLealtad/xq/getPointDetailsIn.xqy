xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:getPointDetails" location="../../../BusinessServices/Mastercard/CustomerService/xsd/CustomerService.xsd" ::)

declare namespace ns0 = "http://customer.ws.mcrewards.mastercard.com/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsIn/";

declare function xf:getPointDetailsIn()
as element(ns0:getPointDetails) {
    <ns0:getPointDetails>
        <ns0:components>currentBalance</ns0:components>
    </ns0:getPointDetails>
};


xf:getPointDetailsIn()