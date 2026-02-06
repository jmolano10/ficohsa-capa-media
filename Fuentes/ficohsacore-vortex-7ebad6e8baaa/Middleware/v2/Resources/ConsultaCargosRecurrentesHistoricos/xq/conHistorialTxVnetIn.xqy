xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCargosRecurrentesHistoricos1" element="ns1:consultaCargosRecurrentesHistoricos" location="../xsd/consultaCargosRecurrentesHistoricosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conHistorialTxVnet/xsd/conHistorialTxVnet_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHistorialTxVnet";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesHistoricosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/conHistorialTxVnetIn/";

declare function xf:conHistorialTxVnetIn($consultaCargosRecurrentesHistoricos1 as element(ns1:consultaCargosRecurrentesHistoricos), $sourceBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
        	<ns0:Pais>{ data($sourceBank)}</ns0:Pais>
            <ns0:FechaInicio>{string(data($consultaCargosRecurrentesHistoricos1/BEGIN_DATE)) }</ns0:FechaInicio>
            <ns0:FechaFin>{ string(data($consultaCargosRecurrentesHistoricos1/END_DATE)) }</ns0:FechaFin>
            <ns0:Valor>{fn-bea:pad-left(data($consultaCargosRecurrentesHistoricos1/SEARCH_VALUE), 19, '0') }</ns0:Valor>
            <ns0:CriterioBusqueda>{ 
                    if (data($consultaCargosRecurrentesHistoricos1/SEARCH_CRITERIA) = "CARD_NUMBER") then
                        (1)
                    else if (data($consultaCargosRecurrentesHistoricos1/SEARCH_CRITERIA) = "ACC_NUMBER") then
                        (0)
                        else ()                
                }</ns0:CriterioBusqueda>
            <ns0:RegistroInicial>{ data($consultaCargosRecurrentesHistoricos1/INITIAL_RECORD) }</ns0:RegistroInicial>
            <ns0:ConteoRegistros>{ data($consultaCargosRecurrentesHistoricos1/RECORD_COUNT) }</ns0:ConteoRegistros>
        </ns0:InputParameters>
        
};

declare variable $consultaCargosRecurrentesHistoricos1 as element(ns1:consultaCargosRecurrentesHistoricos) external;
declare variable $sourceBank as xs:string external;
xf:conHistorialTxVnetIn($consultaCargosRecurrentesHistoricos1, $sourceBank)