(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conConsultaCliente/xsd/conConsultaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteTRCGTHeaderOut/";

declare function xf:validaProductoClienteTRCGTHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
	        	if(data($outputParameters/ns1:CodigoError) = '-1') then(
	    			<successIndicator>Success</successIndicator>
	    		)else(
	    			<successIndicator>ERROR</successIndicator>,
	    			<messages>{ data($outputParameters/ns1:MensajeError) }</messages>
	    		)
    		}
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:validaProductoClienteTRCGTHeaderOut($outputParameters)
