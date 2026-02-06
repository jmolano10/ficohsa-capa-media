xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$activaFinanciamiento" element="ns1:activaFinanciamiento" location="../xsd/activaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:MonetaryActionCodeRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/activaFinanciamientoTypes";
declare namespace ns0 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActivaFinanciamiento/xq/monetaryActionIn/";

declare function xf:monetaryActionIn($activaFinanciamiento as element(ns1:activaFinanciamiento),$asm-user as xs:string)
    as element(ns0:MonetaryActionCodeRequest) {
        <ns0:MonetaryActionCodeRequest>
            <ASXMAI-ASM-ORG>{ data($activaFinanciamiento/ASM_ORG) }</ASXMAI-ASM-ORG>
            <ASXMAI-ASM-REP>{$asm-user}</ASXMAI-ASM-REP>
            <ASXMAI-FOREIGN-USE-IND>{ data($activaFinanciamiento/CURRENCY_INDICATOR) }</ASXMAI-FOREIGN-USE-IND>
            <ASXMAI-ACCT-ORG>{ data($activaFinanciamiento/ORG) }</ASXMAI-ACCT-ORG>
            <ASXMAI-ACCT-NBR>{ data($activaFinanciamiento/ACCOUNT_NUMBER) }</ASXMAI-ACCT-NBR>
            <ASXMAI-ACTION-CODE>TRAN</ASXMAI-ACTION-CODE>
            <ASXMAI-LINE-DATA-1/>
            <ASXMAI-LINE-DATA-2/>
            <ASXMAI-LINE-DATA-3/>
            <ASXMAI-LINE-DATA-4/>
            <ASXMAI-LINE-DATA-5/>
            <ASXMAI-EFF-DATE>{fn:adjust-date-to-timezone(current-date(),())}</ASXMAI-EFF-DATE>
            <ASXMAI-TXN-AMOUNT>{ data($activaFinanciamiento/PRINCIPAL_AMOUNT) }</ASXMAI-TXN-AMOUNT>
            <ASXMAI-PLAN-NBR>{ data($activaFinanciamiento/PLAN_NUMBER) }</ASXMAI-PLAN-NBR>
            <ASXMAI-PLAN-SEQ>1</ASXMAI-PLAN-SEQ>
            <ASXMAI-DEPT-CODE>0</ASXMAI-DEPT-CODE>
            <ASXMAI-AUTH-CODE>0</ASXMAI-AUTH-CODE>
            <ASXMAI-STORE-NBR>999999998</ASXMAI-STORE-NBR>
            <ASXMAI-SKU-NBR>0</ASXMAI-SKU-NBR>
            <ASXMAI-SALES-CLERK>0</ASXMAI-SALES-CLERK>
            <ASXMAI-TICKET-NBR>0</ASXMAI-TICKET-NBR>
            <ASXMAI-PURCHASE-ORDER-NBR>0</ASXMAI-PURCHASE-ORDER-NBR>
            <ASXMAI-ACTION-CODE-PRI>0</ASXMAI-ACTION-CODE-PRI>
            <ASXMAI-INST-NBR>0</ASXMAI-INST-NBR>
        </ns0:MonetaryActionCodeRequest>
};

declare variable $activaFinanciamiento as element(ns1:activaFinanciamiento) external;
declare variable $asm-user as xs:string external;

xf:monetaryActionIn($activaFinanciamiento,$asm-user)