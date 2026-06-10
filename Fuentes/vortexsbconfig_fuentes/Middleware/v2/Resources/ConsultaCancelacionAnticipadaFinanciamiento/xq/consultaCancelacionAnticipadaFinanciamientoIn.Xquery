<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCancelacionAnticipadaFinanciamiento" element="ns0:consultaCancelacionAnticipadaFinanciamiento" location="../../../../../v2/Resources/ConsultaCancelacionAnticipadaFinanciamiento/xsd/consultaCancelacionAnticipadaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada" location="wsdl/consultaCancelacionAnticipadaFinanciamiento.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaCancelacionAnticipadaFinanciamientoTypes";
declare namespace ns1 = "http://soap.sforce.com/schemas/class/WS_CreateCaseHelper";
declare namespace xf = "http://tempuri.org/Middleware/External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/consultaCancelacionAnticipadaFinanciamientoIn/";

declare function xf:consultaCancelacionAnticipadaFinanciamientoIn($consultaCancelacionAnticipadaFinanciamiento as element(ns0:consultaCancelacionAnticipadaFinanciamiento))
    as element(ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada) {
        &lt;ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada>
            &lt;ns1:numeroCuenta>{ data($consultaCancelacionAnticipadaFinanciamiento/CREDIT_CARD_ACCOUNT_NUMBER) }&lt;/ns1:numeroCuenta>
        &lt;/ns1:ConsultaSaldosFinanciamientosCancelacionAnticipada>
};

declare variable $consultaCancelacionAnticipadaFinanciamiento as element(ns0:consultaCancelacionAnticipadaFinanciamiento) external;

xf:consultaCancelacionAnticipadaFinanciamientoIn($consultaCancelacionAnticipadaFinanciamiento)</con:xquery>
    <con:dependency location="../../../../../v2/Resources/ConsultaCancelacionAnticipadaFinanciamiento/xsd/consultaCancelacionAnticipadaFinanciamientoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaCancelacionAnticipadaFinanciamiento/xsd/consultaCancelacionAnticipadaFinanciamientoTypes"/>
    </con:dependency>
    <con:dependency location="wsdl/consultaCancelacionAnticipadaFinanciamiento.wsdl">
        <con:wsdl ref="Middleware/External/Outgoing/BusinessServices/Salesforce/consultaCancelacionAnticipadaFinanciamiento/wsdl/consultaCancelacionAnticipadaFinanciamiento"/>
    </con:dependency>
</con:xqueryEntry>