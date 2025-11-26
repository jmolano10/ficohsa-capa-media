(:: pragma bea:global-element-parameter parameter="$listadeFicoAlertasporproductoResponse" element="ns0:ListadeFicoAlertasporproductoResponse" location="../Resources/XMLSchema_1876963756.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ListaFicoAlertaProducto/listaFicoAlertaProductoHeaderOut/";

declare function xf:listaFicoAlertaProductoHeaderOut($listadeFicoAlertasporproductoResponse as element(ns0:ListadeFicoAlertasporproductoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($listadeFicoAlertasporproductoResponse/WSACCOUNTALERTSType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($listadeFicoAlertasporproductoResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($listadeFicoAlertasporproductoResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($listadeFicoAlertasporproductoResponse/WSACCOUNTALERTSType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $listadeFicoAlertasporproductoResponse as element(ns0:ListadeFicoAlertasporproductoResponse) external;

xf:listaFicoAlertaProductoHeaderOut($listadeFicoAlertasporproductoResponse)