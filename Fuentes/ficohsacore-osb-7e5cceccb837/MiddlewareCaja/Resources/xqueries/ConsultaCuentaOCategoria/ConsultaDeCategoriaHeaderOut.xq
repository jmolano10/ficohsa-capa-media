(:: pragma bea:global-element-parameter parameter="$consultadecategoriaResponse" element="ns0:ConsultadecategoriaResponse" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaCuentaOCategoria/ConsultaDeCategoriaHeaderOut/";

declare function xf:ConsultaDeCategoriaHeaderOut($consultadecategoriaResponse as element(ns0:ConsultadecategoriaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
            	if (empty($consultadecategoriaResponse/WSCATEGORYLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadecategoriaResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadecategoriaResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadecategoriaResponse/WSCATEGORYLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadecategoriaResponse as element(ns0:ConsultadecategoriaResponse) external;

xf:ConsultaDeCategoriaHeaderOut($consultadecategoriaResponse)