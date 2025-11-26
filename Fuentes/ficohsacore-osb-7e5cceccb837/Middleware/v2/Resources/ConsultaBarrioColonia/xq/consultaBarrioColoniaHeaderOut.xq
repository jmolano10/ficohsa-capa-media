(:: pragma bea:global-element-parameter parameter="$consultadecoloniaobarrioResponse" element="ns0:ConsultadecoloniaobarrioResponse" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaBarrioColonia/xq/consultaBarrioColoniaHeaderOut/";

declare function xf:consultaBarrioColoniaHeaderOut($consultadecoloniaobarrioResponse as element(ns0:ConsultadecoloniaobarrioResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadecoloniaobarrioResponse/WSNEIGHBORHOODLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadecoloniaobarrioResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadecoloniaobarrioResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadecoloniaobarrioResponse/WSNEIGHBORHOODLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadecoloniaobarrioResponse as element(ns0:ConsultadecoloniaobarrioResponse) external;

xf:consultaBarrioColoniaHeaderOut($consultadecoloniaobarrioResponse)