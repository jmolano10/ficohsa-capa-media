xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InformacionTarjetaActual" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuntajeCredito/xq/consultaInformacionTarjeta/";

declare function xf:consultaInformacionTarjeta($cardNumber as xs:string)
    as element(ns0:InformacionTarjetaActual) {
        <ns0:InformacionTarjetaActual>
            <ns0:noTarjetaCredito>{ $cardNumber }</ns0:noTarjetaCredito>
        </ns0:InformacionTarjetaActual>
};

declare variable $cardNumber as xs:string external;

xf:consultaInformacionTarjeta($cardNumber)