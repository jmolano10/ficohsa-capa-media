xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/activateFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/activateFinancingTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/WSDL/visionPlus/visionPlus.wsdl" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $request as element() (:: schema-element(ns1:activateFinancing) ::) external;
declare variable $asm-user as xs:string external;

declare function xq:MonetaryActionCodeIn($request as element() (:: schema-element(ns1:activateFinancing) ::),$asm-user as xs:string) as element() (:: schema-element(ns2:MonetaryActionCodeL8V2Request) ::) {
    <ns2:MonetaryActionCodeL8V2Request>
        <AZXMAI-ASM-ORG>{fn:data($request/AsmOrg)}</AZXMAI-ASM-ORG>
        <AZXMAI-ASM-REP>{$asm-user}</AZXMAI-ASM-REP>
        <AZXMAI-FOREIGN-USE-IND>{fn:data($request/CurrencyIndicator)}</AZXMAI-FOREIGN-USE-IND>
        <AZXMAI-ACCT-ORG>{fn:data($request/Org)}</AZXMAI-ACCT-ORG>
        <AZXMAI-ACCT-NBR>{fn:data($request/AccountNumber)}</AZXMAI-ACCT-NBR>
        <AZXMAI-ACTION-CODE>{fn:data($request/TransactionCode)}</AZXMAI-ACTION-CODE>
        <AZXMAI-EFF-DATE>{ fn:adjust-date-to-timezone(current-date(),()) }</AZXMAI-EFF-DATE>
        <AZXMAI-TXN-AMOUNT>{fn:data($request/PrincipalAmount)}</AZXMAI-TXN-AMOUNT>
        <AZXMAI-PLAN-NBR>{fn:data($request/PlanNumber)}</AZXMAI-PLAN-NBR>
        <AZXMAI-PLAN-SEQ>{fn:data($request/PlanSecuence)}</AZXMAI-PLAN-SEQ>
        <AZXMAI-DEPT-CODE>2</AZXMAI-DEPT-CODE>
        <AZXMAI-AUTH-CODE>0</AZXMAI-AUTH-CODE>
        <AZXMAI-STORE-NBR>999999998</AZXMAI-STORE-NBR>
        <AZXMAI-SKU-NBR>0</AZXMAI-SKU-NBR>
        <AZXMAI-SALES-CLERK>0</AZXMAI-SALES-CLERK>
        <AZXMAI-TICKET-NBR>0</AZXMAI-TICKET-NBR>
        <AZXMAI-PURCHASE-ORDER-NBR>0</AZXMAI-PURCHASE-ORDER-NBR>
        <AZXMAI-ACTION-CODE-PRI>0</AZXMAI-ACTION-CODE-PRI>
        <AZXMAI-INST-NBR>0</AZXMAI-INST-NBR>
        <AZXMAI-DESC>{fn:data($request/Description)}</AZXMAI-DESC>
            { let $refNumber := data($request/RefNumber) 
                  return 
                  if($refNumber != '')then(
                        <AZXMAI-REF-NUM>{$refNumber}</AZXMAI-REF-NUM>
                  )else
                        (<AZXMAI-REF-NUM>0</AZXMAI-REF-NUM>)         
            }
        <AZXMAI-OTB-UPDATE-IND>{fn:data($request/OtbIndicator)}</AZXMAI-OTB-UPDATE-IND>
    </ns2:MonetaryActionCodeL8V2Request>
};

xq:MonetaryActionCodeIn($request,$asm-user)