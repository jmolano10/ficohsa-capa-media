(:: pragma bea:global-element-parameter parameter="$consultaPagoTarjetaCredito" element="ns1:consultaPagoTarjetaCredito" location="consultaPagoTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultarpagos" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPagoTarjetaCreditoTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaPagoTarjetaCredito/consultaPagoTarjetaCreditoIn/";

declare function xf:consultaPagoTarjetaCreditoIn($consultaPagoTarjetaCredito as element(ns1:consultaPagoTarjetaCredito))
    as element(ns0:Consultarpagos) {
        <ns0:Consultarpagos>
            <ns0:idReferenciaEnPagoT24>{ data($consultaPagoTarjetaCredito/PAYMENT_REFERENCE) }</ns0:idReferenciaEnPagoT24>
            <ns0:NumeroDeTarjetaDeCredito>{ data($consultaPagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns0:NumeroDeTarjetaDeCredito>
            <ns0:Fecha>{ data($consultaPagoTarjetaCredito/DATE) }</ns0:Fecha>
            <ns0:Monto>{ data($consultaPagoTarjetaCredito/AMOUNT) }</ns0:Monto>
        </ns0:Consultarpagos>
};

declare variable $consultaPagoTarjetaCredito as element(ns1:consultaPagoTarjetaCredito) external;

xf:consultaPagoTarjetaCreditoIn($consultaPagoTarjetaCredito)