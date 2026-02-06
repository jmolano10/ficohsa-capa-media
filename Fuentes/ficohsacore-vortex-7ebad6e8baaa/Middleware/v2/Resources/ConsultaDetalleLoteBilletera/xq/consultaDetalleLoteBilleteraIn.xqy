xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLoteBilletera" element="ns0:consultaDetalleLoteBilletera" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:HistoricoPagoId" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDetalleLoteBilletera/xq/consultaDetalleLoteBilleteraIn/";

declare function xf:consultaDetalleLoteBilleteraIn($consultaDetalleLoteBilletera as element(ns0:consultaDetalleLoteBilletera),
    $SECURITY_TOKEN as xs:string,
    $SECURITY_KEY as xs:string)
    as element(ns1:HistoricoPagoId) {
        <ns1:HistoricoPagoId>
            <LlaveTengo>{ $SECURITY_KEY }</LlaveTengo>
            <Usuario>{ data($consultaDetalleLoteBilletera/USERNAME) }</Usuario>
            <Correlativo>{ data($consultaDetalleLoteBilletera/BANK_BATCH_ID) }</Correlativo>
            <Token>{ $SECURITY_TOKEN }</Token>
        </ns1:HistoricoPagoId>
};

declare variable $consultaDetalleLoteBilletera as element(ns0:consultaDetalleLoteBilletera) external;
declare variable $SECURITY_TOKEN as xs:string external;
declare variable $SECURITY_KEY as xs:string external;

xf:consultaDetalleLoteBilleteraIn($consultaDetalleLoteBilletera,
    $SECURITY_TOKEN,
    $SECURITY_KEY)