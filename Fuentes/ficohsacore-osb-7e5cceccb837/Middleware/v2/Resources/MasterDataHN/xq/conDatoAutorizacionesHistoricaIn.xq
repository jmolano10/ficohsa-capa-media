(:: pragma bea:global-element-parameter parameter="$consultaHistoricoAutorizacionesRequest1" element="ns0:consultaHistoricoAutorizacionesRequest" location="../../ConsultaHistoricoAutorizaciones/xsd/consultaHistoricoAutorizacionesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatoAutorizacionesHistorica/xsd/conDatoAutorizacionesHistorica_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoAutorizacionesHistorica";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaHistoricoAutorizacionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conDatoAutorizacionesHistoricaIn/";

declare function xf:conDatoAutorizacionesHistoricaIn($countryCode as xs:string,
    $consultaHistoricoAutorizacionesRequest1 as element(ns0:consultaHistoricoAutorizacionesRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $countryCode }</ns1:Pais>
            <ns1:Org>{ data($consultaHistoricoAutorizacionesRequest1/ORG) }</ns1:Org>  
            <ns1:NumCuenta>{ data($consultaHistoricoAutorizacionesRequest1/ACCOUNT_NUMBER) }</ns1:NumCuenta>
            <ns1:FechaInicial>{ data($consultaHistoricoAutorizacionesRequest1/INITIAL_PERIOD) }</ns1:FechaInicial>
            <ns1:FechaFinal>{ data($consultaHistoricoAutorizacionesRequest1/FINAL_PERIOD) }</ns1:FechaFinal>
        </ns1:InputParameters>
};

declare variable $countryCode as xs:string external;
declare variable $consultaHistoricoAutorizacionesRequest1 as element(ns0:consultaHistoricoAutorizacionesRequest) external;

xf:conDatoAutorizacionesHistoricaIn($countryCode,
    $consultaHistoricoAutorizacionesRequest1)