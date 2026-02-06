xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$gestionTCAumentoReduccionLC" element="ns0:gestionTCAumentoReduccionLC" location="../xsd/gestionTCAumentoReduccionLCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:CardSpendingLimitsUpdateRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionTCAumentoReduccionLCTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionTCAumentoReduccionLC/xq/prueba/";

declare function xf:prueba($org as xs:string,
    $cardSequence as xs:string,
    $foreignUse as xs:string,
    $gestionTCAumentoReduccionLC as element(ns0:gestionTCAumentoReduccionLC))
    as element(ns1:CardSpendingLimitsUpdateRequest) {
        <ns1:CardSpendingLimitsUpdateRequest>
            <AZXUSI-ORG>{ data($org) }</AZXUSI-ORG>
            <AZXUSI-CARD-NBR>{ data($gestionTCAumentoReduccionLC/CARD_NUMBER) }</AZXUSI-CARD-NBR>
            <AZXUSI-CARD-SEQ>{ data($cardSequence) }</AZXUSI-CARD-SEQ>
            <AZXUSI-FOREIGN-USE>{ data($foreignUse) }</AZXUSI-FOREIGN-USE>
            <AZXUSI-FREQ>0</AZXUSI-FREQ>
            <AZXUSI-LOGO-THRESH-IND>0</AZXUSI-LOGO-THRESH-IND>
            <AZXUSI-AUTH-ATM-CASH-NBR>0</AZXUSI-AUTH-ATM-CASH-NBR>
            <AZXUSI-AUTH-ATM-CASH-AMT>0</AZXUSI-AUTH-ATM-CASH-AMT>
            <AZXUSI-AUTH-ATM-CASH-SNGL-TX>0</AZXUSI-AUTH-ATM-CASH-SNGL-TX>
            <AZXUSI-AUTH-OTC-CASH-NBR>0</AZXUSI-AUTH-OTC-CASH-NBR>
            <AZXUSI-AUTH-OTC-CASH-AMT>0</AZXUSI-AUTH-OTC-CASH-AMT>
            <AZXUSI-AUTH-OTC-CASH-SNGL-TX>0</AZXUSI-AUTH-OTC-CASH-SNGL-TX>
            <AZXUSI-AUTH-RTL-PURCH-NBR>0</AZXUSI-AUTH-RTL-PURCH-NBR>
            <AZXUSI-AUTH-RTL-PURCH-AMT>0</AZXUSI-AUTH-RTL-PURCH-AMT>
            <AZXUSI-AUTH-RTL-PURCH-SNGLTX>0</AZXUSI-AUTH-RTL-PURCH-SNGLTX>
            <AZXUSI-AUTH-IE-PURCH-NBR>0</AZXUSI-AUTH-IE-PURCH-NBR>
            <AZXUSI-AUTH-IE-PURCH-AMT>0</AZXUSI-AUTH-IE-PURCH-AMT>
            <AZXUSI-AUTH-IE-PURCH-SNGLTX>0</AZXUSI-AUTH-IE-PURCH-SNGLTX>
            <AZXUSI-AUTH-INTL-PURCHSNGL-TX>0</AZXUSI-AUTH-INTL-PURCHSNGL-TX>
            <AZXUSI-SPEND-LIMITS-STATUS>{ data($gestionTCAumentoReduccionLC/TYPE_PERCENTUALIZATION) }</AZXUSI-SPEND-LIMITS-STATUS>
            <AZXUSI-RETAIL-PERCENT-DAILY>0</AZXUSI-RETAIL-PERCENT-DAILY>
            <AZXUSI-RETAIL-PERCENT-MTD>{ data($gestionTCAumentoReduccionLC/PERCENTAGE_MONTHLY_PURCHASE) }</AZXUSI-RETAIL-PERCENT-MTD>
            <AZXUSI-RETAIL-PERCENT-YTD>0</AZXUSI-RETAIL-PERCENT-YTD>
            <AZXUSI-RETAIL-AMOUNT-DAILY>0</AZXUSI-RETAIL-AMOUNT-DAILY>
            <AZXUSI-RETAIL-AMOUNT-MTD>{ data($gestionTCAumentoReduccionLC/MONTHLY_PURCHASE_AMOUNT) }</AZXUSI-RETAIL-AMOUNT-MTD>
            <AZXUSI-RETAIL-AMOUNT-YTD>0</AZXUSI-RETAIL-AMOUNT-YTD>
            <AZXUSI-CASH-PERCENT-DAILY>0</AZXUSI-CASH-PERCENT-DAILY>
            <AZXUSI-CASH-PERCENT-MTD>{ data($gestionTCAumentoReduccionLC/PERCENTAGE_OF_MONTHLY_RETIREMENT) }</AZXUSI-CASH-PERCENT-MTD>
            <AZXUSI-CASH-PERCENT-YTD>0</AZXUSI-CASH-PERCENT-YTD>
            <AZXUSI-CASH-AMOUNT-DAILY>0</AZXUSI-CASH-AMOUNT-DAILY>
            <AZXUSI-CASH-AMOUNT-MTD>{ data($gestionTCAumentoReduccionLC/MONTHLY_RETIREMENT_AMOUNT) }</AZXUSI-CASH-AMOUNT-MTD>
            <AZXUSI-CASH-AMOUNT-YTD>0</AZXUSI-CASH-AMOUNT-YTD>
        </ns1:CardSpendingLimitsUpdateRequest>
};

declare variable $org as xs:string external;
declare variable $cardSequence as xs:string external;
declare variable $foreignUse as xs:string external;
declare variable $gestionTCAumentoReduccionLC as element(ns0:gestionTCAumentoReduccionLC) external;

xf:prueba($org,
    $cardSequence,
    $foreignUse,
    $gestionTCAumentoReduccionLC)