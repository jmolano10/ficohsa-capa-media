xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:cargaLoteProductosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosOUT/";

declare function xf:cargaLoteProductosOUT($codLote as xs:string)
    as element(ns1:cargaLoteProductosResponse) {
	<ns1:cargaLoteProductosResponse>
		<BANK_BATCH_ID>{ $codLote }</BANK_BATCH_ID>
	</ns1:cargaLoteProductosResponse>
};

declare variable $codLote as xs:string external;

xf:cargaLoteProductosOUT($codLote)