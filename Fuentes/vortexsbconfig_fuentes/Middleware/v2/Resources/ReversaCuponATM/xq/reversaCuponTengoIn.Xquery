<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:reversioncupon" location="../../../BusinessServices/TENGO/umarketscReversiones/xsd/serviceATM_3.xsd" ::)

declare namespace ns0 = "http://appATM/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaCuponATM/xq/reversaCuponTengoIn/";

declare function xf:reversaCuponTengoIn($transactionId as xs:string)
    as element(ns0:reversioncupon) {
        &lt;ns0:reversioncupon>
            &lt;TrxidTengo>{ $transactionId }&lt;/TrxidTengo>
        &lt;/ns0:reversioncupon>
};

declare variable $transactionId as xs:string external;

xf:reversaCuponTengoIn($transactionId)</con:xquery>
    <con:dependency location="../../../BusinessServices/TENGO/umarketscReversiones/xsd/serviceATM_3.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TENGO/umarketscReversiones/xsd/serviceATM_3"/>
    </con:dependency>
</con:xqueryEntry>