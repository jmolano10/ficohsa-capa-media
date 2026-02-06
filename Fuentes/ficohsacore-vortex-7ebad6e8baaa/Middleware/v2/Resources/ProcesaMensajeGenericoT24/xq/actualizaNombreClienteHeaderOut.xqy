xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/actualizaNombreCliente/xsd/actualizaNombreCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaNombreCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/actualizaNombreClienteHeaderOut/";

declare function xf:actualizaNombreClienteHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
           
			<successIndicator>
                    { 
                    	if (fn:string($outputParameters1/ns0:ESTADO/text()) != "SUCCESS") then (
	                    	"ERROR"
	                	) else (
	                		"SUCCESS"
	                	)
                    }
            </successIndicator>
            {
            	if (fn:string($outputParameters1/ns0:ESTADO/text()) != "SUCCESS") then ( 
                    <messages>
                    {
                    	fn:concat(fn:string($outputParameters1/ns0:ESTADO/text()), "|", fn:string($outputParameters1/ns0:MENSAJE/text()))
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

xf:actualizaNombreClienteHeaderOut($outputParameters1)