xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../../../SBHN_Card_Commons/Schemas/CardInquiryTypesv2.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC";
(:: import schema at "../../Schemas/v2/consultaDatosTC_sp.xsd" ::)


declare function local:consultaDatosTCIn($user as xs:string,$cardNumber as xs:string,
    $requestHeader as element(ns1:getCreditCardDetails))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ $cardNumber }</ns0:PV_NUMERO_TARJETA>
            <ns0:PV_COUNTRY_CODE>{ data($requestHeader/GeneralInfo/SourceBank) }</ns0:PV_COUNTRY_CODE>
            <ns0:PV_USER_NAME>{ $user }</ns0:PV_USER_NAME>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $user as xs:string external;
declare variable $requestHeader as element(ns1:getCreditCardDetails) external;

local:consultaDatosTCIn($user,$cardNumber,
    $requestHeader)