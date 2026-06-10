<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaChequesReserva" element="ns0:consultaChequesReserva" location="consultaChequesReservaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesReservaTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaValidate/";

declare function xf:consultaChequesReservaValidate($consultaChequesReserva as element(ns0:consultaChequesReserva))
    as xs:string {
        if (fn:string($consultaChequesReserva/ACCOUNT_NUMBER/text()) = "") then (
        	"REQUIRED FIELDS NOT SUPPLIED"
        	
        ) else (
        	""
        )
};

declare variable $consultaChequesReserva as element(ns0:consultaChequesReserva) external;

xf:consultaChequesReservaValidate($consultaChequesReserva)</con:xquery>
    <con:dependency location="consultaChequesReservaTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaCheque/consultaChequesReserva/consultaChequesReservaTypes"/>
    </con:dependency>
</con:xqueryEntry>