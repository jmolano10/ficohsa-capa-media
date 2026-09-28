(:: pragma bea:global-element-parameter parameter="$generaDetalleEmboce" element="ns0:generaDetalleEmboce" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleTarjetas" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraDetalleEmboce/xq/consultaDetalleTarjetasIn/";

declare function xf:consultaDetalleTarjetasIn($generaDetalleEmboce as element(ns0:generaDetalleEmboce))
    as element(ns0:consultaDetalleTarjetas) {
        <ns0:consultaDetalleTarjetas>
            <CARD_NUMBERS>
                {
                    for $CARD_ITEM in $generaDetalleEmboce/CARD_DETAILS/CARD_ITEM
                    return
                        <CARD_NUMBER_ITEM>
                            <CARD_NUMBER>{ data($CARD_ITEM/CARD_NUMBER) }</CARD_NUMBER>
                        </CARD_NUMBER_ITEM>
                }
            </CARD_NUMBERS>
        </ns0:consultaDetalleTarjetas>
};

declare variable $generaDetalleEmboce as element(ns0:generaDetalleEmboce) external;

xf:consultaDetalleTarjetasIn($generaDetalleEmboce)