<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:GetPushReceipt" location="../../../BusinessServices/MovilGetPushReceipt/xsd/GetPushReceipt.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilGetPushReceipt";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/GetPushReceiptTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilGetPushReceipt/xq/GetPushReceiptIn/";

declare function xf:GetPushReceiptIn($outputParameters as element(ns1:OutputParameters))
    as element(ns0:GetPushReceipt) {
        <ns0:GetPushReceipt>
            <REQUEST_ID>{ data($outputParameters/ns1:PV_REQUESTID) }</REQUEST_ID>
            <INSTITUTION_CODE>{ data($outputParameters/ns1:PV_INSTITUTIONCODE) }</INSTITUTION_CODE>
            <ENCRYPTED_CARD_INFO>
                <ALGORITHM>{ data($outputParameters/ns1:PT_ENCRYPTEDCARDINFO/ns1:ALGORITHM) }</ALGORITHM>
                {
                    for $NONCE in $outputParameters/ns1:PT_ENCRYPTEDCARDINFO/ns1:NONCE
                    return
                        <NONCE>{ data($NONCE) }</NONCE>
                }
                {
                    for $IV in $outputParameters/ns1:PT_ENCRYPTEDCARDINFO/ns1:IV
                    return
                        <IV>{ data($IV) }</IV>
                }
                <ENCRYPTED_DATA>{ data($outputParameters/ns1:PT_ENCRYPTEDCARDINFO/ns1:ENCRYPTEDDATA) }</ENCRYPTED_DATA>
                {
                    for $ASSOCIATEDDATA in $outputParameters/ns1:PT_ENCRYPTEDCARDINFO/ns1:ASSOCIATEDDATA
                    return
                        <ASSOCIATED_DATA>{ data($ASSOCIATEDDATA) }</ASSOCIATED_DATA>
                }
                <MAC_LENGTH>{ data($outputParameters/ns1:PT_ENCRYPTEDCARDINFO/ns1:MACLENGTH) }</MAC_LENGTH>
            </ENCRYPTED_CARD_INFO>
        </ns0:GetPushReceipt>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:GetPushReceiptIn($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilGetPushReceipt/xsd/movilGetPushReceipt_sp"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MovilGetPushReceipt/xsd/GetPushReceipt.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilGetPushReceipt/xsd/GetPushReceipt"/>
    </con:dependency>
</con:xqueryEntry>