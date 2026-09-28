(:: pragma bea:global-element-parameter parameter="$cambioProductoTC1" element="ns1:cambioProductoTC" location="../../GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:AccountProductTransferUpdateRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesTarjetasTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CambioProductoTC/xq/accountProductTransferUpdateIn/";

declare function xf:accountProductTransferUpdateIn($cambioProductoTC1 as element(ns1:cambioProductoTC),
    $org as xs:string,
    $ciclo as xs:string)
    as element(ns0:AccountProductTransferUpdateRequest) {
        <ns0:AccountProductTransferUpdateRequest>
            <AZXFXI-OLD-ORG>{ data($org) }</AZXFXI-OLD-ORG>
            <AZXFXI-NEW-ORG>{ data($org) }</AZXFXI-NEW-ORG>
            <AZXFXI-OLD-LOGO>{ data($cambioProductoTC1/LOGO_ID) }</AZXFXI-OLD-LOGO>
            <AZXFXI-NEW-LOGO>{ data($cambioProductoTC1/NEW_LOGO_ID) }</AZXFXI-NEW-LOGO>
            <AZXFXI-OLD-ACCT>{ data($cambioProductoTC1/ACCOUNT) }</AZXFXI-OLD-ACCT>
            <AZXFXI-NEW-ACCT>/</AZXFXI-NEW-ACCT>
            <AZXFXI-CUST-NBR>{ data($cambioProductoTC1/CUSTOMER_ID) }</AZXFXI-CUST-NBR>
            <AZXFXI-FUNC>P</AZXFXI-FUNC>
            <AZXFXI-PROCESS-TYPE>{ data($cambioProductoTC1/PROCEESS_TYPE) }</AZXFXI-PROCESS-TYPE>
            <AZXFXI-XFR-AUTH-DAYS>10</AZXFXI-XFR-AUTH-DAYS>
            <AZXFXI-BILLING-CYCLE>{ data($ciclo) }</AZXFXI-BILLING-CYCLE>
            <AZXFXI-NEW-CRLIM>{ data($cambioProductoTC1/CREDIT_LIMIT) }</AZXFXI-NEW-CRLIM>
            <AZXFXI-NEW-PCT>{ data($cambioProductoTC1/SETTLEMENT_ID) }</AZXFXI-NEW-PCT>
            <AZXFXI-NEW-SDP>0</AZXFXI-NEW-SDP>
            <AZXFXI-NEW-CARD-TECH>1</AZXFXI-NEW-CARD-TECH>
            <AZXFXI-XFR-REPLACEMENT-IND>0</AZXFXI-XFR-REPLACEMENT-IND>
            <AZXFXI-XFR-EFF-DATE>{ fn-bea:date-from-string-with-format("yyyyMMdd", data($cambioProductoTC1/TRANSACTION_DATE)) }</AZXFXI-XFR-EFF-DATE>
        </ns0:AccountProductTransferUpdateRequest>
};

declare variable $cambioProductoTC1 as element(ns1:cambioProductoTC) external;
declare variable $org as xs:string external;
declare variable $ciclo as xs:string external;

xf:accountProductTransferUpdateIn($cambioProductoTC1,
    $org,
    $ciclo)