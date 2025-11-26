(:: pragma bea:global-element-parameter parameter="$pagoTarjetaCredito" element="ns1:pagoTarjetaCredito" location="../../xsds/PagoTarjetaCredito/PagoTarjetaCredito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/ConDatoTarjetas_v2/conDatoTarjetas_v2_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCredito";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoTarjetaCredito/conDatoTarjetas_v2In/";

declare function xf:conDatoTarjetas_v2In($pagoTarjetaCredito as element(ns1:pagoTarjetaCredito),
    $countryCode as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $countryCode }</ns0:Pais>
            <ns0:NumTarjeta>{ data($pagoTarjetaCredito/CREDIT_CARD_NUMBER) }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $pagoTarjetaCredito as element(ns1:pagoTarjetaCredito) external;
declare variable $countryCode as xs:string external;

xf:conDatoTarjetas_v2In($pagoTarjetaCredito,
    $countryCode)
