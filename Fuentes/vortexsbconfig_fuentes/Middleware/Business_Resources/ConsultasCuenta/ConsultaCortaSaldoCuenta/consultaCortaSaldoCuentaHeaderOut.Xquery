<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultacortadesaldodecuentaResponse" element="ns0:ConsultacortadesaldodecuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCortaSaldoCuenta/consultaCortaSaldoCuentaHeaderOut/";

declare function xf:consultaCortaSaldoCuentaHeaderOut($consultacortadesaldodecuentaResponse as element(ns0:ConsultacortadesaldodecuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
			{
				if (empty($consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/ZERORECORDS/text())) then (
					<successIndicator>{ data($consultacortadesaldodecuentaResponse/Status/successIndicator) }</successIndicator>,
					<messages>{ data($consultacortadesaldodecuentaResponse/Status/messages) }</messages>
				) else (
					<successIndicator>NO RECORDS</successIndicator>,
					<messages>{ data($consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/ZERORECORDS) }</messages>
				)
			}
        </ns1:ResponseHeader>
};

declare variable $consultacortadesaldodecuentaResponse as element(ns0:ConsultacortadesaldodecuentaResponse) external;

xf:consultaCortaSaldoCuentaHeaderOut($consultacortadesaldodecuentaResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>