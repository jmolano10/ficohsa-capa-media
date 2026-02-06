xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaClienteDesembolsoLineaCredito" element="ns0:consultaClienteDesembolsoLineaCredito" location="../../ServiciosEmpresariales/xsd/serviciosEmpresarialesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ServiciosEmpresariales/consultaClienteDesembolsoLineaCredito/xsd/consultaClienteDesembolsoLineaCredito_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/serviciosEmpresarialesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaClienteDesembolsoLineaCredito";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaClienteDesembolsoLineaCredito/xq/consultaClienteDesembolsoLineaCreditoHNIn/";

declare function xf:consultaClienteDesembolsoLineaCreditoHNIn($consultaClienteDesembolsoLineaCredito as element(ns0:consultaClienteDesembolsoLineaCredito))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_CUSTOMER_TYPE>{ data($consultaClienteDesembolsoLineaCredito/CUSTOMER_QUERY/TYPE) }</ns1:P_CUSTOMER_TYPE>
            <ns1:P_CUSTOMER_VALUE>
            {
            	for $VALUE in $consultaClienteDesembolsoLineaCredito/CUSTOMER_QUERY/VALUES/VALUE
            		return(
	        			<ns1:P_CUSTOMER_VALUE_ITEM>{ data($VALUE) }</ns1:P_CUSTOMER_VALUE_ITEM>
	        	)
	        }
	        </ns1:P_CUSTOMER_VALUE>
	  
        </ns1:InputParameters>
};

declare variable $consultaClienteDesembolsoLineaCredito as element(ns0:consultaClienteDesembolsoLineaCredito) external;

xf:consultaClienteDesembolsoLineaCreditoHNIn($consultaClienteDesembolsoLineaCredito)