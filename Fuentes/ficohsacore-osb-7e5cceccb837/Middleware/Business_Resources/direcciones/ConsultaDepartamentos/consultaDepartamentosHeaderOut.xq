(:: pragma bea:global-element-parameter parameter="$consultadedepartamentosResponse" element="ns0:ConsultadedepartamentosResponse" location="../Resources/XMLSchema_1123420404.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/direcciones/ConsultaDepartamentos/consultaDepartamentosHeaderOut/";

declare function xf:consultaDepartamentosHeaderOut($consultadedepartamentosResponse as element(ns0:ConsultadedepartamentosResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadedepartamentosResponse/WSSTATELISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadedepartamentosResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadedepartamentosResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadedepartamentosResponse/WSSTATELISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedepartamentosResponse as element(ns0:ConsultadedepartamentosResponse) external;

xf:consultaDepartamentosHeaderOut($consultadedepartamentosResponse)