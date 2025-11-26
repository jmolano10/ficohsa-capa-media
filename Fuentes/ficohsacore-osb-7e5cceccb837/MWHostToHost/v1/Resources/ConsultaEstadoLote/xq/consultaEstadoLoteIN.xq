(:: pragma bea:global-element-parameter parameter="$consultaEstadoLoteRequest" element="ns0:consultaEstadoLoteRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/consultaEstadoLote/xsd/consultaEstadoLote_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaEstadoLote";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/consultaEstadoLote/xq/consultaEstadoLoteIN/";

declare function xf:consultaEstadoLoteIN($consultaEstadoLoteRequest as element(ns0:consultaEstadoLoteRequest))
    as element(ns1:InputParameters) {
	<ns1:InputParameters>
		<ns1:PV_CODIGOCLIENTE>{ data($consultaEstadoLoteRequest/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
		<ns1:PV_CODIGOLOTE>{ data($consultaEstadoLoteRequest/BANK_BATCH_ID) }</ns1:PV_CODIGOLOTE>
	</ns1:InputParameters>
};

declare variable $consultaEstadoLoteRequest as element(ns0:consultaEstadoLoteRequest) external;

xf:consultaEstadoLoteIN($consultaEstadoLoteRequest)