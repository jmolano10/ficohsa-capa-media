<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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

xf:consultaEstadoLoteIN($consultaEstadoLoteRequest)]]></con:xquery>
    <con:dependency location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/AperturaMasiva/xsd/aperturaMasivaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/PWS/consultaEstadoLote/xsd/consultaEstadoLote_sp.xsd">
        <con:schema ref="MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/xsd/consultaEstadoLote_sp"/>
    </con:dependency>
</con:xqueryEntry>