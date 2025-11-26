(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAResponse1" element="ns0:PagoaprestamoAAResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoT24HeaderOut/";

declare function xf:PagoPrestamoT24HeaderOut($pagoaprestamoAAResponse1 as element(ns0:PagoaprestamoAAResponse),
	$successIndicatorQry1 as xs:string,
	$successIndicatorQry2 as xs:string)
    as element(ns1:ResponseHeader) {
    	if ($successIndicatorQry1 = "SUCCESS" and
    		$successIndicatorQry2 = "SUCCESS") then (
	        <ns1:ResponseHeader>
	            {
	                for $transactionId in $pagoaprestamoAAResponse1/Status/transactionId
	                return
	                    <transactionId>{ data($transactionId) }</transactionId>
	            }
	            {
	                for $successIndicator in $pagoaprestamoAAResponse1/Status/successIndicator
	                return
	                    <successIndicator>{ data($successIndicator) }</successIndicator>
	            }
	            {
	                for $messages in $pagoaprestamoAAResponse1/Status/messages
	                return
	                    <messages>{ data($messages) }</messages>
	            }
	        </ns1:ResponseHeader>
		) else (
			<ns1:ResponseHeader>
				<successIndicator>ERROR</successIndicator>
				<messages>ERROR APPLYING LOAN PAYMENT</messages>
			</ns1:ResponseHeader>
		)
};

declare variable $pagoaprestamoAAResponse1 as element(ns0:PagoaprestamoAAResponse) external;
declare variable $successIndicatorQry1 as xs:string external;
declare variable $successIndicatorQry2 as xs:string external;

xf:PagoPrestamoT24HeaderOut($pagoaprestamoAAResponse1,
	$successIndicatorQry1,
	$successIndicatorQry2)