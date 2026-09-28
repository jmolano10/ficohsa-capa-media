(:: pragma bea:global-element-parameter parameter="$consultaDetalleCompletoTransaccion" element="ns0:consultaDetalleCompletoTransaccion" location="consultaDetalleCompletoTransaccionTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleTransaccion" location="../ConsultaDetalleTransaccionAbanks/consultaDetalleTransaccionTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleTransaccionTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/ConsultaDetalleCompletoTransaccionAbanksIn/";

declare function xf:ConsultaDetalleCompletoTransaccionAbanksIn($consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion))
    as element(ns1:consultaDetalleTransaccion) {
        <ns1:consultaDetalleTransaccion>
            <TRANSACTION_REFERENCE>{ data($consultaDetalleCompletoTransaccion/TRANSACTION_REFERENCE) }</TRANSACTION_REFERENCE>
            {
                for $ACCOUNT_NUMBER in $consultaDetalleCompletoTransaccion/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
        </ns1:consultaDetalleTransaccion>
};

declare variable $consultaDetalleCompletoTransaccion as element(ns0:consultaDetalleCompletoTransaccion) external;

xf:ConsultaDetalleCompletoTransaccionAbanksIn($consultaDetalleCompletoTransaccion)