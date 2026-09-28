(:: pragma bea:global-element-parameter parameter="$OutputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PWS/consultaEstadoLote/xsd/consultaEstadoLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cargaLoteProductosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEstadoLote";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/consultaEstadoLote/xq/consultaEstadoLoteOUT/";

declare function xf:consultaEstadoLoteOUT($OutputParameters as element(ns0:OutputParameters), $customerId as xs:string, $bankBatchId as xs:string)
    as element(ns1:consultaEstadoLoteResponse) {
	<ns1:consultaEstadoLoteResponse>
		<CUSTOMER_ID>{ $customerId }</CUSTOMER_ID>
		<BANK_BATCH_ID>{ $bankBatchId }</BANK_BATCH_ID>
		<STATUS>{ data($OutputParameters/ns0:PN_CODIGOESTADO) }</STATUS>
		<STATUS_DESC>{ data($OutputParameters/ns0:PV_DESCRIPCIONESTADO) }</STATUS_DESC>
		<NUMBER_OF_CUSTOMERS>{ data($OutputParameters/ns0:PN_NUMEROCLIENTES) }</NUMBER_OF_CUSTOMERS>
		<NUMBER_OF_CUSTOMERS_SUCCESS>{ data($OutputParameters/ns0:PN_NUMEROCLIENTESCORRECTOS) }</NUMBER_OF_CUSTOMERS_SUCCESS>
		<NUMBER_OF_CUSTOMERS_ERROR>{ data($OutputParameters/ns0:PN_NUMEROCLIENTESERROR) }</NUMBER_OF_CUSTOMERS_ERROR>
		<APPLICATION_DATE>{ data($OutputParameters/ns0:PN_FECHAADICION) }</APPLICATION_DATE>
	</ns1:consultaEstadoLoteResponse>
};

declare variable $OutputParameters as element(ns0:OutputParameters) external;
declare variable $customerId as xs:string external;
declare variable $bankBatchId as xs:string external;

xf:consultaEstadoLoteOUT($OutputParameters, $customerId, $bankBatchId)