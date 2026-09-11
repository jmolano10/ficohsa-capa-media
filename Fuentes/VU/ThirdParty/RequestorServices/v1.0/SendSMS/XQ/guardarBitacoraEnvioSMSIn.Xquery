<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardaBitacoraEnvioSMS_db";
(:: import schema at "../../../../ProviderServices/XSD/guardarBitacoraEnvioSMS/guardaBitacoraEnvioSMS_db_sp.xsd" ::)

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

declare function local:funcGuardarBitacoraEnvioSMSIn($trace as xs:string,
                                                      $mobileNumber as xs:string,
                                                      $messageType as xs:string,
                                                      $service as xs:string,
                                                      $company as xs:string,
                                                      $department as xs:string,
                                                      $message as xs:string,
                                                      $supplierAccount as xs:string,
                                                      $messageLength as xs:string,
                                                      $statusMessage as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:P_TRACE>{fn:data($trace)}</ns1:P_TRACE>
        <ns1:P_MOBILE_NUMBER>{fn:data($mobileNumber)}</ns1:P_MOBILE_NUMBER>
        <ns1:P_MESSAGE_TYPE>{fn:data($messageType)}</ns1:P_MESSAGE_TYPE>
        <ns1:P_SERVICE>{fn:data($service)}</ns1:P_SERVICE>
        <ns1:P_COMPANY>{fn:data($company)}</ns1:P_COMPANY>
        <ns1:P_DEPARTMENT>{fn:data($department)}</ns1:P_DEPARTMENT>
        <ns1:P_MESSAGE>{fn:data($message)}</ns1:P_MESSAGE>
        <ns1:P_SUPPLIER_ACCOUNT>{fn:data($supplierAccount)}</ns1:P_SUPPLIER_ACCOUNT>
        <ns1:P_MESSAGE_LENGTH>{fn:data($messageLength)}</ns1:P_MESSAGE_LENGTH>
        <ns1:P_STATUS_MESSAGE>
        {
          if (fn:upper-case(fn:data($statusMessage)) = 'OK') then
            'Exitoso'
          else
            'Fallido'
        }
        </ns1:P_STATUS_MESSAGE>
    </ns1:InputParameters>
};

local:funcGuardarBitacoraEnvioSMSIn($trace,
    $mobileNumber,
    $messageType,
    $service,
    $company,
    $department,
    $message,
    $supplierAccount,
    $messageLength,
    $statusMessage)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../../ProviderServices/XSD/guardarBitacoraEnvioSMS/guardaBitacoraEnvioSMS_db_sp.xsd">
            <con:schema ref="ThirdParty/ProviderServices/XSD/guardarBitacoraEnvioSMS/guardaBitacoraEnvioSMS_db_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>