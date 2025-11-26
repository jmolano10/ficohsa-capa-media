(:: pragma bea:global-element-parameter parameter="$consultadeprofesionesResponse" element="ns0:ConsultadeprofesionesResponse" location="../Resources/XMLSchema_123738754.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaProfesion/ConsultaProfesiones/consultaProfesionesHeaderOut/";

declare function xf:consultaProfesionesHeaderOut($consultadeprofesionesResponse as element(ns0:ConsultadeprofesionesResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadeprofesionesResponse/WSPROFESSIONLISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadeprofesionesResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadeprofesionesResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadeprofesionesResponse/WSPROFESSIONLISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadeprofesionesResponse as element(ns0:ConsultadeprofesionesResponse) external;

xf:consultaProfesionesHeaderOut($consultadeprofesionesResponse)