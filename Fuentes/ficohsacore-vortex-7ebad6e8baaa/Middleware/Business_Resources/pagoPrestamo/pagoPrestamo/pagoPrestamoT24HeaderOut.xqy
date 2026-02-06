xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAFTResponse1" element="ns0:PagoaprestamoAAFTResponse" location="../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoBOT24HeaderOut/";

declare function xf:pagoPrestamoBOT24HeaderOut($pagoaprestamoAAFTResponse1 as element(ns0:PagoaprestamoAAFTResponse),
	$successIndicatorQry2 as xs:string)
    as element(ns1:ResponseHeader) {
    	if ($successIndicatorQry2 = "SUCCESS") then (
	        <ns1:ResponseHeader>
	            {
	                for $transactionId in $pagoaprestamoAAFTResponse1/Status/transactionId
	                return
	                    <transactionId>{ data($transactionId) }</transactionId>
	            }
	            {
	                for $successIndicator in $pagoaprestamoAAFTResponse1/Status/successIndicator
	                return
	                    <successIndicator>{ data($successIndicator) }</successIndicator>
	            }
	            {
	                for $messages in $pagoaprestamoAAFTResponse1/Status/messages
	                return
	                    <messages>{ data($messages) }</messages>
	            }
	        </ns1:ResponseHeader>
	    ) else (
	    	<ns1:ResponseHeader>
	    		<successIndicator>{ data($successIndicatorQry2) }</successIndicator>
	    		<messages>
	    		{
	    			if ($successIndicatorQry2 = "TIMEOUT") then (
	    				"TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS"
	    			) else if ($successIndicatorQry2 = "ERROR") then (
						"ERROR APLICANDO PAGO A PRESTAMO"
	    			) else (
	    				fn:string-join($pagoaprestamoAAFTResponse1/Status/messages,";")
	    			)
	    		}
	    		</messages>
	    	</ns1:ResponseHeader>
	    )
	    
};

declare variable $pagoaprestamoAAFTResponse1 as element(ns0:PagoaprestamoAAFTResponse) external;
declare variable $successIndicatorQry2 as xs:string external;

xf:pagoPrestamoBOT24HeaderOut($pagoaprestamoAAFTResponse1,
	$successIndicatorQry2)