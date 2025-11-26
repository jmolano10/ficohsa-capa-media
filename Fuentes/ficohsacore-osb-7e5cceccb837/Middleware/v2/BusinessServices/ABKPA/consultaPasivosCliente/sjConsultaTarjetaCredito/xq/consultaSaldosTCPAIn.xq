xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultarTarjetasCreditoResponse1" element="ns1:ConsultarTarjetasCreditoResponse" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCredito" location="../../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaSaldosTarjetaCreditoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";

declare function xf:consultaSaldosTarjetaCreditoIn($consultarTarjetasCreditoResponse1 as element(ns1:ConsultarTarjetasCreditoResponse),
    $counter as xs:integer)
    as element(ns0:consultaSaldosTarjetaCredito) {
        <ns0:consultaSaldosTarjetaCredito>
            <CARD_NUMBER>{ data($consultarTarjetasCreditoResponse1/ns1:ConsultarTarjetasCreditoResult/ns1:Tarjetas/ns1:StrucTarjetasConsulta[$counter]/ns1:noTarjetaCredito) }</CARD_NUMBER>
        </ns0:consultaSaldosTarjetaCredito>
};

declare variable $consultarTarjetasCreditoResponse1 as element(ns1:ConsultarTarjetasCreditoResponse) external;
declare variable $counter as xs:integer external;

xf:consultaSaldosTarjetaCreditoIn($consultarTarjetasCreditoResponse1,
$counter)