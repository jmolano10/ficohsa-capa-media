<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoPrestamoResponse" location="../pagoPrestamoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoOut/";

declare function xf:pagoPrestamoOut($outputParameters as element(ns1:OutputParameters),
	$responseLoanNumber as xs:string)
    as element(ns0:pagoPrestamoResponse) {
        <ns0:pagoPrestamoResponse>
            <DATE_TIME>{ data($outputParameters/ns1:DATE_TIME) }</DATE_TIME>
            <LOAN_NUMBER>{ $responseLoanNumber }</LOAN_NUMBER>
            <DUE_ID>{ data($outputParameters/ns1:DUE_ID) }</DUE_ID>
            <PAYMENT_AMOUNT>{ data($outputParameters/ns1:PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
        </ns0:pagoPrestamoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $responseLoanNumber as xs:string external;

xf:pagoPrestamoOut($outputParameters,
	$responseLoanNumber)]]></con:xquery>
    <con:dependency location="../Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24"/>
    </con:dependency>
    <con:dependency location="../pagoPrestamoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoPrestamo/pagoPrestamoTypes"/>
    </con:dependency>
</con:xqueryEntry>