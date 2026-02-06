xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$envioMensajeSMS" element="ns0:envioMensajeSMS" location="envioMensajeSMSTypes.xsd" ::)

declare namespace ns2 = "";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/envioMensajeSMSTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/envioMensajeSMS/EnvioMensajeSMS/envioMensajeSMSValidateRequired/";

declare function xf:envioMensajeSMSValidateRequired($envioMensajeSMS as element(ns0:envioMensajeSMS))
    as xs:boolean {
        if ((:Campos Obligatorios :)
        	fn:string($envioMensajeSMS/MOBILE_NUMBER/text()) != "" and 
        	fn:string($envioMensajeSMS/MESSAGE/text()) != "" and 
        	fn:string($envioMensajeSMS/MESSAGE_TYPE/text()) != "" and 
        	fn:string($envioMensajeSMS/MESSAGE_SOURCE/COMPANY/text()) != "" and 
        	fn:string($envioMensajeSMS/MESSAGE_SOURCE/DEPT_CODE/text()) != "" and
        	fn:string($envioMensajeSMS/SERVICE/text()) != "" and
        	(: Tipos de Mensajes Permitidos :)
        	fn:string($envioMensajeSMS/MESSAGE_TYPE/text()) = ("ALERT","ADVERTISING","REMINDER","RESPONSE")
        	
        	) then (
        	xs:boolean("1")	
        ) else (
        	xs:boolean("0")
        )
};

declare variable $envioMensajeSMS as element(ns0:envioMensajeSMS) external;

xf:envioMensajeSMSValidateRequired($envioMensajeSMS)