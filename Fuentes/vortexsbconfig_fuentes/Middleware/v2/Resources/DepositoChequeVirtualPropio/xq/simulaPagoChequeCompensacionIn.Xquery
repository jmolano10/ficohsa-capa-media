<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$depositoVirtualCheques" element="ns1:depositoVirtualCheques" location="../../DepositoVirtualCheques/xsd/depositoVirtualChequesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:simulaPagoChequeCompensacion" location="../../SimulaPagoChequeCompensacion/xsd/simulaPagoChequeCompensacionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoVirtualChequesTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/simulaPagoChequeCompensacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DepositoChequeVirtualPropio/xq/simulaPagoChequeCompensacionIn/";

declare function xf:simulaPagoChequeCompensacionIn($depositoVirtualCheques as element(ns1:depositoVirtualCheques),
    $virtualClearingZone as xs:string)
    as element(ns0:simulaPagoChequeCompensacion) {
        <ns0:simulaPagoChequeCompensacion>
            <ACCOUNT_NUMBER>{ data($depositoVirtualCheques/CHEQUE_ACCOUNT) }</ACCOUNT_NUMBER>
            <CHEQUE_NUMBER>{ data($depositoVirtualCheques/CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            <AMOUNT>{ data($depositoVirtualCheques/AMOUNT) }</AMOUNT>
            <CURRENCY>{ data($depositoVirtualCheques/CURRENCY) }</CURRENCY>
            <COST_CENTER_CODE>{ $virtualClearingZone }</COST_CENTER_CODE>
            <ROUTE_CODE>{ data($depositoVirtualCheques/TRANSIT_ROUTE) }</ROUTE_CODE>
        </ns0:simulaPagoChequeCompensacion>
};

declare variable $depositoVirtualCheques as element(ns1:depositoVirtualCheques) external;
declare variable $virtualClearingZone as xs:string external;

xf:simulaPagoChequeCompensacionIn($depositoVirtualCheques,
    $virtualClearingZone)]]></con:xquery>
    <con:dependency location="../../DepositoVirtualCheques/xsd/depositoVirtualChequesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DepositoVirtualCheques/xsd/depositoVirtualChequesTypes"/>
    </con:dependency>
    <con:dependency location="../../SimulaPagoChequeCompensacion/xsd/simulaPagoChequeCompensacionTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/SimulaPagoChequeCompensacion/xsd/simulaPagoChequeCompensacionTypes"/>
    </con:dependency>
</con:xqueryEntry>