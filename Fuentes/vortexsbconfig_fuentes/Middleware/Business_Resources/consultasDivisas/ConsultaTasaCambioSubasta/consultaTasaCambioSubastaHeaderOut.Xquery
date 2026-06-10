<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetasadecambiosubastaResponse" element="ns0:ConsultadetasadecambiosubastaResponse" location="../Resources/XMLSchema_-1176801753.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasDivisas/ConsultaTasaCambioSubasta/consultaTasaCambioSubastaHeaderOut/";

declare function xf:consultaTasaCambioSubastaHeaderOut($consultadetasadecambiosubastaResponse as element(ns0:ConsultadetasadecambiosubastaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetasadecambiosubastaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetasadecambiosubastaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetasadecambiosubastaResponse as element(ns0:ConsultadetasadecambiosubastaResponse) external;

xf:consultaTasaCambioSubastaHeaderOut($consultadetasadecambiosubastaResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-1176801753.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasDivisas/Resources/XMLSchema_-1176801753"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>