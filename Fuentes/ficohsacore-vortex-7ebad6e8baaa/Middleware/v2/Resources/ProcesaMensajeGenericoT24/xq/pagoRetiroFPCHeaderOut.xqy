xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/pagoRetiroFPC/xsd/PAGO_RETIRO_FPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PAGO_RETIRO_FPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/pagoRetiroFPCHeaderOut/";

declare function xf:pagoRetiroFPCHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	<successIndicator>
                    { 
                    	if (data($outputParameters1/ns1:P_ERROR_CODE)  = "0") then (
	                    	"SUCCESS"
	                	) else (
	                		"ERROR"
	                	)
                    }
            </successIndicator>
            {

                if (data($outputParameters1/ns1:P_ERROR_CODE) = "0") then 
                    <messages>
                    {
                    	fn:concat(data($outputParameters1/ns1:P_ERROR_CODE), "|", data($outputParameters1/ns1:P_ERROR))
                    }
                    </messages>
                else (
                	<messages>
                    {
                    	fn:concat(data($outputParameters1/ns1:P_ERROR_CODE), "|", data($outputParameters1/ns1:P_ERROR))
                    }
                    </messages>
                )
                
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:pagoRetiroFPCHeaderOut($outputParameters1)