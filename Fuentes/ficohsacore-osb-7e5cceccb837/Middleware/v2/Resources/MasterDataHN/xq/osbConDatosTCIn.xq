(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/MasterData/conConsultaDatosTCRG/xsd/conConsultaDatosTarjetaCredito_v3_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaDatosTarjetaCredito_v3";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/osbConDatosTCIn/";

declare function xf:osbConDatosTCIn($cardNumber as xs:string,
    $org as xs:string,
    $country as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $country }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumTarjeta>{ $cardNumber }</ns0:NumTarjeta>
            <ns0:CodigoError>0</ns0:CodigoError>
            <ns0:MensajeError>temp</ns0:MensajeError>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $country as xs:string external;

xf:osbConDatosTCIn($cardNumber,
    $org,
    $country)
