(:: pragma bea:global-element-parameter parameter="$consultaIntraExtraCuotaRequest" element="ns1:consultaIntraExtraCuotaRequest" location="../../ConsultaIntraExtraCuota/xsd/consultaIntraExtraCuotaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/conResumenFinanciamientos/xsd/conResumenFinanciamientos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conResumenFinanciamientos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaIntraExtraCuotaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conResumenFinanciamientosIn/";

declare function xf:conResumenFinanciamientosIn($consultaIntraExtraCuotaRequest as element(ns1:consultaIntraExtraCuota),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            <ns0:NumCuenta>{ data($consultaIntraExtraCuotaRequest/SEARCH_VALUE) }</ns0:NumCuenta>
            {
            	if($consultaIntraExtraCuotaRequest/SEARCH_CRITERIA = 'ACC_NUMBER')then(
            		
            		<ns0:Tipo>0</ns0:Tipo>
            		
            	)else if($consultaIntraExtraCuotaRequest/SEARCH_CRITERIA = 'CARD_NUMBER')then(
            		
            		<ns0:Tipo>1</ns0:Tipo>
            		
            	)else(
            	
            		<ns0:Tipo>{ data($consultaIntraExtraCuotaRequest/SEARCH_CRITERIA) }</ns0:Tipo>
            	)
            }
            </ns0:InputParameters>
};

declare variable $consultaIntraExtraCuotaRequest as element(ns1:consultaIntraExtraCuota) external;
declare variable $codigoPais as xs:string external;

xf:conResumenFinanciamientosIn($consultaIntraExtraCuotaRequest,
    $codigoPais)