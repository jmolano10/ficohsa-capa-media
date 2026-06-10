<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaOficialesNegocioResponse" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOficialesNegocio";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioHNHeaderOut/";

declare function xf:consultaOficialesNegocioHNHeaderOut($consultaOficialesNegocioResponse as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
            	let $errorCode := $consultaOficialesNegocioResponse/ns1:P_SUCCESSINDICATOR/text()
            	let $validationMessage := $consultaOficialesNegocioResponse/ns1:P_MESSAGES/text()
            	return
	            	if ($errorCode != 'SUCCESS') then (
						<successIndicator>{ $errorCode }</successIndicator>,
						<messages>{ $validationMessage }</messages>
					)else(
						<successIndicator>Success</successIndicator>
					)                    
            }
        </ns0:ResponseHeader>
};

declare variable $consultaOficialesNegocioResponse as element(ns1:OutputParameters) external;

xf:consultaOficialesNegocioHNHeaderOut($consultaOficialesNegocioResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABK/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>