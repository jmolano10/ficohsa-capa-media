<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesaPorNombreYMetodoResponse" element="ns0:consultaRemesaPorNombreYMetodoResponse" location="../../../../Resources/ConsultaRemesaPorNombreYMetodo/xsd/consultaRemesaPorNombreYMetodoTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaRemesaPorNombreResponse/ns1:consultaRemesaPorNombreResponseType/ns1:consultaRemesaPorNombreResponseRecordType" location="../xsd/sjConsultaRemesaPorNombre.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaRemesaPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesaPorNombreYMetodoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaRemesaPorNombre/xq/consultaRemesaPorNombreYMetodoOut2/";

declare function xf:consultaRemesaPorNombreYMetodoOut2($consultaRemesaPorNombreYMetodoResponse as element(ns0:consultaRemesaPorNombreYMetodoResponse),
	$contadorRemesas as xs:int)
    as element() {
        let $consultaRemesaPorNombreYMetodoResponseRecordType := $consultaRemesaPorNombreYMetodoResponse/ns0:consultaRemesaPorNombreYMetodoResponseType/ns0:consultaRemesaPorNombreYMetodoResponseRecordType[$contadorRemesas]
        return
            <ns1:consultaRemesaPorNombreResponseRecordType>
                <ns1:REMITTANCE_ID>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/REMITTANCE_ID) }</ns1:REMITTANCE_ID>
                <ns1:REMITTER_ID>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/REMITTER_ID) }</ns1:REMITTER_ID>
                <ns1:REMITTER_NAME>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/REMITTER_NAME) }</ns1:REMITTER_NAME>
                <ns1:BENEFICIARY_NAME>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/BENEFICIARY_NAME) }</ns1:BENEFICIARY_NAME>
                <ns1:BRANCH_NAME>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/BRANCH_NAME) }</ns1:BRANCH_NAME>
                <ns1:PAYMENT_DATE>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/PAYMENT_DATE) }</ns1:PAYMENT_DATE>
                <ns1:CURRENCY>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/CURRENCY) }</ns1:CURRENCY>
                <ns1:EXCHANGE_RATE>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/EXCHANGE_RATE) }</ns1:EXCHANGE_RATE>
                <ns1:REMITTANCE_STATUS>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/REMITTANCE_STATUS) }</ns1:REMITTANCE_STATUS>
                <ns1:REMITTANCE_AMOUNT>{ data($consultaRemesaPorNombreYMetodoResponseRecordType/REMITTANCE_AMOUNT) }</ns1:REMITTANCE_AMOUNT>
            </ns1:consultaRemesaPorNombreResponseRecordType>
};

declare variable $consultaRemesaPorNombreYMetodoResponse as element(ns0:consultaRemesaPorNombreYMetodoResponse) external;
declare variable $contadorRemesas as xs:int external;
xf:consultaRemesaPorNombreYMetodoOut2($consultaRemesaPorNombreYMetodoResponse, $contadorRemesas)]]></con:xquery>
    <con:dependency location="../../../../Resources/ConsultaRemesaPorNombreYMetodo/xsd/consultaRemesaPorNombreYMetodoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xsd/consultaRemesaPorNombreYMetodoTypes"/>
    </con:dependency>
    <con:dependency location="../xsd/sjConsultaRemesaPorNombre.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaRemesaPorNombre/xsd/sjConsultaRemesaPorNombre"/>
    </con:dependency>
</con:xqueryEntry>