<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/envioMensajeSMSTypes";
(:: import schema at "../xsd/envioMensajeSMSTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $mobileNumber as xs:string external;
declare variable $message as xs:string external;

declare function xq:envioSmsIn($mobileNumber as xs:string, 
                               $message as xs:string) 
                               as element() (:: schema-element(ns1:envioMensajeSMS) ::) {
    <ns1:envioMensajeSMS>
        <MOBILE_NUMBER>{fn:data($mobileNumber)}</MOBILE_NUMBER>
        <MESSAGE>{fn:data($message)}</MESSAGE>
        <MESSAGE_TYPE>ALERT</MESSAGE_TYPE>
        <SERVICE>ALERTA</SERVICE>
        <MESSAGE_SOURCE>
            <COMPANY>FICOHSA</COMPANY>
            <DEPT_CODE>CHANNELS</DEPT_CODE>
            <APPLICATION></APPLICATION>
        </MESSAGE_SOURCE>
        <ERROR_CODE></ERROR_CODE>
    </ns1:envioMensajeSMS>
};

xq:envioSmsIn($mobileNumber, $message)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/envioMensajeSMSTypes.xsd">
            <con:schema ref="Middleware/v2/Resources/envioMensajeSMS/xsd/envioMensajeSMSTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>