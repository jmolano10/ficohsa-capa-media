(:: pragma bea:global-element-parameter parameter="$listaderecaudosResponse" element="ns0:ListaderecaudosResponse" location="../Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/listaRecaudos/listaRecaudosHeaderOut/";

declare function xf:listaRecaudosHeaderOut($listaderecaudosResponse as element(ns0:ListaderecaudosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($listaderecaudosResponse/WSCOLLECTIONSLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($listaderecaudosResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($listaderecaudosResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($listaderecaudosResponse/WSCOLLECTIONSLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $listaderecaudosResponse as element(ns0:ListaderecaudosResponse) external;

xf:listaRecaudosHeaderOut($listaderecaudosResponse)