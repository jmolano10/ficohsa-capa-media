<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoBancaSatRequest" element="ns0:pagoBancaSatRequest" location="../xsd/pagoBancaSatTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../v2/BusinessServices/MasterDataGT/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoBancaSatTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/PagoBancaSat/xq/osbConOrgSequenceIn/";

declare function xf:osbConOrgSequenceIn($pagoBancaSatRequest as element(ns0:pagoBancaSatRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $CURRENCY in $pagoBancaSatRequest/BILL_INFORMATION/CURRENCY
                return
                    <ns1:CURRENCY>{ data($CURRENCY) }</ns1:CURRENCY>
            }
            {
                for $CREDIT_CARD in $pagoBancaSatRequest/CREDIT_CARD_PAYMENT_INFO/CREDIT_CARD
                return
                    <ns1:CREDIT_CARD>{ data($CREDIT_CARD) }</ns1:CREDIT_CARD>
            }
        </ns1:InputParameters>
};

declare variable $pagoBancaSatRequest as element(ns0:pagoBancaSatRequest) external;

xf:osbConOrgSequenceIn($pagoBancaSatRequest)]]></con:xquery>
    <con:dependency location="../xsd/pagoBancaSatTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/PagoBancaSat/xsd/pagoBancaSatTypes"/>
    </con:dependency>
    <con:dependency location="../../../v2/BusinessServices/MasterDataGT/conOrgSequence/xsd/osbConOrgSequence_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MasterDataGT/conOrgSequence/xsd/osbConOrgSequence_sp"/>
    </con:dependency>
</con:xqueryEntry>