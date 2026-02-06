xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../v3/BusinessServices/ABKPA/ConsultarTarjetaDebito/xsd/consultarTarjetaDebitoPA_db.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarTarjetaDebitoPA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaDebito/xq/ConsultaDatosTarjetaDebito/";

declare function xf:ConsultaDatosTarjetaDebito($numeroTarjeta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_NUMERO_TARJETA>{ $numeroTarjeta }</ns0:PV_NUMERO_TARJETA>
        </ns0:InputParameters>
};

declare variable $numeroTarjeta as xs:string external;

xf:ConsultaDatosTarjetaDebito($numeroTarjeta)