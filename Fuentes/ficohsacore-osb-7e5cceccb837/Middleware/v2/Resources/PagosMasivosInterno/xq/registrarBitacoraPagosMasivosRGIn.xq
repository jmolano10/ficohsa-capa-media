(:: pragma  parameter="$soapContent" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/registraBitacoraPagosMasivosRG/xsd/registraBitacoraPagosMasivosRG_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraPagosMasivosRG";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/registrarBitacoraPagosMasivosRGIn/";

declare function xf:registrarBitacoraPagosMasivosRGIn($id as xs:string,
    $customerId as xs:string?,
    $globalId as xs:string?,
    $recordDate as xs:dateTime?,
    $username as xs:string?,
    $authUsername as xs:string?,
    $recordType as xs:string?,
    $soapContent as element(*)?,
    $requestId as xs:string?,
    $responseCode as xs:string?,
    $responseMessage as xs:string?,
    $requestHost as xs:string?,
    $operation as xs:string?,
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:UUID>{ $id }</ns0:UUID>
            <ns0:COUNTRY_CODE>{ $countryCode }</ns0:COUNTRY_CODE>
            <ns0:CUSTOMER_ID>{ $customerId }</ns0:CUSTOMER_ID>
            <ns0:GLOBAL_ID>{ $globalId }</ns0:GLOBAL_ID>
            <ns0:RECORD_DATE>{ $recordDate }</ns0:RECORD_DATE>
            <ns0:USERNAME>{ $username }</ns0:USERNAME>
            <ns0:AUTH_USERNAME>{ $authUsername }</ns0:AUTH_USERNAME>
            <ns0:RECORD_TYPE>{ $recordType }</ns0:RECORD_TYPE>
            <ns0:SOAP_CONTENT>{ $soapContent }</ns0:SOAP_CONTENT>
            <ns0:REQUEST_ID>{ $requestId }</ns0:REQUEST_ID>
            <ns0:RESPONSE_CODE>{ $responseCode }</ns0:RESPONSE_CODE>
            <ns0:RESPONSE_MESSAGE>{ $responseMessage }</ns0:RESPONSE_MESSAGE>
            <ns0:REQUEST_HOST>{ $requestHost }</ns0:REQUEST_HOST>
            <ns0:OPERATION>{ $operation }</ns0:OPERATION>
        </ns0:InputParameters>
};

declare variable $id as xs:string external;
declare variable $customerId as xs:string? external;
declare variable $globalId as xs:string? external;
declare variable $recordDate as xs:dateTime? external;
declare variable $username as xs:string? external;
declare variable $authUsername as xs:string? external;
declare variable $recordType as xs:string? external;
declare variable $soapContent as element(*)? external;
declare variable $requestId as xs:string? external;
declare variable $responseCode as xs:string? external;
declare variable $responseMessage as xs:string? external;
declare variable $requestHost as xs:string? external;
declare variable $operation as xs:string? external;
declare variable $countryCode as xs:string external;

xf:registrarBitacoraPagosMasivosRGIn($id,
    $customerId,
    $globalId,
    $recordDate,
    $username,
    $authUsername,
    $recordType,
    $soapContent,
    $requestId,
    $responseCode,
    $responseMessage,
    $requestHost,
    $operation,
    $countryCode)
