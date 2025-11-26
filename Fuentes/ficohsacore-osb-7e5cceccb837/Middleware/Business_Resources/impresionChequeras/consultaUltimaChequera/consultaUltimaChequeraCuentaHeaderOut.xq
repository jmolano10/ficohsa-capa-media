(:: pragma bea:global-element-parameter parameter="$consultaUltimaChequeraResponse1" element="ns0:ConsultaUltimaChequeraResponse" location="../Resources/XMLSchema_1756805255.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/impresionChequeras/consultaUltimaChequera/consultaUltimaChequeraHeaderOut/";

declare function xf:consultaUltimaChequeraHeaderOut($consultaUltimaChequeraResponse1 as element(ns0:ConsultaUltimaChequeraResponse))
    as element(ns1:ResponseHeader) {
		<ns1:ResponseHeader>
            {
            	if (empty($consultaUltimaChequeraResponse1/WSCHECKBOOKREQUESTENQLASTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaUltimaChequeraResponse1/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultaUltimaChequeraResponse1/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaUltimaChequeraResponse1/WSCHECKBOOKREQUESTENQLASTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultaUltimaChequeraResponse1 as element(ns0:ConsultaUltimaChequeraResponse) external;

xf:consultaUltimaChequeraHeaderOut($consultaUltimaChequeraResponse1)