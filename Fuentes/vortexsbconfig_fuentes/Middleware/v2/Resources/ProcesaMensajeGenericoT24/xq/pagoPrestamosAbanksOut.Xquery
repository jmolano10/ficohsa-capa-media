<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/pagoPrestamosAbanksOut/";

declare function xf:pagoPrestamosAbanksOut($outputParameters as element(ns1:OutputParameters),
    $TransactionId as xs:string,
    $SessionId as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $TransactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $SessionId }</SESSION_ID>
            <MESSAGE>{ concat($outputParameters/ns1:LOAN_NUMBER , "@FM", $outputParameters/ns1:ERROR_CODE ,"@FM", $outputParameters/ns1:ERROR_MESSAGE) }</MESSAGE>
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $TransactionId as xs:string external;
declare variable $SessionId as xs:string external;

xf:pagoPrestamosAbanksOut($outputParameters,
    $TransactionId,
    $SessionId)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24"/>
    </con:dependency>
    <con:dependency location="../xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
</con:xqueryEntry>