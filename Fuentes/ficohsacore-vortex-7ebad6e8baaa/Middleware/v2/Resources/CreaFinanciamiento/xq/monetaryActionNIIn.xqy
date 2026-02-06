xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creaFinanciamiento" element="ns0:creaFinanciamiento" location="../xsd/creaFinanciamientoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:MonetaryActionCodeRequest" location="../../../BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/creaFinanciamientoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaFinanciamiento/xq/monetaryActionNIIn/";

declare function xf:monetaryActionNIIn($creaFinanciamiento as element(ns0:creaFinanciamiento),
    $representante as xs:string, $canal as xs:string)
    as element(ns1:MonetaryActionCodeRequest) {
        <ns1:MonetaryActionCodeRequest>
            <ASXMAI-CONTEXT>{ fn:string('') }</ASXMAI-CONTEXT>
            <ASXMAI-SIGNON-NAME>{ fn:string('') }</ASXMAI-SIGNON-NAME>
            <ASXMAI-ASM-ORG>{ data($creaFinanciamiento/ASM_ORG) }</ASXMAI-ASM-ORG>
            <ASXMAI-ASM-REP>{ $representante }</ASXMAI-ASM-REP>
            <ASXMAI-FOREIGN-USE-IND>{ data($creaFinanciamiento/CURRENCY_INDICATOR) }</ASXMAI-FOREIGN-USE-IND>
            <ASXMAI-ACCT-ORG>{ data($creaFinanciamiento/ORG) }</ASXMAI-ACCT-ORG>
            <ASXMAI-ACCT-NBR>{ data($creaFinanciamiento/ACCOUNT_NUMBER) }</ASXMAI-ACCT-NBR>
            <ASXMAI-ACTION-CODE>
            	{
            		let $canal-str := fn:upper-case(fn:string($canal))
            		return
            			if(fn:contains($canal-str, 'ICB')) then
            				'TRNI'
            			else
            				'TRAN'
            	}
            </ASXMAI-ACTION-CODE>
            <ASXMAI-LINE-DATA-1>{ fn:string('') }</ASXMAI-LINE-DATA-1>
            <ASXMAI-LINE-DATA-2>{ fn:string('') }</ASXMAI-LINE-DATA-2>
            <ASXMAI-LINE-DATA-3>{ fn:string('') }</ASXMAI-LINE-DATA-3>
            <ASXMAI-LINE-DATA-4>{ fn:string('') }</ASXMAI-LINE-DATA-4>
            <ASXMAI-LINE-DATA-5>{ fn:string('') }</ASXMAI-LINE-DATA-5>
            <ASXMAI-EFF-DATE>{ fn:adjust-date-to-timezone(current-date(),()) }</ASXMAI-EFF-DATE>
            <ASXMAI-TXN-AMOUNT>{ data($creaFinanciamiento/PRINCIPAL_AMOUNT) }</ASXMAI-TXN-AMOUNT>
            <ASXMAI-PLAN-NBR>{ data($creaFinanciamiento/PLAN_NUMBER) }</ASXMAI-PLAN-NBR>
            <ASXMAI-PLAN-SEQ>1</ASXMAI-PLAN-SEQ>
            <ASXMAI-DEPT-CODE>0</ASXMAI-DEPT-CODE>
            <ASXMAI-AUTH-CODE>0</ASXMAI-AUTH-CODE>
            <ASXMAI-STORE-NBR>999999998</ASXMAI-STORE-NBR>
            <ASXMAI-SKU-NBR>0</ASXMAI-SKU-NBR>
            <ASXMAI-SALES-CLERK>0</ASXMAI-SALES-CLERK>
            <ASXMAI-LTR-CODE>{ fn:string('') }</ASXMAI-LTR-CODE>
            <ASXMAI-CARD-NBR>{ fn:string('') }</ASXMAI-CARD-NBR>
            <ASXMAI-TICKET-NBR>0</ASXMAI-TICKET-NBR>
            <ASXMAI-PURCHASE-ORDER-NBR>0</ASXMAI-PURCHASE-ORDER-NBR>
            <ASXMAI-INS-CODE>{ fn:string('') }</ASXMAI-INS-CODE>
            <ASXMAI-ACTION-CODE-PRI>0</ASXMAI-ACTION-CODE-PRI>
            <ASXMAI-REFERRAL-OPTION>{ fn:string('') }</ASXMAI-REFERRAL-OPTION>
            <ASXMAI-REFERRAL-REP-ORG>{ fn:string('') }</ASXMAI-REFERRAL-REP-ORG>
            <ASXMAI-REFERRAL-REP-ID>{ fn:string('') }</ASXMAI-REFERRAL-REP-ID>
            <ASXMAI-INST-NBR>0</ASXMAI-INST-NBR>
        </ns1:MonetaryActionCodeRequest>
};

declare variable $creaFinanciamiento as element(ns0:creaFinanciamiento) external;
declare variable $representante as xs:string external;
declare variable $canal as xs:string external;

xf:monetaryActionNIIn($creaFinanciamiento,
    $representante, 
    $canal)