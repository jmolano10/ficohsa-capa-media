(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/TSP/registrarDevolucionDiferidaTSP/xsd/DevolucionDiferidaTSP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/DevolucionDiferidaTSP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/devolucionDiferidaTSPHeaderOUT/";

declare function xf:devolucionDiferidaTSPHeaderOUT($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>      
	        <successIndicator>     
			{ 
	         if (fn:string($outputParameters1/ns0:PV_COD_RSPTA/text()) != "SUCCESS") then (
	            	"ERROR"
	        ) else (
	        		"SUCCESS"
	        )
	        }
	        </successIndicator>
	        {
			if (fn:string($outputParameters1/ns0:PV_COD_RSPTA/text()) != "SUCCESS") then ( 
		        <messages>
		        {
		        	fn:concat(fn:string($outputParameters1/ns0:PV_COD_RSPTA/text()), "|", fn:string($outputParameters1/ns0:PV_DES_RSPTA/text()))
		        }
		        </messages>
		    ) else (
		    	<messages>
		        {
		        	"OPERACION EXITOSA"
		        }
		        </messages>
		    )
		    
			}                        
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:devolucionDiferidaTSPHeaderOUT($outputParameters1)