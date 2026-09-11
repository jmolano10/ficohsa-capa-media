<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://ficohsa.com/EnvioSMS";
(:: import schema at "../xsd/envioSMSResponse.xsd" ::)
declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../Esquemas_Generales/HeaderElements.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $headerRSP as element() (:: schema-element(ns1:ResponseHeader) ::) external;
declare variable $receiverNumber as xs:string external;
declare variable $message as xs:string external;
declare variable $creationTimestamp as xs:string external;

declare function local:formatDate($stringDate as xs:string){
let $formatDate := fn:current-dateTime()

(: Convierte string-fecha a epoch :)
let $unixDate := (xs:dateTime($formatDate) - xs:dateTime("1970-01-01T00:00:00-00:00")) div xs:dayTimeDuration('PT0.001S')
return $unixDate
};



declare function xq:TxEnvioSmsResponse($headerRSP as element() (:: schema-element(ns1:ResponseHeader) ::), 
                                       $receiverNumber as xs:string, 
                                       $message as xs:string,
                                       $creationTimestamp as xs:string) 
                                       as element() (:: schema-element(ns2:EnvioSMSResponse) ::) {
    <ns2:EnvioSMSResponse>
        <ns2:code>
        {
        if (fn:data($headerRSP/successIndicator)='Success')
        then
        '1003'
        else
        if (fn:data($headerRSP/successIndicator)='ERROR')
        then
        '1004'
        else ()
        }
        </ns2:code>
        <ns2:message>
        {
        if (fn:data($headerRSP/successIndicator)='Success')
        then
        'SMS SEND'
        else
        if (fn:data($headerRSP/successIndicator)='ERROR')
        then
        'SMS FAILED'
        else ()
        }
        </ns2:message>
        <ns2:smsOperation>
            <ns2:id></ns2:id>
            <ns2:senderNumber></ns2:senderNumber>
            <ns2:receiverNumber>{fn:data($receiverNumber)}</ns2:receiverNumber>
            <ns2:message>{fn:data($message)}</ns2:message>
            <ns2:resultCode></ns2:resultCode>
            <ns2:result></ns2:result>
            <ns2:fail>
        {
        if (fn:data($headerRSP/successIndicator)='Success')
        then
        'True'
        else
        if (fn:data($headerRSP/successIndicator)='ERROR')
        then
        'False'
        else ()
        }            
            </ns2:fail>
            <ns2:attempts>1</ns2:attempts>
            <ns2:externalId></ns2:externalId>
            <ns2:creationTimestamp>{fn:data($creationTimestamp)}</ns2:creationTimestamp>
            <ns2:resultTimestamp>{ xq:formatDate('')}</ns2:resultTimestamp>
        </ns2:smsOperation>
    </ns2:EnvioSMSResponse>
};

xq:TxEnvioSmsResponse($headerRSP, $receiverNumber, $message,$creationTimestamp)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../xsd/envioSMSResponse.xsd">
            <con:schema ref="Middleware/v2/Resources/envioMensajeSMS/xsd/envioSMSResponse"/>
        </con:importSchema>
        <con:importSchema location="../../Esquemas_Generales/HeaderElements.xsd">
            <con:schema ref="Middleware/v2/Resources/Esquemas_Generales/HeaderElements"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>