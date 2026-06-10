<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoderemesaconcredacuentaResponse" element="ns0:PagoderemesaconcredacuentaResponse" location="../Resoruces/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/PagoRemesaCreditoCuenta/pagoRemesaCreditoCuentaHeaderOut/";

declare function xf:pagoRemesaCreditoCuentaHeaderOut($pagoderemesaconcredacuentaResponse as element(ns0:PagoderemesaconcredacuentaResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $pagoderemesaconcredacuentaResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoderemesaconcredacuentaResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoderemesaconcredacuentaResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $DEBITVALUEDATE in $pagoderemesaconcredacuentaResponse/FUNDSTRANSFERType/DEBITVALUEDATE
                return
                    <valueDate>{ data($DEBITVALUEDATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderemesaconcredacuentaResponse as element(ns0:PagoderemesaconcredacuentaResponse) external;

xf:pagoRemesaCreditoCuentaHeaderOut($pagoderemesaconcredacuentaResponse)]]></con:xquery>
    <con:dependency location="../Resoruces/XMLSchema_-1855765488.xsd">
        <con:schema ref="Middleware/Business_Resources/remesas/Resoruces/XMLSchema_-1855765488"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/Business_Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>