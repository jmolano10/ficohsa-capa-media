(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../xsds/ConsultarLiqFondosExt/consultarLiqFondosExt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLiqFondosExt";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/consultaLiqFondosHeaderOut/";

declare function xf:consultaLiqFondosHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        {
        	if (fn:string($outputParameters1/ns1:PN_ERROR/text()) = "0") then (
        		<successIndicator>Success</successIndicator>
        	) else (
        		<successIndicator>ERROR</successIndicator>,
        		<messages>{ fn:string($outputParameters1/ns1:PV_ERROR/text()) }</messages>
        	)
        }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaLiqFondosHeaderOut($outputParameters1)