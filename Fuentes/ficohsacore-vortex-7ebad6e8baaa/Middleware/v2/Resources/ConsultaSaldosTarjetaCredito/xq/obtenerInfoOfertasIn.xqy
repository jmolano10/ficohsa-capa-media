xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataPA/obtenerInfoOfertas/xsd/obtenerInfoOfertas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerInfoOfertas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/obtenerInfoOfertasIn/";

declare function xf:obtenerInfoOfertasIn($country as xs:string,
    $org as xs:string,
    $cardNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $country }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumTarjeta>{ $cardNumber }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $country as xs:string external;
declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;

xf:obtenerInfoOfertasIn($country,
    $org,
    $cardNumber)