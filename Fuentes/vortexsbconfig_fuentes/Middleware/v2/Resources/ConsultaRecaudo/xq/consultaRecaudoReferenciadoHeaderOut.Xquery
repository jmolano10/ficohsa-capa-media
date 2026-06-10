<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$calculoCobranzasReferenciadasResponseIN" element="ns0:CalculoCobranzasReferenciadasResponse" location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudo/xq/consultaRecaudoReferenciadoHeaderOut/";

declare function xf:consultaRecaudoReferenciadoHeaderOut($calculoCobranzasReferenciadasResponseIN as element(ns0:CalculoCobranzasReferenciadasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $calculoCobranzasReferenciadasResponseIN/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $calculoCobranzasReferenciadasResponseIN/Status/messages
                return
                if ($calculoCobranzasReferenciadasResponseIN/Status/successIndicator/text()!='Success') then(
                    <messages>{ data($messages) }</messages>
                    )else()
            }
        </ns1:ResponseHeader>
};

declare variable $calculoCobranzasReferenciadasResponseIN as element(ns0:CalculoCobranzasReferenciadasResponse) external;

xf:consultaRecaudoReferenciadoHeaderOut($calculoCobranzasReferenciadasResponseIN)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/recaudos/Resources/XMLSchema_-1599652964.xsd">
        <con:schema ref="Middleware/Business_Resources/recaudos/Resources/XMLSchema_-1599652964"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>