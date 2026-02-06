xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/reversionRetiroFPC/xsd/REVERSION_RETIRO_FPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/reversionRetiroFPCHeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/REVERSION_RETIRO_FPC";

declare function xf:reversionRetiroFPCHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	<successIndicator>
                    { 
                    	if (data($outputParameters/ns1:P_ERROR_CODE)  = "0") then (
	                    	"SUCCESS"
	                	) else (
	                		"ERROR"
	                	)
                    }
            </successIndicator>
            {

                if (data($outputParameters/ns1:P_ERROR_CODE) = "0") then 
                    <messages>
                    {
                    	fn:concat(data($outputParameters/ns1:P_ERROR_CODE), "|", data($outputParameters/ns1:P_ERROR))
                    }
                    </messages>
                else (
                	<messages>
                    {
                    	fn:concat(data($outputParameters/ns1:P_ERROR_CODE), "|", data($outputParameters/ns1:P_ERROR))
                    }
                    </messages>
                )
                
            }
         </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:reversionRetiroFPCHeaderOut($outputParameters)