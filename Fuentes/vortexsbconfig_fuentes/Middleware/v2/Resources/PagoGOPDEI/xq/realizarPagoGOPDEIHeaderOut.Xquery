<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoGOPDEI/xq/realizarPagoGOPDEIHeaderOut/";

declare function xf:realizarPagoGOPDEIHeaderOut($TRANSACTIONID as xs:string, $MessageError as xs:string, $ErrorCode  as xs:string)
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	 {
	        	if($TRANSACTIONID != '') then(
	        		<transactionId>{ $TRANSACTIONID }</transactionId>
	        	) else()
	        }
        	{
	            	if ($MessageError  = '')  then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<messageId>{ $ErrorCode  }</messageId>,
	            	    <successIndicator>ERROR</successIndicator>,
	                    <messages>{ $MessageError }</messages>
	            	) 
            }
        </ns0:ResponseHeader>
};

declare variable $TRANSACTIONID as xs:string external;
declare variable $MessageError as xs:string external;
declare variable $ErrorCode as xs:string external;

xf:realizarPagoGOPDEIHeaderOut($TRANSACTIONID,$MessageError,$ErrorCode)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>