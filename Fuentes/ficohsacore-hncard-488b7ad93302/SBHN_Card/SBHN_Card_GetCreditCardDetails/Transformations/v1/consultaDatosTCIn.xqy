xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC_V2";
(:: import schema at "../../Schemas/v1/consultaDatosTC_V2_sp.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)


declare function local:consultaDatosTCIn($consultaDatosTarjetaCredito as element(ns0:getCreditCardDetails))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_NUMERO_TARJETA>{ data($consultaDatosTarjetaCredito/CardNumber) }</ns1:PV_NUMERO_TARJETA>
            <ns1:PV_COUNTRY_CODE>{ data($consultaDatosTarjetaCredito/GeneralInfo/DestinationBank) }</ns1:PV_COUNTRY_CODE>
        </ns1:InputParameters>
};

declare variable $consultaDatosTarjetaCredito as element(ns0:getCreditCardDetails) external;

local:consultaDatosTCIn($consultaDatosTarjetaCredito)