<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaCobranzas" element="ns0:consultaCobranzas" location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/INTFC/consultaConveniosH2H/xsd/consultaConveniosH2H_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasH2HTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConveniosH2H";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaCobranzasH2H/xq/consultaConveniosH2HIn/";

declare function xf:consultaConveniosH2HIn($consultaCobranzas as element(ns0:consultaCobranzas),
	$sourceBank as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
        	<ns1:PT_IDSERVICIO>
	            {
	                for $serviceId in distinct-values($consultaCobranzas/SERVICES/SERVICE/ID)
	                return	
	                	<ns1:PT_IDSERVICIO_ITEM>{ data($serviceId) }</ns1:PT_IDSERVICIO_ITEM>
	            }
	        </ns1:PT_IDSERVICIO>
	        <ns1:PV_CODIGOPAIS>{ $sourceBank }</ns1:PV_CODIGOPAIS>
        </ns1:InputParameters>
};

declare variable $consultaCobranzas as element(ns0:consultaCobranzas) external;
declare variable $sourceBank as xs:string external;

xf:consultaConveniosH2HIn($consultaCobranzas, $sourceBank)]]></con:xquery>
    <con:dependency location="../../CobranzasH2H/xsd/cobranzasH2HTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/CobranzasH2H/xsd/cobranzasH2HTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/INTFC/consultaConveniosH2H/xsd/consultaConveniosH2H_sp.xsd">
        <con:schema ref="MWHostToHost/v1/BusinessServices/INTFC/consultaConveniosH2H/xsd/consultaConveniosH2H_sp"/>
    </con:dependency>
</con:xqueryEntry>