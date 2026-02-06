xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaProductoOnBase" element="ns0:consultaProductoOnBase" location="../../ConsultaProductoOnBase/xsd/consultaProductoOnBaseTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/Ficopen/Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaProductoOnBaseTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaProductoOnBaseHN/xq/consultaProductoOnBaseFPCHNIn/";

declare function xf:consultaProductoOnBaseFPCHNIn($consultaProductoOnBase as element(ns0:consultaProductoOnBase))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:INVESTMENT_CODE>{ data($consultaProductoOnBase/PRODUCT_NUMBER) }</ns1:INVESTMENT_CODE>
            {
	            let $fechaSistema := string(current-date())
	            return(
	            	<ns0:START_DATE>{string-join((substring($fechaSistema,1,4),substring($fechaSistema,6,2),substring($fechaSistema,9,2)),"")}</ns0:START_DATE>,
	            	<ns0:END_DATE>{string-join((substring($fechaSistema,1,4),substring($fechaSistema,6,2),substring($fechaSistema,9,2)),"")}</ns0:END_DATE>
	            )
            }
        </ns1:InputParameters>
};

declare variable $consultaProductoOnBase as element(ns0:consultaProductoOnBase) external;

xf:consultaProductoOnBaseFPCHNIn($consultaProductoOnBase)