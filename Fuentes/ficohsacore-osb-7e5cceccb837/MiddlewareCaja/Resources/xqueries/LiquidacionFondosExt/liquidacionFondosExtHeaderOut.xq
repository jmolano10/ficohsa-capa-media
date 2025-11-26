(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalResponse1" element="ns1:RetiroenmonedalocalResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../xsds/RegistrarLiqFondosExt/registrarLiqFondosExt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarLiqFondosExt";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/liquidacionFondosHeaderOut/";

declare function xf:liquidacionFondosHeaderOut($retiroenmonedalocalResponse1 as element(ns1:RetiroenmonedalocalResponse),
	$outputParameters1 as element(ns2:OutputParameters))
    as element(ns0:ResponseHeader) {
    	if (fn:string($retiroenmonedalocalResponse1/Status/successIndicator/text()) = "Success" and
    		fn:string($outputParameters1/ns2:PN_ERROR/text()) = "0") then (
	        <ns0:ResponseHeader>
	            {
	                for $transactionId in $retiroenmonedalocalResponse1/Status/transactionId
	                return
	                    <transactionId>{ data($transactionId) }</transactionId>
	            }
	            {
	                for $successIndicator in $retiroenmonedalocalResponse1/Status/successIndicator
	                return
	                    <successIndicator>{ data($successIndicator) }</successIndicator>
	            }
	            {
	                for $VALUEDATE2 in $retiroenmonedalocalResponse1/TELLERType/VALUEDATE2
	                return
	                    <valueDate>{ data($VALUEDATE2) }</valueDate>
	            }
	        </ns0:ResponseHeader>
	    ) else (
	    	<ns0:ResponseHeader>
	            <successIndicator>ERROR</successIndicator>
	            <messages>{ fn:string-join($retiroenmonedalocalResponse1/Status/messages,";") }</messages>
	        </ns0:ResponseHeader>
	    )
};

declare variable $retiroenmonedalocalResponse1 as element(ns1:RetiroenmonedalocalResponse) external;
declare variable $outputParameters1 as element(ns2:OutputParameters) external;

xf:liquidacionFondosHeaderOut($retiroenmonedalocalResponse1,
	$outputParameters1)