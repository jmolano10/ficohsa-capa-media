(:: pragma bea:global-element-parameter parameter="$consultadesaldodeprestamoResponse1" element="ns0:ConsultadesaldodeprestamoResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaGeneralPrestamo/ConsultaPrestamoT24HeaderOut/";

declare function xf:ConsultaPrestamoT24HeaderOut($consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (fn:string($consultadesaldodeprestamoResponse1/Status/successIndicator/text()) = "Success" and
	    		fn:empty($consultadesaldodeprestamoResponse1/WSLOANDETAILSAAType[1]/gWSLOANDETAILSAADetailType[1]/mWSLOANDETAILSAADetailType[1]/CUSTOMERNAME/text())) then (
	           		<successIndicator>ERROR</successIndicator>,
	           		<messages>NO RECORDS RETURNED</messages>
            	) else (
						<successIndicator>{ data($consultadesaldodeprestamoResponse1/Status/successIndicator) }</successIndicator>,
            			<messages>{ data($consultadesaldodeprestamoResponse1/Status/messages) }</messages>		            	
            	)
            }
            
        </ns1:ResponseHeader>
};

declare variable $consultadesaldodeprestamoResponse1 as element(ns0:ConsultadesaldodeprestamoResponse) external;

xf:ConsultaPrestamoT24HeaderOut($consultadesaldodeprestamoResponse1)