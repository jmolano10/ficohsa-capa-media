xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InformacionTarjetaActual" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatosTarjetaCredito/xq/consultaDatosTarjetaCreditoPAInV2/";

declare function xf:consultaDatosTarjetaCreditoPAInV2($noTarjeta as xs:string)
    as element(ns0:InformacionTarjetaActual) {
        <ns0:InformacionTarjetaActual>
            <ns0:noTarjetaCredito>{ fn:string($noTarjeta) }</ns0:noTarjetaCredito>
        </ns0:InformacionTarjetaActual>
};

declare variable $noTarjeta as xs:string external;

xf:consultaDatosTarjetaCreditoPAInV2($noTarjeta)