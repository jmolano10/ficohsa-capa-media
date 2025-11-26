xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionTTResponse" element="ns0:ConsultadetransaccionTTResponse" location="../../xsds/ConsultasTransacciones/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaReciboTransaccionRTE/ConsultaDetalleTransaccionTTHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ConsultaDetalleTransaccionTTHeaderOut($consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadetransaccionTTResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadetransaccionTTResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadetransaccionTTResponse/WSTTTRANSACTIONType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionTTResponse as element(ns0:ConsultadetransaccionTTResponse) external;

xf:ConsultaDetalleTransaccionTTHeaderOut($consultadetransaccionTTResponse)