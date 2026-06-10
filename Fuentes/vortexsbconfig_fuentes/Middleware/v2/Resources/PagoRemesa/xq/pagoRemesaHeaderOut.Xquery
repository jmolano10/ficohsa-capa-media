<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderemesaFTResponse1" element="ns0:PagoderemesaFTResponse" location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRemesa/xq/pagoRemesaHeaderOut/";

declare function xf:pagoRemesaHeaderOut($pagoderemesaFTResponse1 as element(ns0:PagoderemesaFTResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $pagoderemesaFTResponse1/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoderemesaFTResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoderemesaFTResponse1/Status/messages
                return
                    <messages>{ fn:string-join(data($messages),' ') }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderemesaFTResponse1 as element(ns0:PagoderemesaFTResponse) external;

xf:pagoRemesaHeaderOut($pagoderemesaFTResponse1)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/remesas/Resoruces/XMLSchema_-1855765488.xsd">
        <con:schema ref="Middleware/Business_Resources/remesas/Resoruces/XMLSchema_-1855765488"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>