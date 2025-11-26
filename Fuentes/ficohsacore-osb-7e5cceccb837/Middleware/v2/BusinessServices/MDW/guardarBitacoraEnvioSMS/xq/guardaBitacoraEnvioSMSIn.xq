(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/guardaBitacoraEnvioSMS_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardaBitacoraEnvioSMS";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/MDW/guardarBitacoraEnvioSMS/xq/guardaBitacoraEnvioSMSIn/";

declare function xf:guardaBitacoraEnvioSMSIn($trace as xs:string,
    $mobileNumber as xs:string,
    $messageType as xs:string,
    $service as xs:string,
    $company as xs:string,
    $department as xs:string,
    $message as xs:string,
    $supplierAccount as xs:string,
    $messageLength as xs:string,
    $statusMessage as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_TRACE>{ $trace }</ns0:P_TRACE>
            <ns0:P_MOBILE_NUMBER>{ $mobileNumber }</ns0:P_MOBILE_NUMBER>
            <ns0:P_MESSAGE_TYPE>{ $messageType }</ns0:P_MESSAGE_TYPE>
            <ns0:P_SERVICE>{ $service }</ns0:P_SERVICE>
            <ns0:P_COMPANY>{ $company }</ns0:P_COMPANY>
            <ns0:P_DEPARTMENT>{ $department }</ns0:P_DEPARTMENT>
            <ns0:P_MESSAGE>{ $message }</ns0:P_MESSAGE>
            <ns0:P_SUPPLIER_ACCOUNT>{ $supplierAccount }</ns0:P_SUPPLIER_ACCOUNT>
            <ns0:P_MESSAGE_LENGTH>{ $messageLength }</ns0:P_MESSAGE_LENGTH>
            <ns0:P_STATUS_MESSAGE>{ $statusMessage }</ns0:P_STATUS_MESSAGE>
        </ns0:InputParameters>
};

declare variable $trace as xs:string external;
declare variable $mobileNumber as xs:string external;
declare variable $messageType as xs:string external;
declare variable $service as xs:string external;
declare variable $company as xs:string external;
declare variable $department as xs:string external;
declare variable $message as xs:string external;
declare variable $supplierAccount as xs:string external;
declare variable $messageLength as xs:string external;
declare variable $statusMessage as xs:string external;

xf:guardaBitacoraEnvioSMSIn($trace,
    $mobileNumber,
    $messageType,
    $service,
    $company,
    $department,
    $message,
    $supplierAccount,
    $messageLength,
    $statusMessage)