xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ActualizaDatosGFF/ActualizarSistemas/xsd/actualizarSistemas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarSistemas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDatosActualizados/xq/actualizarSistemasIn/";

declare function xf:actualizarSistemasIn($uuid as xs:string,
    $customerId as xs:string,
    $targetSystem as xs:string,
    $countryId as xs:string,
    $operationType as xs:string,
    $creationDate as xs:string,
    $updateTime as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_UUID>{ data($uuid) }</ns0:P_UUID>
            <ns0:P_CUSTOMER_ID>{ data($customerId) }</ns0:P_CUSTOMER_ID>
            <ns0:P_TARGET_SYSTEM>{ data($targetSystem) }</ns0:P_TARGET_SYSTEM>
            <ns0:P_COUNTRY_ID>{ data($countryId) }</ns0:P_COUNTRY_ID>
            {
            let $date :=  fn-bea:date-to-string-with-format("yyyy-MM-dd", fn-bea:date-from-string-with-format('ddMMyyyy', $creationDate))
            let $time :=  fn-bea:time-to-string-with-format('HH:mm:ss',fn-bea:time-from-string-with-format("HH:mm:ss",$updateTime))
            return
                <ns0:P_OPERATION_DATE>{ fn-bea:dateTime-to-string-with-format("yyyy-MM-ddHH:mm:ss",fn-bea:dateTime-from-string-with-format("yyyy-MM-ddHH:mm:ss", string(concat($date,$time)))) }</ns0:P_OPERATION_DATE>
            }
            <ns0:P_OPERATION_TYPE>{ xs:decimal(data($operationType)) }</ns0:P_OPERATION_TYPE>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $customerId as xs:string external;
declare variable $targetSystem as xs:string external;
declare variable $countryId as xs:string external;
declare variable $operationType as xs:string external;
declare variable $creationDate as xs:string external;
declare variable $updateTime as xs:string external;

xf:actualizarSistemasIn($uuid,
    $customerId,
    $targetSystem,
    $countryId,
    $operationType,
    $creationDate,
    $updateTime)