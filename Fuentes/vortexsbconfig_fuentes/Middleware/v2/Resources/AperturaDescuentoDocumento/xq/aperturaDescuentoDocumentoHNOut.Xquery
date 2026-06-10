<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/AperturaDescuentoDocumento/xsd/aperturaDescuentoDocumento_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:aperturaDescuentoDocumentoResponse" location="../xsd/aperturaDescuentoDocumentoTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/aperturaDescuentoDocumento";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaDescuentoDocumentoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AperturaDescuentoDocumento/xq/aperturaDescuentoDocumentoHNOut/";

declare function xf:aperturaDescuentoDocumentoHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:aperturaDescuentoDocumentoResponse) {
        <ns0:aperturaDescuentoDocumentoResponse>
            <NEGOTIATION_NUMBER>{ data($outputParameters/GN_NUMERO_NEGOCIACION) }</NEGOTIATION_NUMBER>
            <MOV_SEQUENCE>{ data($outputParameters/GN_SECUENCIA_MOVIMIENTO) }</MOV_SEQUENCE>
            <EXPENSE_DISBURSEMENT>{ data($outputParameters/GN_GASTO_DESEMBOLSO) }</EXPENSE_DISBURSEMENT>
        </ns0:aperturaDescuentoDocumentoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:aperturaDescuentoDocumentoHNOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/AperturaDescuentoDocumento/xsd/aperturaDescuentoDocumento_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/AperturaDescuentoDocumento/xsd/aperturaDescuentoDocumento_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/aperturaDescuentoDocumentoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AperturaDescuentoDocumento/xsd/aperturaDescuentoDocumentoTypes"/>
    </con:dependency>
</con:xqueryEntry>