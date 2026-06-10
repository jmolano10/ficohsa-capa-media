<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/notificaCambioInformacionTarjeta/xsd/notificaCambioInformacionTarjeta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:notificaCambioInformacionTarjetaResponse" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaCambioInformacionTarjeta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaCambioInformacionTarjeta/xq/notificaCambioInformacionTarjetaOut/";

declare function xf:notificaCambioInformacionTarjetaOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:notificaCambioInformacionTarjetaResponse) {
        <ns1:notificaCambioInformacionTarjetaResponse>
            {
                for $PV_REQUESTIDOUT in $outputParameters/ns0:PV_REQUESTIDOUT
                return
                    <REQUEST_ID>{ data($PV_REQUESTIDOUT) }</REQUEST_ID>
            }
            {
                for $PV_RETURNCODE in $outputParameters/ns0:PV_RETURNCODE
                return
                    <RETURN_CODE>{ data($PV_RETURNCODE) }</RETURN_CODE>
            }
            {
                for $PV_ERRORDESCRIPTION in $outputParameters/ns0:PV_ERRORDESCRIPTION
                return
                    <ERROR_DESCRIPTION>{ data($PV_ERRORDESCRIPTION) }</ERROR_DESCRIPTION>
            }
        </ns1:notificaCambioInformacionTarjetaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:notificaCambioInformacionTarjetaOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/notificaCambioInformacionTarjeta/xsd/notificaCambioInformacionTarjeta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/notificaCambioInformacionTarjeta/xsd/notificaCambioInformacionTarjeta_sp"/>
    </con:dependency>
    <con:dependency location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes"/>
    </con:dependency>
</con:xqueryEntry>