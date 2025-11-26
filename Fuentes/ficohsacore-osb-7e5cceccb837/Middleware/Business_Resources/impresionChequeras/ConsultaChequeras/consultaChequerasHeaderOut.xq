(:: pragma bea:global-element-parameter parameter="$consultadechequerasporimprimirResponse" element="ns0:ConsultadechequerasporimprimirResponse" location="../Resources/XMLSchema_1756805255.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/ConsultaChequeras/consultaChequerasHeaderOut/";

declare function xf:consultaChequerasHeaderOut($consultadechequerasporimprimirResponse as element(ns0:ConsultadechequerasporimprimirResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadechequerasporimprimirResponse/WSCHECKBOOKREQUESTENQType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadechequerasporimprimirResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadechequerasporimprimirResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadechequerasporimprimirResponse/WSCHECKBOOKREQUESTENQType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadechequerasporimprimirResponse as element(ns0:ConsultadechequerasporimprimirResponse) external;

xf:consultaChequerasHeaderOut($consultadechequerasporimprimirResponse)