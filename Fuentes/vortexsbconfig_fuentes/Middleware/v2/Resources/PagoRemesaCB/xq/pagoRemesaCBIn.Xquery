<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRemesas" element="ns1:pagoRemesas" location="../xsd/pagoRemesaCB.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagoRemesas" location="../../PagoRemesa/xsd/pagoRemesas.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/ExternalServices/pagoRemesaCB/";

declare function xf:pagoRemesaCB($pagoRemesas as element(ns1:pagoRemesas))
    as element(ns0:pagoRemesas) {
        <ns0:pagoRemesas>
            <REMITTANCE_ID>{ data($pagoRemesas/REMITTANCE_ID) }</REMITTANCE_ID>
            <REMITTER_ID>{ data($pagoRemesas/REMITTER_ID) }</REMITTER_ID>
            <BENEFICIARY_INFO>
                <ID>{ data($pagoRemesas/BENEFICIARY_INFO/ID) }</ID>
                {
                    for $ID_ISSUE_DATE in $pagoRemesas/BENEFICIARY_INFO/ID_ISSUE_DATE
                    return
                        <ID_ISSUE_DATE>{ data($ID_ISSUE_DATE) }</ID_ISSUE_DATE>
                }
                <NAME>{ data($pagoRemesas/BENEFICIARY_INFO/NAME) }</NAME>
                <ID_TYPE>{ data($pagoRemesas/BENEFICIARY_INFO/ID_TYPE) }</ID_TYPE>
                <ADDRESS_TYPE>{ data($pagoRemesas/BENEFICIARY_INFO/ADDRESS_TYPE) }</ADDRESS_TYPE>
                <CITY>{ data($pagoRemesas/BENEFICIARY_INFO/CITY) }</CITY>
                <STATE>{ data($pagoRemesas/BENEFICIARY_INFO/STATE) }</STATE>
                <COUNTRY>{ data($pagoRemesas/BENEFICIARY_INFO/COUNTRY) }</COUNTRY>
                <NEIGHBORHOOD>{ data($pagoRemesas/BENEFICIARY_INFO/NEIGHBORHOOD) }</NEIGHBORHOOD>
                <PHONE_TYPE>{ data($pagoRemesas/BENEFICIARY_INFO/PHONE_TYPE) }</PHONE_TYPE>
                <PHONE_NUMBER>{ data($pagoRemesas/BENEFICIARY_INFO/PHONE_NUMBER) }</PHONE_NUMBER>
                {
                    for $OCCUPATION in $pagoRemesas/BENEFICIARY_INFO/OCCUPATION
                    return
                        <OCCUPATION>{ data($OCCUPATION) }</OCCUPATION>
                }
                {
                    for $INCOME_SOURCE in $pagoRemesas/BENEFICIARY_INFO/INCOME_SOURCE
                    return
                        <INCOME_SOURCE>{ data($INCOME_SOURCE) }</INCOME_SOURCE>
                }
                {
                    for $DATE_OF_BIRTH in $pagoRemesas/BENEFICIARY_INFO/DATE_OF_BIRTH
                    return
                        <DATE_OF_BIRTH>{ data($DATE_OF_BIRTH) }</DATE_OF_BIRTH>
                }
                <ADDRESS>{ data($pagoRemesas/BENEFICIARY_INFO/ADDRESS) }</ADDRESS>
                <REMITTANCE_BENEFICIARY>{ data($pagoRemesas/BENEFICIARY_INFO/REMITTANCE_BENEFICIARY) }</REMITTANCE_BENEFICIARY>
                <THIRDPARTY_INFO>
                    <ID>{ data($pagoRemesas/BENEFICIARY_INFO/THIRDPARTY_INFO/ID) }</ID>
                    <NAME>{ data($pagoRemesas/BENEFICIARY_INFO/THIRDPARTY_INFO/NAME) }</NAME>
                    <RELATIONSHIP>{ data($pagoRemesas/BENEFICIARY_INFO/THIRDPARTY_INFO/RELATIONSHIP) }</RELATIONSHIP>
                </THIRDPARTY_INFO>
                <GENDER>{ data($pagoRemesas/BENEFICIARY_INFO/GENDER) }</GENDER>
            </BENEFICIARY_INFO>
            <CREDIT_ACCOUNT>{ data($pagoRemesas/CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
            <BRANCHCODE>{ data($pagoRemesas/BRANCHCODE) }</BRANCHCODE>
            <TELLERID>{ data($pagoRemesas/TELLERID) }</TELLERID>
            <REFERENCE_NUMBER>{ data($pagoRemesas/REFERENCE_NUMBER) }</REFERENCE_NUMBER>
            <ADDITIONAL_INFO>
                {
                    for $info in $pagoRemesas/ADDITIONAL_INFO/INFO
                    return
                        <INFO>
                            <NAME>{ data($info/NAME) }</NAME>
                            <VALUE>{ data($info/VALUE) }</VALUE>
                        </INFO>
                }
            </ADDITIONAL_INFO>
            {
                for $RECEIVER_RELATION_SHIP_TO_SEN in $pagoRemesas/RECEIVER_RELATION_SHIP_TO_SEN
                return
                    <RECEIVER_RELATION_SHIP_TO_SEN>{ data($RECEIVER_RELATION_SHIP_TO_SEN) }</RECEIVER_RELATION_SHIP_TO_SEN>
            }
            {
                for $RECEIVER_PURPOSE_OF_TRANS in $pagoRemesas/RECEIVER_PURPOSE_OF_TRANS
                return
                    <RECEIVER_PURPOSE_OF_TRANS>{ data($RECEIVER_PURPOSE_OF_TRANS) }</RECEIVER_PURPOSE_OF_TRANS>
            }
            {
                for $RECEIVER_USO_MG in $pagoRemesas/RECEIVER_USO_MG
                return
                    <RECEIVER_USO_MG>{ data($RECEIVER_USO_MG) }</RECEIVER_USO_MG>
            }
            {
                for $RECEIVER_SRC_INCOME in $pagoRemesas/RECEIVER_SRC_INCOME
                return
                    <RECEIVER_SRC_INCOME>{ data($RECEIVER_SRC_INCOME) }</RECEIVER_SRC_INCOME>
            }
            {
                for $RECEIVER_LEGAL_ID_DOC in $pagoRemesas/RECEIVER_LEGAL_ID_DOC
                return
                    <RECEIVER_LEGAL_ID_DOC>{ data($RECEIVER_LEGAL_ID_DOC) }</RECEIVER_LEGAL_ID_DOC>
            }
        </ns0:pagoRemesas>
};

declare variable $pagoRemesas as element(ns1:pagoRemesas) external;

xf:pagoRemesaCB($pagoRemesas)]]></con:xquery>
    <con:dependency location="../xsd/pagoRemesaCB.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRemesaCB/xsd/pagoRemesaCB"/>
    </con:dependency>
    <con:dependency location="../../PagoRemesa/xsd/pagoRemesas.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRemesa/xsd/pagoRemesas"/>
    </con:dependency>
</con:xqueryEntry>