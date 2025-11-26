xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnrutadorConvenios/xq/enrutadorCoveniosOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/EnviarTransaccion";
declare namespace ns1 = "http://service.webserviceprovider.transporters.service.frametexx.com/";

declare function xf:enrutadorCoveniosOut($outputParameters1 as element(ns0:OutputParameters))
    as element(*) {
        <ns1:invokeResponse>
	        <serviceResponse>
	        	<responseConnector>{ "WS Provider 'OSB'" }</responseConnector>
	        	<responseTime>{ 0 }</responseTime>
	            {
	                for $PX_XMLOUT in $outputParameters1/ns0:PX_XMLOUT
	                return
	                	
	                    <responseData>{ data($PX_XMLOUT) }</responseData>
	            }
	        </serviceResponse>
	    </ns1:invokeResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:enrutadorCoveniosOut($outputParameters1)