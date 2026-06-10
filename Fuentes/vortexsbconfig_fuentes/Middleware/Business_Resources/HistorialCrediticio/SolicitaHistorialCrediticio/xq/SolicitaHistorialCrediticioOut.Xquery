<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ext:eCartera" location="../xsd/SolicitaHistorialCrediticioTypes.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/HistorialCrediticio/xq/SolicitaHistorialCrediticioOut/";
declare namespace soap-env = "http://schemas.xmlsoap.org/soap/envelope/";
declare namespace urn = "urn:infocorp.framework.services.common";
declare namespace urn1 = "urn:infocorp.framework.common";
declare namespace h = "urn:infocorp.framework.services.common"; 
declare namespace i = "http://www.w3.org/2001/XMLSchema-instance";
declare namespace wsa = "http://www.w3.org/2005/08/addressing";
declare namespace wsse = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd";
declare namespace wsu = "http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-utility-1.0.xsd";
declare namespace sol = "http://www.ficohsa.com.hn/middleware.services/SolicitaHistorialCrediticioTypes";


declare function xf:SolicitaHistorialCrediticioOut($transaccionId as xs:string)
    as element(sol:solicitaHistorialCrediticioResponse) {
		&lt;sol:solicitaHistorialCrediticioResponse>
			&lt;sol:TRANSACCION_ID>{ data($transaccionId) }&lt;/sol:TRANSACCION_ID>
		&lt;/sol:solicitaHistorialCrediticioResponse>
};

declare variable $transaccionId as xs:string external;

xf:SolicitaHistorialCrediticioOut($transaccionId)</con:xquery>
    <con:dependency location="../xsd/SolicitaHistorialCrediticioTypes.xsd"/>
</con:xqueryEntry>