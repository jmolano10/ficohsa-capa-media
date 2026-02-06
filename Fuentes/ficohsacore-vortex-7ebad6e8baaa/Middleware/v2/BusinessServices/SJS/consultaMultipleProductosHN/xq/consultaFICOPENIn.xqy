xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../../Business_Resources/Ficopen/Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaFICOPENIn/";

declare function xf:consultaFICOPENIn($ProductxTipo as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:INVESTMENT_CODE>{ $ProductxTipo }</ns0:INVESTMENT_CODE>
            {
	            let $fechaSistema := string(current-date())
	            return(
	            	<ns0:START_DATE>{string-join((substring($fechaSistema,1,4),substring($fechaSistema,6,2),substring($fechaSistema,9,2)),"")}</ns0:START_DATE>,
	            	<ns0:END_DATE>{string-join((substring($fechaSistema,1,4),substring($fechaSistema,6,2),substring($fechaSistema,9,2)),"")}</ns0:END_DATE>
	            )
            }
        </ns0:InputParameters>
};

declare variable $ProductxTipo as xs:string external;

xf:consultaFICOPENIn($ProductxTipo)