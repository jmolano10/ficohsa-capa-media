(:: pragma bea:global-element-parameter parameter="$consultarpagosResponse" element="ns0:ConsultarpagosResponse" location="../Resources/TarjetaDeCredito.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:consultaPagoTarjetaCreditoResponse" location="consultaPagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPagoTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaPagoTarjetaCredito/consultaPagoTarjetaCreditoOut/";

declare function xf:consultaPagoTarjetaCreditoOut($consultarpagosResponse as element(ns0:ConsultarpagosResponse))
    as element(ns1:consultaPagoTarjetaCreditoResponse) {
        <ns1:consultaPagoTarjetaCreditoResponse>
            {
                for $EstatusConfirmacion in $consultarpagosResponse/ns0:ConsultarpagosResult/ns0:EstatusConfirmacion
                return
                    <CONFIRMATION_STATUS>{ data($EstatusConfirmacion) }</CONFIRMATION_STATUS>
            }
            {
                for $MensajeConfirmacion in $consultarpagosResponse/ns0:ConsultarpagosResult/ns0:MensajeConfirmacion
                return
                    <CONFIRMATION_MESSAGE>{ data($MensajeConfirmacion) }</CONFIRMATION_MESSAGE>
            }
        </ns1:consultaPagoTarjetaCreditoResponse>
};

declare variable $consultarpagosResponse as element(ns0:ConsultarpagosResponse) external;

xf:consultaPagoTarjetaCreditoOut($consultarpagosResponse)