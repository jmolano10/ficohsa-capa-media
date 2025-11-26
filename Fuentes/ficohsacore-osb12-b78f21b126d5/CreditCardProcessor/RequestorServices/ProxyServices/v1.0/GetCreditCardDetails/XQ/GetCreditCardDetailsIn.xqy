xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCreditCardDetails_V2";
(:: import schema at "../../../../../ProviderServices/XSD/GetCreditCardDetails/GetCreditCardDetails_V2_sp.xsd" ::)

declare variable $sourceBank as xs:string external;
declare variable $cardNumber as xs:string external;

declare function local:func($sourceBank as xs:string, 
                            $cardNumber as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_NUMERO_TARJETA>{fn:data($cardNumber)}</ns1:PV_NUMERO_TARJETA>
        <ns1:PV_COUNTRY_CODE>{fn:data($sourceBank)}</ns1:PV_COUNTRY_CODE>
    </ns1:InputParameters>
};

local:func($sourceBank, $cardNumber)