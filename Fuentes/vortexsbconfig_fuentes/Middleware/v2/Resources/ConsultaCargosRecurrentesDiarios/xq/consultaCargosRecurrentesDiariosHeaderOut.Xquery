<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$queryCardTransactionResponse" element="ns1:QueryCardTransactionResponse" location="../../../BusinessServices/VisaNet/wsdl/WSVisaTransaction.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/xq/consultaCargosRecurrentesDiariosHeaderOut/";

declare function xf:consultaCargosRecurrentesDiariosHeaderOut($queryCardTransactionResponse as element(ns1:QueryCardTransactionResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
               let $strQueryCode :=  $queryCardTransactionResponse/ns1:QueryCardTransactionResult/ns1:strQueryCode/text()
                return
                	if($strQueryCode = '000') then (
                		<successIndicator>{'Success'}</successIndicator>
                	)
                	
                	else (
                		<successIndicator>{fn:concat("VisaNet-", $strQueryCode)}</successIndicator>
                	)
             
            }
            {
                for $strQueryMessage in $queryCardTransactionResponse/ns1:QueryCardTransactionResult/ns1:strQueryMessage
                return
                    <messages>{ data($strQueryMessage) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $queryCardTransactionResponse as element(ns1:QueryCardTransactionResponse) external;

xf:consultaCargosRecurrentesDiariosHeaderOut($queryCardTransactionResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/VisaNet/wsdl/WSVisaTransaction.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/VisaNet/wsdl/WSVisaTransaction"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>