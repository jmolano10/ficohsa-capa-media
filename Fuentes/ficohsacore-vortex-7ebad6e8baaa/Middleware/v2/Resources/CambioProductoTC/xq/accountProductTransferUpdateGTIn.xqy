xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$cambioProductoTC" element="ns0:cambioProductoTC" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:AccountProductTransferUpdateRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambioProductoTC/xq/accountProductTransferUpdateGTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";

declare function xf:accountProductTransferUpdateGTIn($cambioProductoTC as element(ns0:cambioProductoTC),
    $org as xs:string,
    $ciclo as xs:string)
    as element(ns1:AccountProductTransferUpdateRequest) {
        <ns1:AccountProductTransferUpdateRequest>
            <AZXFXI-OLD-ORG>{ data($org) }</AZXFXI-OLD-ORG>
            <AZXFXI-NEW-ORG>{ data($org) }</AZXFXI-NEW-ORG>
            <AZXFXI-OLD-LOGO>{ data($cambioProductoTC/LOGO_ID) }</AZXFXI-OLD-LOGO>
            <AZXFXI-NEW-LOGO>{ data($cambioProductoTC/NEW_LOGO_ID) }</AZXFXI-NEW-LOGO>
            <AZXFXI-OLD-ACCT>{ data($cambioProductoTC/ACCOUNT) }</AZXFXI-OLD-ACCT>
            <AZXFXI-NEW-ACCT>/</AZXFXI-NEW-ACCT>
            <AZXFXI-CUST-NBR>{ data($cambioProductoTC/CUSTOMER_ID) }</AZXFXI-CUST-NBR>
            <AZXFXI-FUNC>P</AZXFXI-FUNC>
            <AZXFXI-PROCESS-TYPE>{ data($cambioProductoTC/PROCEESS_TYPE) }</AZXFXI-PROCESS-TYPE>
            <AZXFXI-XFR-AUTH-DAYS>10</AZXFXI-XFR-AUTH-DAYS>
            <AZXFXI-BILLING-CYCLE>{ data($ciclo) }</AZXFXI-BILLING-CYCLE>
            <AZXFXI-NEW-CRLIM>{ data($cambioProductoTC/CREDIT_LIMIT) }</AZXFXI-NEW-CRLIM>
            <AZXFXI-NEW-PCT>{ data($cambioProductoTC/SETTLEMENT_ID) }</AZXFXI-NEW-PCT>
            <AZXFXI-NEW-SDP>0</AZXFXI-NEW-SDP>
            <AZXFXI-NEW-CARD-TECH>{ data($cambioProductoTC/CARD_TECHNOLOGY) }</AZXFXI-NEW-CARD-TECH>
            <AZXFXI-XFR-REPLACEMENT-IND>0</AZXFXI-XFR-REPLACEMENT-IND>
            <AZXFXI-XFR-EFF-DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd", data($cambioProductoTC/TRANSACTION_DATE)) }</AZXFXI-XFR-EFF-DATE>
        </ns1:AccountProductTransferUpdateRequest>
};

declare variable $cambioProductoTC as element(ns0:cambioProductoTC) external;
declare variable $org as xs:string external;
declare variable $ciclo as xs:string external;

xf:accountProductTransferUpdateGTIn($cambioProductoTC,
    $org,
    $ciclo)