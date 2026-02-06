xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaHistoricoAutorizacionesRequest" element="ns1:consultaHistoricoAutorizacionesRequest" location="../../ConsultaHistoricoAutorizaciones/xsd/consultaHistoricoAutorizacionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conDatoAutorizacionesHistorica/xsd/conDatoAutorizacionesHistorica_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoAutorizacionesHistorica";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaHistoricoAutorizacionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conDatoAutorizacionesHistoricaIn/";

declare function xf:conDatoAutorizacionesHistoricaIn($countryCode as xs:string,
    $consultaHistoricoAutorizacionesRequest as element(ns1:consultaHistoricoAutorizacionesRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $countryCode }</ns0:Pais>
            {
                for $ORG in $consultaHistoricoAutorizacionesRequest/ORG
                return
	                if(data($ORG) != '') then(
	                    <ns0:Org>{ data($ORG) }</ns0:Org>
	                 )else()
            }
            <ns0:NumCuenta>{ data($consultaHistoricoAutorizacionesRequest/ACCOUNT_NUMBER) }</ns0:NumCuenta>
            <ns0:FechaInicial>{ data($consultaHistoricoAutorizacionesRequest/INITIAL_PERIOD) }</ns0:FechaInicial>
            <ns0:FechaFinal>{ data($consultaHistoricoAutorizacionesRequest/FINAL_PERIOD) }</ns0:FechaFinal>
        </ns0:InputParameters>
};

declare variable $countryCode as xs:string external;
declare variable $consultaHistoricoAutorizacionesRequest as element(ns1:consultaHistoricoAutorizacionesRequest) external;

xf:conDatoAutorizacionesHistoricaIn($countryCode,
    $consultaHistoricoAutorizacionesRequest)