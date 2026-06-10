<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaRemesadorasNIResponse" element="ns1:sjConsultaRemesadorasNIResponse" location="../../../BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadorasNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesasNIOut/";

declare function xf:consultaRemesasNIOut($sjConsultaRemesadorasNIResponse as element(ns1:sjConsultaMultipleRemesadorasNIResponse))
    as element(ns0:consultaRemesasResponse) {
        <ns0:consultaRemesasResponse>
            <ns0:consultaRemesasResponseType>
                <ns0:consultaRemesasResponseRecordType>
                    {
                        for $REMITTANCE_ID in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_ID
                        return
                            <REMITTANCE_ID>{ data($REMITTANCE_ID) }</REMITTANCE_ID>
                    }
                    <REMITTER_ID>{ data($sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:AGREEMENT_ID) }</REMITTER_ID>
                    {
                        for $REMITTER_NAME in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTER_NAME
                        return
                            <REMITTER_NAME>{ data($REMITTER_NAME) }</REMITTER_NAME>
                    }
                    {
                        for $BENEFICIARY_NAME in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:BENEFICIARY_NAME
                        return
                            <BENEFICIARY_NAME>{ data($BENEFICIARY_NAME) }</BENEFICIARY_NAME>
                    }
                    {
                        for $BRANCH_NAME in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:BRANCH_NAME
                        return
                            <BRANCH_NAME>{ data($BRANCH_NAME) }</BRANCH_NAME>
                    }
                    {
                        for $PAYMENT_DATE in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:PAYMENT_DATE
                        return
                            <PAYMENT_DATE>{ data($PAYMENT_DATE) }</PAYMENT_DATE>
                    }
                    {
                        for $CURRENCY in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                    {
                        for $EXCHANGE_RATE in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:EXCHANGE_RATE
                        return
                            <EXCHANGE_RATE>{ data($EXCHANGE_RATE) }</EXCHANGE_RATE>
                    }
                    {
                        for $REMITTANCE_STATUS in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_STATUS
                        return
                            <REMITTANCE_STATUS>{ data($REMITTANCE_STATUS) }</REMITTANCE_STATUS>
                    }
                    {
                        for $REMITTANCE_AMOUNT in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_AMOUNT
                        return
                            <REMITTANCE_AMOUNT>{ data($REMITTANCE_AMOUNT) }</REMITTANCE_AMOUNT>
                    }
                    {
                        for $REMITTANCE_SOURCE_AMOUNT in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:REMITTANCE_SOURCE_AMOUNT
                        return
                            <REMITTANCE_SOURCE_AMOUNT>{ data($REMITTANCE_SOURCE_AMOUNT) }</REMITTANCE_SOURCE_AMOUNT>
                    }
                    {
                        for $ORIGIN_COUNTRY in $sjConsultaRemesadorasNIResponse/ns1:REMITTANCE/ns1:ROUTER_RESPONSE/ns1:ORIGIN_COUNTRY
                        return
                            <ORIGIN_COUNTRY>{ data($ORIGIN_COUNTRY) }</ORIGIN_COUNTRY>
                    }
                </ns0:consultaRemesasResponseRecordType>
            </ns0:consultaRemesasResponseType>
        </ns0:consultaRemesasResponse>
};

declare variable $sjConsultaRemesadorasNIResponse as element(ns1:sjConsultaMultipleRemesadorasNIResponse) external;

xf:consultaRemesasNIOut($sjConsultaRemesadorasNIResponse)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadorasNI/xsd/sjConsultaMultipleRemesadorasNI"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaRemesasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaRemesas/xsd/consultaRemesasTypes"/>
    </con:dependency>
</con:xqueryEntry>