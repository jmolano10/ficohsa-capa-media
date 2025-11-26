(:: pragma bea:global-element-return element="ns0:InformacionTarjetaActual" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransaccionesAlcance/xq/ConsultaTarjetaCreditoIn/";

declare function xf:ConsultaTarjetaCreditoIn($Number_Card as xs:string)
    as element(ns0:InformacionTarjetaActual) {
        <ns0:InformacionTarjetaActual>
            <ns0:noTarjetaCredito>{ $Number_Card }</ns0:noTarjetaCredito>
        </ns0:InformacionTarjetaActual>
};

declare variable $Number_Card as xs:string external;

xf:ConsultaTarjetaCreditoIn($Number_Card)
