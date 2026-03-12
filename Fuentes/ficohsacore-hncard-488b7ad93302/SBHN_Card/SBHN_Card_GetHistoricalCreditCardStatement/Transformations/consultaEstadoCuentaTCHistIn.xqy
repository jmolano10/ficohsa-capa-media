xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://tempuri.org/";
(:: import schema at "../Resources/VMX.wsdl" ::)


declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)


declare function local:consultaEstadoCuentaTCHistoricoIn($consultaEstadoCuentaTCHistorico1 as element(ns0:getHistoricalCreditCardStatement))
    as element(ns1:ConsultaECHist) {
        <ns1:ConsultaECHist>
            <ns1:noTarjetaCredito>{ data($consultaEstadoCuentaTCHistorico1/DepositNumber) }</ns1:noTarjetaCredito>
            {
              if( data($consultaEstadoCuentaTCHistorico1/Year/text()) != "" ) then
              <ns1:noAnio>{ data($consultaEstadoCuentaTCHistorico1/Year) }</ns1:noAnio>
              else ()
            }
            {
              if( data($consultaEstadoCuentaTCHistorico1/Month/text()) != "" ) then
              <ns1:noMes>{ data($consultaEstadoCuentaTCHistorico1/Month) }</ns1:noMes>
              else ()
            }
        </ns1:ConsultaECHist>
};

declare variable $consultaEstadoCuentaTCHistorico1 as element(ns0:getHistoricalCreditCardStatement) external;

local:consultaEstadoCuentaTCHistoricoIn($consultaEstadoCuentaTCHistorico1)