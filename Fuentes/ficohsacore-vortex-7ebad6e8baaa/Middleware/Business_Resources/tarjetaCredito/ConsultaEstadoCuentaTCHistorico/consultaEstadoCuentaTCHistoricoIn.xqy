xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTCHistorico1" element="ns0:consultaEstadoCuentaTCHistorico" location="consultaEstadoCuentaTCHistoricoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaECHist" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://tempuri.org/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoTarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoIn/";

declare function xf:consultaEstadoCuentaTCHistoricoIn($consultaEstadoCuentaTCHistorico1 as element(ns0:consultaEstadoCuentaTCHistorico))
    as element(ns1:ConsultaECHist) {
        <ns1:ConsultaECHist>
            <ns1:noTarjetaCredito>{ data($consultaEstadoCuentaTCHistorico1/CARD_NUMBER) }</ns1:noTarjetaCredito>
            <ns1:noAnio>{ data($consultaEstadoCuentaTCHistorico1/YEAR) }</ns1:noAnio>
            <ns1:noMes>{ data($consultaEstadoCuentaTCHistorico1/MONTH) }</ns1:noMes>
        </ns1:ConsultaECHist>
};

declare variable $consultaEstadoCuentaTCHistorico1 as element(ns0:consultaEstadoCuentaTCHistorico) external;

xf:consultaEstadoCuentaTCHistoricoIn($consultaEstadoCuentaTCHistorico1)