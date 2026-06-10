<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarTarjetasCreditoResponse1" element="ns1:ConsultarTarjetasCreditoResponse" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaSaldosTarjetaCreditoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";

declare function xf:consultaSaldosTarjetaCreditoIn($consultarTarjetasCreditoResponse1 as element(ns1:ConsultarTarjetasCreditoResponse),
    $counter as xs:integer)
    as element(ns0:consultaSaldosTarjetaCredito) {
        &lt;ns0:consultaSaldosTarjetaCredito>
            &lt;CARD_NUMBER>{ data($consultarTarjetasCreditoResponse1/ns1:ConsultarTarjetasCreditoResult/ns1:Tarjetas/ns1:StrucTarjetasConsulta[$counter]/ns1:noTarjetaCredito) }&lt;/CARD_NUMBER>
        &lt;/ns0:consultaSaldosTarjetaCredito>
};

declare variable $consultarTarjetasCreditoResponse1 as element(ns1:ConsultarTarjetasCreditoResponse) external;
declare variable $counter as xs:integer external;

xf:consultaSaldosTarjetaCreditoIn($consultarTarjetasCreditoResponse1,
$counter)</con:xquery>
    <con:dependency location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
    <con:dependency location="../../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes"/>
    </con:dependency>
</con:xqueryEntry>