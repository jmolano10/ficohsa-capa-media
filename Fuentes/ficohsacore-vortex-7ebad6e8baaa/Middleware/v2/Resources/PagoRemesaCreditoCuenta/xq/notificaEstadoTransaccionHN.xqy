xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:notificaEstadoTransaccion" location="../../NotificaEstadoTransaccion/xsd/notificaEstadoTransaccionTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/notificaEstadoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesaCreditoCuenta/xq/notificaEstadoTransaccionHN/";

declare function xf:notificaEstadoTransaccionHN($customerId as xs:string,
    $mobileNumber as xs:string,
    $message as xs:string,
    $messageType as xs:string,
    $service as xs:string,
    $company as xs:string,
    $departmentCode as xs:string,
    $application as xs:string,
    $errorCode as xs:string)
    as element(ns0:notificaEstadoTransaccion) {
        <ns0:notificaEstadoTransaccion>
            <ns0:CUSTOMER_ID>{ $customerId }</ns0:CUSTOMER_ID>
            <ns0:MOBILE_NUMBER>{ $mobileNumber }</ns0:MOBILE_NUMBER>
            <ns0:MESSAGE>{ $message }</ns0:MESSAGE>
            <ns0:MESSAGE_TYPE>{ $messageType }</ns0:MESSAGE_TYPE>
            <ns0:SERVICE>{ $service }</ns0:SERVICE>
            <ns0:MESSAGE_SOURCE>
                <ns0:COMPANY>{ $company }</ns0:COMPANY>
                <ns0:DEPT_CODE>{ $departmentCode }</ns0:DEPT_CODE>
                <ns0:APPLICATION>{ $application }</ns0:APPLICATION>
            </ns0:MESSAGE_SOURCE>
            <ns0:ERROR_CODE>{ $errorCode }</ns0:ERROR_CODE>
        </ns0:notificaEstadoTransaccion>
};

declare variable $customerId as xs:string external;
declare variable $mobileNumber as xs:string external;
declare variable $message as xs:string external;
declare variable $messageType as xs:string external;
declare variable $service as xs:string external;
declare variable $company as xs:string external;
declare variable $departmentCode as xs:string external;
declare variable $application as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $serviceAccountNot as xs:string external;

xf:notificaEstadoTransaccionHN($customerId,
    $mobileNumber,
    $message,
    $messageType,
    $service,
    $company,
    $departmentCode,
    $application,
    $errorCode)