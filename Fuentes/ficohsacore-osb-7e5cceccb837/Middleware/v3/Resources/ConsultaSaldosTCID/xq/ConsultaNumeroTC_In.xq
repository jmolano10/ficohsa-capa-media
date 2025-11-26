(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCredito1" element="ns1:consultaSaldosTarjetaCredito" location="../../ConsultaMaestraSaldosTarjetaCredito/xsd/consultaMaestraSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaNoTC/xsd/CONSULTANUMEROTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/CONSULTANUMEROTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMaestraSaldosTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaSaldosTCID/xq/ConsultaNumeroTC_In/";

declare function xf:ConsultaNumeroTC_In($consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:identidad>{ data($consultaSaldosTarjetaCredito1/CARD_HOLDER_ID) }</ns0:identidad>
            <ns0:tarjeta>{ data($consultaSaldosTarjetaCredito1/LAST_DIGITS_CARD) }</ns0:tarjeta>
        </ns0:InputParameters>
};

declare variable $consultaSaldosTarjetaCredito1 as element(ns1:consultaSaldosTarjetaCredito) external;

xf:ConsultaNumeroTC_In($consultaSaldosTarjetaCredito1)
