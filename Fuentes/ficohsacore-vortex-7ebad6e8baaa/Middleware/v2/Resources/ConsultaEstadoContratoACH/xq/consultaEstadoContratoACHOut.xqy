xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaContratosACHDebitosResponse" element="ns0:ConsultaContratosACHDebitosResponse" location="../../../BusinessServices/T24/ACHContratos/xsd/XMLSchema_-1123798799.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoContratoACHResponse" location="../xsd/consultaEstadoContratoACHTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoContratoACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoContratoACH/xq/consultaEstadoContratoACHOut/";

declare function xf:consultaEstadoContratoACHOut($consultaContratosACHDebitosResponse as element(ns0:ConsultaContratosACHDebitosResponse))
    as element(ns1:consultaEstadoContratoACHResponse) {
        <ns1:consultaEstadoContratoACHResponse>
        	{
        		if (empty($consultaContratosACHDebitosResponse/FICOESTATUSACHDEBITOSType[1]/ZERORECORD/text())) then (
	        		for $Record in $consultaContratosACHDebitosResponse/FICOESTATUSACHDEBITOSType/gFICOESTATUSACHDEBITOSDetailType/mFICOESTATUSACHDEBITOSDetailType
	        		return
		            <consultaEstadoContratoACHResponseRecord>
		                <ID_CONTRATO>{ data($Record/ID) }</ID_CONTRATO>
		                <ESTADO_CONTRATO>{ data($Record/ESTADOCONTRATO) }</ESTADO_CONTRATO>
		            </consultaEstadoContratoACHResponseRecord>
		         ) else ()		            
            }
        </ns1:consultaEstadoContratoACHResponse>
};

declare variable $consultaContratosACHDebitosResponse as element(ns0:ConsultaContratosACHDebitosResponse) external;

xf:consultaEstadoContratoACHOut($consultaContratosACHDebitosResponse)