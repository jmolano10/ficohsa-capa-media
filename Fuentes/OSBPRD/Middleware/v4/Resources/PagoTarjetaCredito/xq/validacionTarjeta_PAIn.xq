(:: pragma bea:global-element-return element="ns0:ConsultarEstadosCuentaUltimoCorte" location="../../../../v2/BusinessServices/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/validacionTarjeta_PAIn/";

declare function xf:validacionTarjeta_PAIn($CreditCardNumber as xs:string)
    as element(ns0:ConsultarEstadosCuentaUltimoCorte) {
        <ns0:ConsultarEstadosCuentaUltimoCorte>
            <ns0:noTarjetaCredito>{ $CreditCardNumber }</ns0:noTarjetaCredito>
        </ns0:ConsultarEstadosCuentaUltimoCorte>
};

declare variable $CreditCardNumber as xs:string external;

xf:validacionTarjeta_PAIn($CreditCardNumber)