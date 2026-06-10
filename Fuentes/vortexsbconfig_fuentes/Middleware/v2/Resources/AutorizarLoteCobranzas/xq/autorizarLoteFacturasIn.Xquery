<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizarLoteCobranzas1" element="ns0:autorizarLoteCobranzas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/autorizarLoteFacturas/xsd/autorizarLoteFacturas_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarLoteFacturas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLoteCobranzas/xq/autorizarLoteFacturasIn/";

declare function xf:autorizarLoteFacturasIn($autorizarLoteCobranzas1 as element(ns0:autorizarLoteCobranzas))
	as element(ns1:InputParameters) {
		<ns1:InputParameters>
			<ns1:PV_CODIGOCLIENTE>{ data($autorizarLoteCobranzas1/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
			<ns1:PV_NUMEROCONTRATO>{ data($autorizarLoteCobranzas1/CONTRACT_ID) }</ns1:PV_NUMEROCONTRATO>
            <ns1:PV_NROLOTE>{ data($autorizarLoteCobranzas1/BANK_BATCH_ID) }</ns1:PV_NROLOTE>
            <ns1:PV_AUTORIZADOR>{ data($autorizarLoteCobranzas1/USER_ID) }</ns1:PV_AUTORIZADOR>
		</ns1:InputParameters>
};

declare variable $autorizarLoteCobranzas1 as element(ns0:autorizarLoteCobranzas) external;

xf:autorizarLoteFacturasIn($autorizarLoteCobranzas1)]]></con:xquery>
    <con:dependency location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CobranzasElectronicas/xsd/cobranzasElectronicasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABK/autorizarLoteFacturas/xsd/autorizarLoteFacturas_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/autorizarLoteFacturas/xsd/autorizarLoteFacturas_sp"/>
    </con:dependency>
</con:xqueryEntry>