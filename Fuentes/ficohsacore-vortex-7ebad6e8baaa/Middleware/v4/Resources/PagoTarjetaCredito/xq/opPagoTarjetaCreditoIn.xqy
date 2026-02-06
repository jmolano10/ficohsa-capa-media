xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito1" element="ns1:pagoTarjetaCredito" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:opPagoTarjetaCreditoSolicitud" location="../../../../v3/BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobiscanalesentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobistarjetacreditov3.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/opPagoTarjetaCreditoIn/";

declare function xf:opPagoTarjetaCreditoIn($pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito),
    $codCanalOriginador as xs:string,
    $usuarioPOS as xs:string,
    $numComercio as xs:string,
    $sourceBank as xs:string)
    as element(ns2:opPagoTarjetaCreditoSolicitud) {
        <ns2:opPagoTarjetaCreditoSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>{ $codCanalOriginador }</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:numTarjeta>{ data($pagoTarjetaCredito1/CREDIT_CARD_NUMBER) }</ns0:numTarjeta>
            <ns0:numCuenta>{ data($pagoTarjetaCredito1/DEBIT_ACCOUNT) }</ns0:numCuenta>
            <ns0:monedaPago>{ data($pagoTarjetaCredito1/BALANCE_CURRENCY) }</ns0:monedaPago>
            <ns0:valMonto>{ data($pagoTarjetaCredito1/PAYMENT_AMOUNT) }</ns0:valMonto>
            <ns0:usuarioPOS>{ $usuarioPOS }</ns0:usuarioPOS>
            <ns0:tipoMCC>0000</ns0:tipoMCC>
            <ns0:tipoIndicador>C</ns0:tipoIndicador>
            <ns0:longTrack2>0</ns0:longTrack2>
            <ns0:datosTrack2>{ fn:string('') }</ns0:datosTrack2>
            <ns0:codVerificacionTarjeta>000</ns0:codVerificacionTarjeta>
            <ns0:numComercio>{ $numComercio }</ns0:numComercio>
            <ns0:fechaVencimiento>0000</ns0:fechaVencimiento>
            <ns0:metodoPago>1</ns0:metodoPago>
            <ns0:region>
                <ns0:bancoOrigen>{ $sourceBank }</ns0:bancoOrigen>
            </ns0:region>
            <ns0:monedaTransaccion>{ data($pagoTarjetaCredito1/TRANSACTION_CURRENCY) }</ns0:monedaTransaccion>
        </ns2:opPagoTarjetaCreditoSolicitud>
};

declare variable $pagoTarjetaCredito1 as element(ns1:pagoTarjetaCredito) external;
declare variable $codCanalOriginador as xs:string external;
declare variable $usuarioPOS as xs:string external;
declare variable $numComercio as xs:string external;
declare variable $sourceBank as xs:string external;

xf:opPagoTarjetaCreditoIn($pagoTarjetaCredito1,
    $codCanalOriginador,
    $usuarioPOS,
    $numComercio,
    $sourceBank)