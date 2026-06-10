<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:cargaLoteProductosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosOUT/";

declare function xf:cargaLoteProductosOUT($codLote as xs:string)
    as element(ns1:cargaLoteProductosResponse) {
	&lt;ns1:cargaLoteProductosResponse>
		&lt;BANK_BATCH_ID>{ $codLote }&lt;/BANK_BATCH_ID>
	&lt;/ns1:cargaLoteProductosResponse>
};

declare variable $codLote as xs:string external;

xf:cargaLoteProductosOUT($codLote)</con:xquery>
    <con:dependency location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/AperturaMasiva/xsd/aperturaMasivaTypes"/>
    </con:dependency>
</con:xqueryEntry>