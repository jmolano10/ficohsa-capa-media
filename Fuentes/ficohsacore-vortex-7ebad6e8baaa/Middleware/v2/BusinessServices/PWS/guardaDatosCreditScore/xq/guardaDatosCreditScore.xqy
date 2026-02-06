xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../xsd/guardaDatosCreditScore_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/guardaDatosCreditScore";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/PWS/guardaDatosCreditScore/xq/guardaDatosCreditScore/";

declare function xf:guardaDatosCreditScore($uuid as xs:string,
    $customerLegalId as xs:string,
    $customerId as xs:string,
    $gender as xs:string,
    $dateOfBirth as xs:string,
    $targetDescription as xs:string,
    $cellphoneNumber as xs:string,
    $productType as xs:string,
    $productNumber as xs:string,
    $creditScore as xs:string,
    $status as xs:string,
    $statusReason as xs:string,
    $paymentAmount as xs:string,
    $paymentCurrency as xs:string,
    $hostSource as xs:string,
    $geoipCity as xs:string,
    $geoipRegion as xs:string,
    $geoipCountry as xs:string,
    $geoipLatitude as xs:string,
    $geoipLongitude as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_UUID>{ $uuid }</ns0:P_UUID>
            <ns0:P_CUSTOMER_LEGAL_ID>{ $customerLegalId }</ns0:P_CUSTOMER_LEGAL_ID>
            <ns0:P_CUSTOMER_ID>{ $customerId }</ns0:P_CUSTOMER_ID>
            <ns0:P_GENDER>{ $gender }</ns0:P_GENDER>
            <ns0:P_DATE_OF_BIRTH>{ $dateOfBirth }</ns0:P_DATE_OF_BIRTH>
            <ns0:P_TARGET_DESCRIPTION>{ $targetDescription }</ns0:P_TARGET_DESCRIPTION>
            <ns0:P_CELLPHONE_NUMBER>{ $cellphoneNumber }</ns0:P_CELLPHONE_NUMBER>
            <ns0:P_PAYMENT_TYPE_SOURCE>{ $productType }</ns0:P_PAYMENT_TYPE_SOURCE>
            <ns0:P_PAYMENT_SOURCE>{ $productNumber }</ns0:P_PAYMENT_SOURCE>
            <ns0:P_CREDIT_SCORE>{ $creditScore }</ns0:P_CREDIT_SCORE>
            <ns0:P_QUERY_STATUS>{ $status }</ns0:P_QUERY_STATUS>
            <ns0:P_QUERY_STATUS_REASON>{ $statusReason }</ns0:P_QUERY_STATUS_REASON>
            <ns0:P_QUERY_PAYMENT_AMOUNT>{ $paymentAmount }</ns0:P_QUERY_PAYMENT_AMOUNT>
            <ns0:P_QUERY_PAYMENT_CURRENCY>{ $paymentCurrency }</ns0:P_QUERY_PAYMENT_CURRENCY>
            <ns0:P_IPV4_ADDRESS_SOURCE>{ $hostSource }</ns0:P_IPV4_ADDRESS_SOURCE>
            <ns0:P_GEOIP_CITY>{ $geoipCity }</ns0:P_GEOIP_CITY>
            <ns0:P_GEOIP_REGION>{ $geoipRegion }</ns0:P_GEOIP_REGION>
            <ns0:P_GEOIP_COUNTRY>{ $geoipCountry }</ns0:P_GEOIP_COUNTRY>
            <ns0:P_GEOIP_APROX_LATITUDE>{ $geoipLatitude }</ns0:P_GEOIP_APROX_LATITUDE>
            <ns0:P_GEOIP_APROX_LONGITUDE>{ $geoipLongitude }</ns0:P_GEOIP_APROX_LONGITUDE>
        </ns0:InputParameters>
};

declare variable $uuid as xs:string external;
declare variable $customerLegalId as xs:string external;
declare variable $customerId as xs:string external;
declare variable $gender as xs:string external;
declare variable $dateOfBirth as xs:string external;
declare variable $targetDescription as xs:string external;
declare variable $cellphoneNumber as xs:string external;
declare variable $productType as xs:string external;
declare variable $productNumber as xs:string external;
declare variable $creditScore as xs:string external;
declare variable $status as xs:string external;
declare variable $statusReason as xs:string external;
declare variable $paymentAmount as xs:string external;
declare variable $paymentCurrency as xs:string external;
declare variable $hostSource as xs:string external;
declare variable $geoipCity as xs:string external;
declare variable $geoipRegion as xs:string external;
declare variable $geoipCountry as xs:string external;
declare variable $geoipLatitude as xs:string external;
declare variable $geoipLongitude as xs:string external;

xf:guardaDatosCreditScore($uuid,
    $customerLegalId,
    $customerId,
    $gender,
    $dateOfBirth,
    $targetDescription,
    $cellphoneNumber,
    $productType,
    $productNumber,
    $creditScore,
    $status,
    $statusReason,
    $paymentAmount,
    $paymentCurrency,
    $hostSource,
    $geoipCity,
    $geoipRegion,
    $geoipCountry,
    $geoipLatitude,
    $geoipLongitude)