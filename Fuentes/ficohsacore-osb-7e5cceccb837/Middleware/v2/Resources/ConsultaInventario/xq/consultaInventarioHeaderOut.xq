(:: pragma bea:global-element-parameter parameter="$consultadetalleinventarioResponse1" element="ns1:ConsultadetalleinventarioResponse" location="../../../BusinessServices/T24/ventaInventario/xsd/XMLSchema_-2134013027.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInventario/xq/consultaInventarioHeaderOut/";

declare function xf:consultaInventarioHeaderOut($consultadetalleinventarioResponse1 as element(ns1:ConsultadetalleinventarioResponse))
    as element(ns0:ResponseHeader) {
    	<ns0:ResponseHeader>
    	{
	    	if (fn:string($consultadetalleinventarioResponse1/Status/successIndicator/text()) = "Success" and
	    		fn:string($consultadetalleinventarioResponse1/WSINVENTORYType/ZERORECORDS/text()) != "") then (
	    		<successIndicator>NO RECORDS</successIndicator>,
	    		<messages>ZERO RECORDS RETURNED</messages>
	        ) else (
	        	<successIndicator>{ fn:string($consultadetalleinventarioResponse1/Status/successIndicator/text()) }</successIndicator>,
	        	<messages>{ fn:string($consultadetalleinventarioResponse1/Status/messages/text()) }</messages>
	        )
	    }
        </ns0:ResponseHeader>
};

declare variable $consultadetalleinventarioResponse1 as element(ns1:ConsultadetalleinventarioResponse) external;

xf:consultaInventarioHeaderOut($consultadetalleinventarioResponse1)