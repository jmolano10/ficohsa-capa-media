xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoLoteBilletera" element="ns0:consultaEstadoLoteBilletera" location="../../PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaEstadoLote" location="../../../BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd" ::)

declare namespace ns1 = "http://main/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosBilleteraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLoteBilletera/xq/consultaEstadoLoteBilleteraIn/";

declare function xf:consultaEstadoLoteBilleteraIn($consultaEstadoLoteBilletera as element(ns0:consultaEstadoLoteBilletera),
    $SECURITY_KEY as xs:string,
    $SECURITY_TOKEN as xs:string)
    as element(ns1:ConsultaEstadoLote) {
        <ns1:ConsultaEstadoLote>
            <LlaveTengo>{ $SECURITY_KEY }</LlaveTengo>
            <Token>{ $SECURITY_TOKEN }</Token>
            <Usuario>{ data($consultaEstadoLoteBilletera/USERNAME) }</Usuario>
            <debBilletera>{ data($consultaEstadoLoteBilletera/DEBIT_WALLET) }</debBilletera>
            <Correlativo>{ data($consultaEstadoLoteBilletera/BANK_BATCH_ID) }</Correlativo>
        </ns1:ConsultaEstadoLote>
};

declare variable $consultaEstadoLoteBilletera as element(ns0:consultaEstadoLoteBilletera) external;
declare variable $SECURITY_KEY as xs:string external;
declare variable $SECURITY_TOKEN as xs:string external;

xf:consultaEstadoLoteBilleteraIn($consultaEstadoLoteBilletera,
    $SECURITY_KEY,
    $SECURITY_TOKEN)