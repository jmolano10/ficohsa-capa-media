(:: pragma bea:global-element-parameter parameter="$reversarPagoResponse" element="ns1:reversarPagoResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:reversionPagoTarjetaCreditoResponse" location="reversionPagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reversionPagoTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ReversionPagoTarjetaCredito/reversionPagoTarjetaCreditoOut/";

declare function xf:reversionPagoTarjetaCreditoOut($reversarPagoResponse as element(ns1:reversarPagoResponse))
    as element(ns0:reversionPagoTarjetaCreditoResponse) {
        <ns0:reversionPagoTarjetaCreditoResponse>
            {
                for $estatusConfirmacion in $reversarPagoResponse/ns1:reversarPagoResult/ns1:estatusConfirmacion
                return
                    <CONFIRMATION_STATUS>{ data($estatusConfirmacion) }</CONFIRMATION_STATUS>
            }
            {
                for $mensajeConfirmacion in $reversarPagoResponse/ns1:reversarPagoResult/ns1:mensajeConfirmacion
                return
                    <CONFIRMATION_MESSAGE>{ data($mensajeConfirmacion) }</CONFIRMATION_MESSAGE>
            }
        </ns0:reversionPagoTarjetaCreditoResponse>
};

declare variable $reversarPagoResponse as element(ns1:reversarPagoResponse) external;

xf:reversionPagoTarjetaCreditoOut($reversarPagoResponse)