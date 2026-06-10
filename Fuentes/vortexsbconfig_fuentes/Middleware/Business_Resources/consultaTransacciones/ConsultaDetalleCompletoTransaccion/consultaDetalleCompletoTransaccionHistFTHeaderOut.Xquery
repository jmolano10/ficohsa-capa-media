<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionhistFTResponse" element="ns0:ConsultadetransaccionhistFTResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionHistFTHeaderOut/";

declare function xf:consultaDetalleCompletoTransaccionHistFTHeaderOut($consultadetransaccionhistFTResponse as element(ns0:ConsultadetransaccionhistFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadetransaccionhistFTResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadetransaccionhistFTResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadetransaccionhistFTResponse/WSFTTRANSACTIONHISTType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>        
};

declare variable $consultadetransaccionhistFTResponse as element(ns0:ConsultadetransaccionhistFTResponse) external;

xf:consultaDetalleCompletoTransaccionHistFTHeaderOut($consultadetransaccionhistFTResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-1217682313.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>