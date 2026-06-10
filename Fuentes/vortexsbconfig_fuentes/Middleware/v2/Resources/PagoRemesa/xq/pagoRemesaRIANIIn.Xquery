<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns2:pagoRemesas" location="../xsd/pagoRemesas.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:payCashPickUpOrderRequest" location="../../../BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder.wsdl" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/riaMoneyTransferTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRelConPago";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaRIANIIn/";

declare function xf:pagoRemesaRIANIIn($pagoRemesas as element(ns2:pagoRemesas),
    $outputParameters as element(ns0:OutputParameters),
    $riaCallerCorrelationId as xs:string,
    $riaAgentId as xs:string,
    $ocpApimSubscriptionKey as xs:string)
    as element(ns1:payCashPickUpOrderRequest) {
        <ns1:payCashPickUpOrderRequest>
            <ns1:HeaderParams>
                <ns1:riaCallerCorrelationId>{ $riaCallerCorrelationId }</ns1:riaCallerCorrelationId>
                <ns1:riaCallDateTimeLocal>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns1:riaCallDateTimeLocal>
                <ns1:riaAgentId>{ $riaAgentId }</ns1:riaAgentId>
                <ns1:ocpApimSubscriptionKey>{ $ocpApimSubscriptionKey }</ns1:ocpApimSubscriptionKey>
            </ns1:HeaderParams>
            <ns1:BeneAmount>{  string($outputParameters/ns0:PN_MONTO/text()) }</ns1:BeneAmount>
	        <ns1:BeneCity>{ fn:data($pagoRemesas/BENEFICIARY_INFO/CITY) }</ns1:BeneCity>
	        <ns1:BeneCountry>{ fn:data($pagoRemesas/BENEFICIARY_INFO/COUNTRY) }</ns1:BeneCountry> 
	        <ns1:BeneCurrency>{ string($outputParameters/ns0:PV_MONEDA/text()) }</ns1:BeneCurrency>
	        {
	          let $beneIDExpirationDate := string($pagoRemesas/ADDITIONAL_INFO/INFO[NAME = "BENEFICIARY_ID_EXPIRATION_DATE"]/VALUE/text())
	          return
	            <ns1:BeneIDExpirationDate>{ $beneIDExpirationDate }</ns1:BeneIDExpirationDate>
	        }
	        <ns1:BeneIDIssuedByCountry>{ fn:data($pagoRemesas/BENEFICIARY_INFO/COUNTRY) }</ns1:BeneIDIssuedByCountry>
	        <ns1:BeneIDIssuedByState>{ fn:data($pagoRemesas/BENEFICIARY_INFO/ID_ISSUE_DATE)}</ns1:BeneIDIssuedByState>
	        <ns1:BeneIDNumber>{ fn:data($pagoRemesas/BENEFICIARY_INFO/ID)}</ns1:BeneIDNumber>
	        <ns1:BeneIDType>{ fn:data($pagoRemesas/BENEFICIARY_INFO/ID_TYPE) }</ns1:BeneIDType>
	        <ns1:BeneState>{ fn:data($pagoRemesas/BENEFICIARY_INFO/STATE) }</ns1:BeneState>
	        <ns1:CorrespLocID>{ string($pagoRemesas/BRANCHCODE/text()) }</ns1:CorrespLocID>
	        <ns1:DateTimeLocal>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns1:DateTimeLocal>
	        <ns1:DateTimeUTC>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns1:DateTimeUTC>
	        <ns1:OrderNo>{ string($outputParameters/ns0:PV_CODORDEN/text()) }</ns1:OrderNo>
	        <ns1:PIN>{ fn:data($pagoRemesas/REMITTANCE_ID) }</ns1:PIN>
	        <ns1:PaidDateTimeLocal>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns1:PaidDateTimeLocal>
	        <ns1:PaidDateTimeUTC>{ fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</ns1:PaidDateTimeUTC>
	        <ns1:VerifyOrderTransRefID>{ string($outputParameters/ns0:PV_CODIGOTRANSACCION/text()) }</ns1:VerifyOrderTransRefID>
        </ns1:payCashPickUpOrderRequest>
};

declare variable $pagoRemesas as element(ns2:pagoRemesas) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $riaCallerCorrelationId as xs:string external;
declare variable $riaAgentId as xs:string external;
declare variable $ocpApimSubscriptionKey as xs:string external;

xf:pagoRemesaRIANIIn($pagoRemesas,
    $outputParameters,
    $riaCallerCorrelationId,
    $riaAgentId,
    $ocpApimSubscriptionKey)]]></con:xquery>
    <con:dependency location="../xsd/pagoRemesas.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRemesa/xsd/pagoRemesas"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/consultaRelConPagoNI/xsd/consultaRelConPago_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/Remesas/RIANI/payCashPickUpOrder/wsdl/payCashPickUpOrder"/>
    </con:dependency>
</con:xqueryEntry>