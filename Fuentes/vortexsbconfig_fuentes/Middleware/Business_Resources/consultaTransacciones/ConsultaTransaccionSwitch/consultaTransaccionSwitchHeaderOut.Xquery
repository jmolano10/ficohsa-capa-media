<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetransaccionswitchResponse" element="ns0:ConsultadetransaccionswitchResponse" location="../Resources/XMLSchema_-1217682313.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchHeaderOut/";

declare function xf:consultaTransaccionSwitchHeaderOut($consultadetransaccionswitchResponse as element(ns0:ConsultadetransaccionswitchResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
            	if (empty($consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/ZERORECORDS/text())) then (
            		<successIndicator>{ data($consultadetransaccionswitchResponse/Status/successIndicator) }</successIndicator>,
            		<messages>{ data($consultadetransaccionswitchResponse/Status/messages) }</messages>
            	) else (
            		<successIndicator>NO RECORDS</successIndicator>,
            		<messages>{ data($consultadetransaccionswitchResponse/WSSWITCHTRANSACTIONType[1]/ZERORECORDS) }</messages>
            	)
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetransaccionswitchResponse as element(ns0:ConsultadetransaccionswitchResponse) external;

xf:consultaTransaccionSwitchHeaderOut($consultadetransaccionswitchResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-1217682313.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>