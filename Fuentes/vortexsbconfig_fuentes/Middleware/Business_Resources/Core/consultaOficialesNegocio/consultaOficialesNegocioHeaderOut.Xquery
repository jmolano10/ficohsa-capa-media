<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDAOResponse" element="ns0:ConsultaDAOResponse" location="../Resources/XMLSchema_1632682327.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioHeaderOut/";

declare function xf:consultaOficialesNegocioHeaderOut($consultaDAOResponse as element(ns0:ConsultaDAOResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultaDAOResponse/WSADMINDEPTACCTOFFICERType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultaDAOResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultaDAOResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultaDAOResponse/WSADMINDEPTACCTOFFICERType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultaDAOResponse as element(ns0:ConsultaDAOResponse) external;

xf:consultaOficialesNegocioHeaderOut($consultaDAOResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_1632682327.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/Resources/XMLSchema_1632682327"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>