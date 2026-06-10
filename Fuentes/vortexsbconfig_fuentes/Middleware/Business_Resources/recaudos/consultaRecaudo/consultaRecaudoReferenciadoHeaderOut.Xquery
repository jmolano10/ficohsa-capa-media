<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderecaudoreferenciadoefec_ValidateResponse" element="ns0:Pagoderecaudoreferenciadoefec_ValidateResponse" location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoReferenciadoHeaderOut/";

declare function xf:consultaRecaudoReferenciadoHeaderOut($pagoderecaudoreferenciadoefec_ValidateResponse as element(ns0:Pagoderecaudoreferenciadoefec_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $pagoderecaudoreferenciadoefec_ValidateResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoderecaudoreferenciadoefec_ValidateResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderecaudoreferenciadoefec_ValidateResponse as element(ns0:Pagoderecaudoreferenciadoefec_ValidateResponse) external;

xf:consultaRecaudoReferenciadoHeaderOut($pagoderecaudoreferenciadoefec_ValidateResponse)]]></con:xquery>
    <con:dependency location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoRecaudos/Resources/XMLSchema_-258408779"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>