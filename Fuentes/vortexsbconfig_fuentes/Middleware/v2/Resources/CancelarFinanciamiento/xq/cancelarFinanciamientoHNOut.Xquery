<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionesGenericasCRMResponse" element="ns0:gestionesGenericasCRMResponse" location="../../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelarFinanciamientoResponse" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CancelarFinanciamiento/xq/cancelarFinanciamientoHNOut/";

declare function xf:cancelarFinanciamientoHNOut($gestionesGenericasCRMResponse as element(ns0:gestionesGenericasCRMResponse),
    $uuid as xs:string,
    $transactionId as xs:string)
    as element(ns1:cancelarFinanciamientoResponse) {
        <ns1:cancelarFinanciamientoResponse>
            <INTERFACE_REFERENCE_NO>{ $uuid }</INTERFACE_REFERENCE_NO>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <CASE_DETAILS>
                {
                    for $REFERENCE_ID in $gestionesGenericasCRMResponse/REFERENCE_ID
                    return
                        <REFERENCE>{ data($REFERENCE_ID) }</REFERENCE>
                }
            </CASE_DETAILS>
        </ns1:cancelarFinanciamientoResponse>
};

declare variable $gestionesGenericasCRMResponse as element(ns0:gestionesGenericasCRMResponse) external;
declare variable $uuid as xs:string external;
declare variable $transactionId as xs:string external;

xf:cancelarFinanciamientoHNOut($gestionesGenericasCRMResponse,
    $uuid,
    $transactionId)]]></con:xquery>
    <con:dependency location="../../GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes"/>
    </con:dependency>
    <con:dependency location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesTarjetas/xsd/gestionesTarjetasTypes"/>
    </con:dependency>
</con:xqueryEntry>