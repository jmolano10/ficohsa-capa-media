<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleTarjetas" element="ns0:consultaDetalleTarjetas" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetalleTarjetas/xsd/consultaDetalleTarjetas_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleTarjetas/xq/consultaDetalleTarjetaGTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleTarjetas";

declare function xf:consultaDetalleTarjetaGTIn($consultaDetalleTarjetas as element(ns0:consultaDetalleTarjetas))
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

xf:consultaDetalleTarjetaGTIn($consultaDetalleTarjetas)]]></con:xquery>
    <con:dependency location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaDetalleTarjetas/xsd/consultaDetalleTarjetas_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaDetalleTarjetas/xsd/consultaDetalleTarjetas_sp"/>
    </con:dependency>
</con:xqueryEntry>