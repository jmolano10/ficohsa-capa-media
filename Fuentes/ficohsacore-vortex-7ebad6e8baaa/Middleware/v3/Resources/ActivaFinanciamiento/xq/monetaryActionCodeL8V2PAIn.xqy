xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$activaFinanciamiento1" element="ns0:activaFinanciamiento" location="../xsd/activaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:MonetaryActionCodeL8V2Request" location="../../../../v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/activaFinanciamientoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ActivaFinanciamiento/xq/monetaryActionCodeL8V2PAIn/";

declare function xf:monetaryActionCodeL8V2PAIn($activaFinanciamiento1 as element(ns0:activaFinanciamiento),
    $asm-user as xs:string)
    as element(ns1:MonetaryActionCodeL8V2Request) {
        <ns1:MonetaryActionCodeL8V2Request>
            <AZXMAI-ASM-ORG>{ data($activaFinanciamiento1/ASM_ORG) }</AZXMAI-ASM-ORG>
            <AZXMAI-ASM-REP>{ $asm-user }</AZXMAI-ASM-REP>
            <AZXMAI-FOREIGN-USE-IND>{ data($activaFinanciamiento1/CURRENCY_INDICATOR) }</AZXMAI-FOREIGN-USE-IND>
            <AZXMAI-ACCT-ORG>{ data($activaFinanciamiento1/ORG) }</AZXMAI-ACCT-ORG>
            <AZXMAI-ACCT-NBR>{ data($activaFinanciamiento1/ACCOUNT_NUMBER) }</AZXMAI-ACCT-NBR>
            <AZXMAI-ACTION-CODE>{ data($activaFinanciamiento1/TRANSACTION_CODE) }</AZXMAI-ACTION-CODE>
            <AZXMAI-EFF-DATE>{ fn:adjust-date-to-timezone(current-date(),()) }</AZXMAI-EFF-DATE>
            <AZXMAI-TXN-AMOUNT>{ data($activaFinanciamiento1/PRINCIPAL_AMOUNT) }</AZXMAI-TXN-AMOUNT>
            <AZXMAI-PLAN-NBR>{ data($activaFinanciamiento1/PLAN_NUMBER) }</AZXMAI-PLAN-NBR>
            <AZXMAI-PLAN-SEQ>{ data($activaFinanciamiento1/PLAN_SECUENCE) }</AZXMAI-PLAN-SEQ>
            <AZXMAI-DEPT-CODE>2</AZXMAI-DEPT-CODE>
            <AZXMAI-AUTH-CODE>0</AZXMAI-AUTH-CODE>
            <AZXMAI-STORE-NBR>999999998</AZXMAI-STORE-NBR>
            <AZXMAI-SKU-NBR>0</AZXMAI-SKU-NBR>
            <AZXMAI-SALES-CLERK>0</AZXMAI-SALES-CLERK>
            <AZXMAI-TICKET-NBR>0</AZXMAI-TICKET-NBR>
            <AZXMAI-PURCHASE-ORDER-NBR>0</AZXMAI-PURCHASE-ORDER-NBR>
            <AZXMAI-ACTION-CODE-PRI>0</AZXMAI-ACTION-CODE-PRI>
            <AZXMAI-INST-NBR>0</AZXMAI-INST-NBR>
            <AZXMAI-DESC>{ data($activaFinanciamiento1/DESCRIPTION) }</AZXMAI-DESC>
            { let $refNumber := data($activaFinanciamiento1/REF_NUMBER) 
                  return 
                  if($refNumber != '')then(
                        <AZXMAI-REF-NUM>{$refNumber}</AZXMAI-REF-NUM>
                  )else
                        (<AZXMAI-REF-NUM>0</AZXMAI-REF-NUM>)         
            }
            <AZXMAI-OTB-UPDATE-IND>{ data($activaFinanciamiento1/OTB_INDICATOR) }</AZXMAI-OTB-UPDATE-IND>
        </ns1:MonetaryActionCodeL8V2Request>
};

declare variable $activaFinanciamiento1 as element(ns0:activaFinanciamiento) external;
declare variable $asm-user as xs:string external;

xf:monetaryActionCodeL8V2PAIn($activaFinanciamiento1,
    $asm-user)