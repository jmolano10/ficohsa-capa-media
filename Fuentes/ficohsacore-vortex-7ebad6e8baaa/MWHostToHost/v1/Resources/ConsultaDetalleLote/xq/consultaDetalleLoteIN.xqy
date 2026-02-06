xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLoteRequest" element="ns0:consultaDetalleLoteRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/consultaDetalleLote/xsd/consultaDetalleLote_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleLote";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaComisionesH2H/xq/consultaComisionesH2HOUT/";

declare function xf:consultaDetalleLoteIN($consultaDetalleLoteRequest as element(ns0:consultaDetalleLoteRequest))
    as element(ns1:InputParameters) {
	<ns1:InputParameters>
		<ns1:PV_CODIGOCLIENTE>{ data($consultaDetalleLoteRequest/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
		<ns1:PV_CODIGOLOTE>{ data($consultaDetalleLoteRequest/BANK_BATCH_ID) }</ns1:PV_CODIGOLOTE>
	</ns1:InputParameters>
};

declare variable $consultaDetalleLoteRequest as element(ns0:consultaDetalleLoteRequest) external;

xf:consultaDetalleLoteIN($consultaDetalleLoteRequest)