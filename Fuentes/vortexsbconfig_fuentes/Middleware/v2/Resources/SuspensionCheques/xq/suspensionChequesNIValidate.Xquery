<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$suspensionChequesRequest" element="ns0:suspensionChequesRequest" location="../xsd/suspensionChequesTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/suspensionChequesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SuspensionCheques/xq/suspensionChequesNIValidate/";

declare function xf:suspensionChequesNIValidate($suspensionChequesRequest as element(ns0:suspensionChequesRequest))
    as xs:string {
        if (fn:string($suspensionChequesRequest/PAYMENT_STOP_MOTIVE/text())= "LOST" 
        	or fn:string($suspensionChequesRequest/PAYMENT_STOP_MOTIVE/text())= "STOLEN")then
        	xs:string("")
        else 
        	xs:string("INVALID VALUE FOR PAYMENT_STOP_MOTIVE")    	
};

declare variable $suspensionChequesRequest as element(ns0:suspensionChequesRequest) external;

xf:suspensionChequesNIValidate($suspensionChequesRequest)</con:xquery>
    <con:dependency location="../xsd/suspensionChequesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/SuspensionCheques/xsd/suspensionChequesTypes"/>
    </con:dependency>
</con:xqueryEntry>