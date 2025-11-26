(:: pragma bea:global-element-parameter parameter="$consultaCargosRecurrentesHistoricos" element="ns1:consultaCargosRecurrentesHistoricos" location="../xsd/consultaCargosRecurrentesHistoricosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/conHistorialTxVnet/xsd/conHistorialTxVnetHN_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conHistorialTxVnetHN";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesHistoricosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/conHistorialTxVnetHNIn/";

declare function xf:conHistorialTxVnetHNIn($consultaCargosRecurrentesHistoricos as element(ns1:consultaCargosRecurrentesHistoricos),
    $sourceBank as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $sourceBank }</ns0:Pais>
            <ns0:FechaInicio>{ data($consultaCargosRecurrentesHistoricos/BEGIN_DATE) }</ns0:FechaInicio>
            <ns0:FechaFin>{ data($consultaCargosRecurrentesHistoricos/END_DATE) }</ns0:FechaFin>
            <ns0:Valor>{ fn-bea:pad-left(data($consultaCargosRecurrentesHistoricos/SEARCH_VALUE), 19, '0') }</ns0:Valor>
            <ns0:CriterioBusqueda>{
            	if (data($consultaCargosRecurrentesHistoricos/SEARCH_CRITERIA) = "CARD_NUMBER") then (1)
            	
            	else if (data($consultaCargosRecurrentesHistoricos/SEARCH_CRITERIA) = "ACC_NUMBER") then (0)
            	
            	else () 
            }</ns0:CriterioBusqueda>
            <ns0:RegistroInicial>{ data($consultaCargosRecurrentesHistoricos/INITIAL_RECORD) }</ns0:RegistroInicial>
            <ns0:ConteoRegistros>{ data($consultaCargosRecurrentesHistoricos/RECORD_COUNT) }</ns0:ConteoRegistros>
        </ns0:InputParameters>
};

declare variable $consultaCargosRecurrentesHistoricos as element(ns1:consultaCargosRecurrentesHistoricos) external;
declare variable $sourceBank as xs:string external;

xf:conHistorialTxVnetHNIn($consultaCargosRecurrentesHistoricos,
    $sourceBank)
