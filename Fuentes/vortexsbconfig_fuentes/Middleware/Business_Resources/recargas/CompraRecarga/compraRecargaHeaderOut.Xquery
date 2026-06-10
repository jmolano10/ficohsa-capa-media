<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$compraderecargacondbctaResponse" element="ns0:CompraderecargacondbctaResponse" location="../Resources/XMLSchema_-1499734640.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recargas/CompraRecarga/compraRecargaHeaderOut/";

declare function xf:compraRecargaHeaderOut($compraderecargacondbctaResponse as element(ns0:CompraderecargacondbctaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $compraderecargacondbctaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $compraderecargacondbctaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $compraderecargacondbctaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $compraderecargacondbctaResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $compraderecargacondbctaResponse as element(ns0:CompraderecargacondbctaResponse) external;

xf:compraRecargaHeaderOut($compraderecargacondbctaResponse)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_-1499734640.xsd">
        <con:schema ref="Middleware/Business_Resources/recargas/Resources/XMLSchema_-1499734640"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>