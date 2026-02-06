xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTarjetas" element="ns0:consultaDetalleTarjetas" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetalleTarjetas/xsd/consultaDetalleTarjetas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleTarjetas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTarjetas/xq/consultaDetalleTarjetaPAIn/";

declare function xf:consultaDetalleTarjetaPAIn($consultaDetalleTarjetas as element(ns0:consultaDetalleTarjetas))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                <ns1:PV_CARD_NUMBER>
                    {
                        for $CARD_NUMBER_ITEM in $consultaDetalleTarjetas/CARD_NUMBERS/CARD_NUMBER_ITEM
                        return
                            <ns1:PV_CARD_NUMBER_ITEM>{ data($CARD_NUMBER_ITEM/CARD_NUMBER) }</ns1:PV_CARD_NUMBER_ITEM>
                    }
                </ns1:PV_CARD_NUMBER>
            }
        </ns1:InputParameters>
};

declare variable $consultaDetalleTarjetas as element(ns0:consultaDetalleTarjetas) external;

xf:consultaDetalleTarjetaPAIn($consultaDetalleTarjetas)