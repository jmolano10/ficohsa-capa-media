<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$movilDecryptInfo" element="ns1:movilDecryptInfo" location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MovilDecryptInfo/xsd/movilDecryptInfo_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/movilDigitizationCardsTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/movilDecryptInfo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MovilDecryptInfo/xq/movilDecryptInfoIn/";

declare function xf:movilDecryptInfoIn($movilDecryptInfo as element(ns1:movilDecryptInfo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $WALLET_REQUEST in $movilDecryptInfo/WALLET_REQUEST
                return
                    <ns0:PV_WALLETREQUESTOR>{ data($WALLET_REQUEST) }</ns0:PV_WALLETREQUESTOR>
            }
            <ns0:PV_ENCRYPTEDPAYLOAD>{ data($movilDecryptInfo/ENCRYPTED_PAYLOAD) }</ns0:PV_ENCRYPTEDPAYLOAD>
        </ns0:InputParameters>
};

declare variable $movilDecryptInfo as element(ns1:movilDecryptInfo) external;

xf:movilDecryptInfoIn($movilDecryptInfo)]]></con:xquery>
    <con:dependency location="../../MovilDigitizationCards/xsd/movilDigitizationCardsTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/MovilDigitizationCards/xsd/movilDigitizationCardsTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/MovilDecryptInfo/xsd/movilDecryptInfo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/MovilDecryptInfo/xsd/movilDecryptInfo_sp"/>
    </con:dependency>
</con:xqueryEntry>