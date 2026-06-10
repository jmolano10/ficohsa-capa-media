<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadetsobregiroufranticipoResponse" element="ns0:ConsultadetsobregiroufranticipoResponse" location="Resources/XMLSchema_865025152.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaDetallePD/consultaDetallePDHeaderOut/";

declare function xf:consultaDetallePDHeaderOut($consultadetsobregiroufranticipoResponse as element(ns0:ConsultadetsobregiroufranticipoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadetsobregiroufranticipoResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadetsobregiroufranticipoResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadetsobregiroufranticipoResponse as element(ns0:ConsultadetsobregiroufranticipoResponse) external;

xf:consultaDetallePDHeaderOut($consultadetsobregiroufranticipoResponse)]]></con:xquery>
    <con:dependency location="Resources/XMLSchema_865025152.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaDetallePD/Resources/XMLSchema_865025152"/>
    </con:dependency>
    <con:dependency location="../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>