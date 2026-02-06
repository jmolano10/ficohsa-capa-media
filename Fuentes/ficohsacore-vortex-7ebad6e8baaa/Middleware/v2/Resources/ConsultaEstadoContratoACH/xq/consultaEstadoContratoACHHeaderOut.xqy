xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaContratosACHDebitosResponse" element="ns1:ConsultaContratosACHDebitosResponse" location="../../../BusinessServices/T24/ACHContratos/xsd/XMLSchema_-1123798799.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoContratoACH/xq/consultaEstadoContratoACHHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:consultaEstadoContratoACHHeaderOut($consultaContratosACHDebitosResponse as element(ns1:ConsultaContratosACHDebitosResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
			{
            	if (empty($consultaContratosACHDebitosResponse/FICOESTATUSACHDEBITOSType[1]/ZERORECORD/text())) then (
            		<successIndicator>{ fn:upper-case(data($consultaContratosACHDebitosResponse/Status/successIndicator)) }</successIndicator>,
            		<messages>{ data($consultaContratosACHDebitosResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaContratosACHDebitosResponse/FICOESTATUSACHDEBITOSType[1]/ZERORECORD) }</messages>
            	)
            }
        </ns0:ResponseHeader>
};

declare variable $consultaContratosACHDebitosResponse as element(ns1:ConsultaContratosACHDebitosResponse) external;

xf:consultaEstadoContratoACHHeaderOut($consultaContratosACHDebitosResponse)