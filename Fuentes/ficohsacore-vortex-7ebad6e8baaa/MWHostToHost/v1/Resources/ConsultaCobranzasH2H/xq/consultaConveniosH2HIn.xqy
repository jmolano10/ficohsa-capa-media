xquery version "2004-draft";
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

xf:consultaConveniosH2HIn($consultaCobranzas, $sourceBank)