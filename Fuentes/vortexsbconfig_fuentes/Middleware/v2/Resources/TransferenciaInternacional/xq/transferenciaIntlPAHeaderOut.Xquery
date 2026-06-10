<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaInternacional";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/transferenciaInternacionalHeaderOut/";

declare function xf:transferenciaInternacionalHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $TRANSACTION_ID in $outputParameters1/ns0:TRANSACTION_ID
                return
                    <transactionId>{ data($TRANSACTION_ID) }</transactionId>
            }
            {
                for $ERROR_CODE in $outputParameters1/ns0:ERROR_CODE
                return
                    <successIndicator>{ data($ERROR_CODE) }</successIndicator>
            }
            {
                for $ERROR_MESSAGE in $outputParameters1/ns0:ERROR_MESSAGE
                return
                    <messages>{ data($ERROR_MESSAGE) }</messages>
            }
            {
                for $VALUE_DATE in $outputParameters1/ns0:VALUE_DATE
                return
                    <valueDate>{ data($VALUE_DATE) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:transferenciaInternacionalHeaderOut($outputParameters1)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/transferenciaInternacional/xsd/transferenciaInternacional_sp"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>