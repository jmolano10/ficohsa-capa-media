(:: pragma bea:global-element-return element="ns0:InformacionTarjetaActual" location="../../../BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VentaInventario/xq/consultaInfoTCIn/";

declare function xf:consultaInfoTCIn($creditCardNumber as xs:string)
    as element(ns0:InformacionTarjetaActual) {
        <ns0:InformacionTarjetaActual>
            <ns0:noTarjetaCredito>{ $creditCardNumber }</ns0:noTarjetaCredito>
        </ns0:InformacionTarjetaActual>
};

declare variable $creditCardNumber as xs:string external;

xf:consultaInfoTCIn($creditCardNumber)