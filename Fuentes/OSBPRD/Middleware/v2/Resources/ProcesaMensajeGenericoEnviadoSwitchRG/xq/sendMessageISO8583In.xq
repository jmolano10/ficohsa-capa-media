xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:sendMessageISO8583Request" location="../../../BusinessServices/Switch/actualizaDatosTarjeta/wsdl/updateCardData.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoEnviadoSwitchRG/xq/send/";
declare namespace ns0 = "http://www.ficohsa.com.hn/schema/updateCardDataTypes";

declare function xf:send($message as xs:string)
    as element(ns0:sendMessageISO8583Request) {
        <ns0:sendMessageISO8583Request>
            <message>{ fn:substring-before($message, '|') }</message>
        </ns0:sendMessageISO8583Request>
};

declare variable $message as xs:string external;

xf:send($message)