(:: pragma bea:global-element-parameter parameter="$listadesolicitudescontimeoutResponse" element="ns0:ListadesolicitudescontimeoutResponse" location="../Resources/XMLSchema_1080088451.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/errorHandling/ListaSolicitudesTimeout/listaSolicitudesTimeoutHeaderOut/";

declare function xf:listaSolicitudesTimeoutHeaderOut($listadesolicitudescontimeoutResponse as element(ns0:ListadesolicitudescontimeoutResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($listadesolicitudescontimeoutResponse/WSFICOEERRORHANDLEType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($listadesolicitudescontimeoutResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($listadesolicitudescontimeoutResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($listadesolicitudescontimeoutResponse/WSFICOEERRORHANDLEType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $listadesolicitudescontimeoutResponse as element(ns0:ListadesolicitudescontimeoutResponse) external;

xf:listaSolicitudesTimeoutHeaderOut($listadesolicitudescontimeoutResponse)