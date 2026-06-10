<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT24" element="ns1:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_PAG_PRESTAMO_T24/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/pagoPrestamosAbanksIn/";

declare function xf:pagoPrestamosAbanksIn($requestHeader as element(ns0:RequestHeader),
    $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            {
        	let $messageList := fn:tokenize(data($procesaMensajeGenericoT24/MESSAGE),"@FM") 
        	return (
	            <ns2:LOAN_NUMBER>{  $messageList[1] }</ns2:LOAN_NUMBER>,
	            <ns2:PAYMENT_AMOUNT>{  $messageList[2] }</ns2:PAYMENT_AMOUNT>,
	            <ns2:DEBIT_ACCOUNT>{  $messageList[3] }</ns2:DEBIT_ACCOUNT>,
	            <ns2:INTERFACE_REFERENCE_NO>{  $messageList[4] }</ns2:INTERFACE_REFERENCE_NO>,
	            <ns2:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns2:USERNAME>,
	            <ns2:TRANSACTIONID>{  $messageList[5] }</ns2:TRANSACTIONID>
        	)
        }            
        </ns2:InputParameters>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $procesaMensajeGenericoT24 as element(ns1:procesaMensajeGenericoT24) external;

xf:pagoPrestamosAbanksIn($requestHeader,
    $procesaMensajeGenericoT24)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24"/>
    </con:dependency>
</con:xqueryEntry>