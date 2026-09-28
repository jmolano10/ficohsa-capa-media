xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAResponse" element="ns1:PagoaprestamoAAResponse" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24HeaderOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";

declare function xf:pagoPrestamoT24HeaderOut($pagoaprestamoAAResponse as element(ns1:PagoaprestamoAAResponse),
    $successIndicatorQry2 as xs:string)
    as element(ns0:ResponseHeader) {
        if ($successIndicatorQry2 = "SUCCESS") then (
	        <ns0:ResponseHeader>
	            {
	                for $transactionId in $pagoaprestamoAAResponse/Status/transactionId
	                return
	                    <transactionId>{ data($transactionId) }</transactionId>
	            }
	            {
	                for $successIndicator in $pagoaprestamoAAResponse/Status/successIndicator
	                return
	                    <successIndicator>{ data($successIndicator) }</successIndicator>
	            }
	            {
	                for $messages in $pagoaprestamoAAResponse/Status/messages
	                return
	                    <messages>{ data($messages) }</messages>
	            }
	        </ns0:ResponseHeader>
	    ) else (
	    	<ns0:ResponseHeader>
	    		<successIndicator>
	    		{
	    			if(fn:string($successIndicatorQry2) = "") then (
	    				"ERROR"
	    			) else (
	    				fn:string($successIndicatorQry2)
	    			)
	    			 
	    		}
	    		</successIndicator>
	    		<messages>
	    		{
	    			if ($successIndicatorQry2 = "TIMEOUT") then (
	    				"TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS"
	    			) else if ($successIndicatorQry2 = "ERROR") then (
						"ERROR APLICANDO PAGO A PRESTAMO"
	    			) else (
	    				fn:string-join($pagoaprestamoAAResponse/Status/messages,";")
	    			)
	    		}
	    		</messages>
	    	</ns0:ResponseHeader>
	    )
};

declare variable $pagoaprestamoAAResponse as element(ns1:PagoaprestamoAAResponse) external;
declare variable $successIndicatorQry2 as xs:string external;

xf:pagoPrestamoT24HeaderOut($pagoaprestamoAAResponse,
    $successIndicatorQry2)