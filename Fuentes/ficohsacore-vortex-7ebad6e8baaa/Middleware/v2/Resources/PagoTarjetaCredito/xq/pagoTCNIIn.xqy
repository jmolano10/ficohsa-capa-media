xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns2:pagoTarjetaCredito" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opPagoTarjetaCreditoSolicitud" location="../../../BusinessServices/CTS/pagoTarjetaCredito/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobiscanalesentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";
declare namespace ns1 = "http://service.srvaplcobistarjetacreditov2.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/pagoTCNIIn/";

declare function xf:pagoTCNIIn($pagoTarjetaCredito as element(ns2:pagoTarjetaCredito),
    $canalOriginador as xs:string,
    $usuarioPOS as xs:string,
    $numComercio as xs:string,
    $bancoOrigen as xs:string,
    $tipoMCC as xs:string,
    $tipoIndicador as xs:string,
    $longTrack2 as xs:string,
    $codVerificadorTC as xs:string,
    $metodoPago as xs:string)
    as element(ns1:opPagoTarjetaCreditoSolicitud) {
        <ns1:opPagoTarjetaCreditoSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>{ data($canalOriginador) }</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:numTarjeta>{ xs:long(data($pagoTarjetaCredito/CREDIT_CARD_NUMBER)) }</ns0:numTarjeta>
            <ns0:numCuenta>{ data($pagoTarjetaCredito/DEBIT_ACCOUNT) }</ns0:numCuenta>
            <ns0:monedaPago>{ data($pagoTarjetaCredito/BALANCE_CURRENCY) }</ns0:monedaPago>
            <ns0:valMonto>{ data($pagoTarjetaCredito/PAYMENT_AMOUNT) }</ns0:valMonto>
            <ns0:usuarioPOS>{ $usuarioPOS }</ns0:usuarioPOS>
            <ns0:tipoIndicadorPago>{ fn:string('') }</ns0:tipoIndicadorPago>
            <ns0:tipoMCC>{ $tipoMCC }</ns0:tipoMCC>
            <ns0:tipoIndicador>{ $tipoIndicador }</ns0:tipoIndicador>
            <ns0:longTrack2>{ $longTrack2 }</ns0:longTrack2>
            <ns0:datosTrack2>{ fn:string('') }</ns0:datosTrack2>
            <ns0:codVerificacionTarjeta>{ $codVerificadorTC }</ns0:codVerificacionTarjeta>
            <ns0:numComercio>{ $numComercio }</ns0:numComercio>
            <ns0:fechaVencimiento>0000</ns0:fechaVencimiento>
            <ns0:metodoPago>{ $metodoPago }</ns0:metodoPago>
            <ns0:region>
                <ns0:bancoOrigen>{ $bancoOrigen }</ns0:bancoOrigen>
            </ns0:region>
            <ns0:monedaTransaccion>{fn:string('')}</ns0:monedaTransaccion>
        </ns1:opPagoTarjetaCreditoSolicitud>
};

declare variable $pagoTarjetaCredito as element(ns2:pagoTarjetaCredito) external;
declare variable $canalOriginador as xs:string external;
declare variable $usuarioPOS as xs:string external;
declare variable $numComercio as xs:string external;
declare variable $bancoOrigen as xs:string external;
declare variable $tipoMCC as xs:string external;
declare variable $tipoIndicador as xs:string external;
declare variable $longTrack2 as xs:string external;
declare variable $codVerificadorTC as xs:string external;
declare variable $metodoPago as xs:string external;

xf:pagoTCNIIn($pagoTarjetaCredito,
    $canalOriginador,
    $usuarioPOS,
    $numComercio,
    $bancoOrigen,
    $tipoMCC,
    $tipoIndicador,
    $longTrack2,
    $codVerificadorTC,
    $metodoPago)