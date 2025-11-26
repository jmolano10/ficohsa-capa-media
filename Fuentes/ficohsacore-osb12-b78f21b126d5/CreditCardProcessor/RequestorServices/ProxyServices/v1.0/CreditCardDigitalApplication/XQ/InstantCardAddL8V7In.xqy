xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/creditCardDigitalApplicationTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/creditCardDigitalApplicationTypes.xsd" ::)
declare namespace ns2="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/WSDL/visionPlus/visionPlusService.wsdl" ::)

declare variable $creditCardDigitalApplicationRequest as element() (:: schema-element(ns1:creditCardDigitalApplicationRequest) ::) external;

declare function local:func($creditCardDigitalApplicationRequest as element() (:: schema-element(ns1:creditCardDigitalApplicationRequest) ::)) 
                            as element() (:: schema-element(ns2:InstantCardAddL8V7Request) ::) {
    <ns2:InstantCardAddL8V7Request>
        <AZXICI-ORG>{fn:data($creditCardDigitalApplicationRequest/ns1:Org)}</AZXICI-ORG>
        <AZXICI-LOGO>{fn:data($creditCardDigitalApplicationRequest/ns1:Logo)}</AZXICI-LOGO>
        <AZXICI-CUST-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:CustimerId)}</AZXICI-CUST-NBR>
        <AZXICI-FIRST-PURCH-SW>{fn:data($creditCardDigitalApplicationRequest/ns1:FirtsPurchase)}</AZXICI-FIRST-PURCH-SW>
        <AZXICI-ACCT-CREATE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountCreate)}</AZXICI-ACCT-CREATE>
        <AZXICI-SDP-PROCESS-TYPE>{fn:data($creditCardDigitalApplicationRequest/ns1:SameDayProcessType)}</AZXICI-SDP-PROCESS-TYPE>
        <AZXICI-CARD-ACTION>{fn:data($creditCardDigitalApplicationRequest/ns1:CardActionFlag)}</AZXICI-CARD-ACTION>
        <AZXICI-BASE-ACCT-DATA>
            <AZXICI-BS-ACCT>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:Account)}</AZXICI-BS-ACCT>
            <AZXICI-BILLING-ACCT-IND>0</AZXICI-BILLING-ACCT-IND>
            <AZXICI-REL-PRIM-ACCT-FLAG/>
            <AZXICI-REL-NBR/>
            <AZXICI-SHORT-NAME>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:ShortName)}</AZXICI-SHORT-NAME>
            <AZXICI-CREDIT-LIMIT>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:CreditLimitLcy)}</AZXICI-CREDIT-LIMIT>
            <AZXICI-BILLING-CURR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:BillingCurrency)}</AZXICI-BILLING-CURR>
            <AZXICI-REL-BILL-LVL>1</AZXICI-REL-BILL-LVL>
            <AZXICI-DUAL-BILLING-FL>0</AZXICI-DUAL-BILLING-FL>
            <AZXICI-REL-CARD-SCHEME>0</AZXICI-REL-CARD-SCHEME>
            <AZXICI-ALT-CUST-NBR-FLAG/>
            <AZXICI-DATE-ALT-CUST-STRT>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:DateAltCustStrt)}</AZXICI-DATE-ALT-CUST-STRT>
            <AZXICI-DATE-ALT-CUST-EXPR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:DateAltCustExp)}</AZXICI-DATE-ALT-CUST-EXPR>
            <AZXICI-ALT-CUST-NBR/>
            <AZXICI-DATE-OPENED>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:DateOpened)}</AZXICI-DATE-OPENED>
            <AZXICI-CUST-SEL-DUE-DAY>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:CustomerSelDueDay)}</AZXICI-CUST-SEL-DUE-DAY>
            <AZXICI-BILLING-CYCLE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:BillingCycle)}</AZXICI-BILLING-CYCLE>
            <AZXICI-STATEMENT-FREQ>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:StatementFrequency)}</AZXICI-STATEMENT-FREQ>
            <AZXICI-STATEMENT-FLAG>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:StatementFlag)}</AZXICI-STATEMENT-FLAG>
            <AZXICI-BLOCK-CODE-1>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:BlockCode1)}</AZXICI-BLOCK-CODE-1>
            <AZXICI-BLOCK-CODE-2>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:BlockCode2)}</AZXICI-BLOCK-CODE-2>
            <AZXICI-BS-AUTH-CRITERIA-TBL/>
            <AZXICI-STATE-OF-RESID>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:StateOfResid)}</AZXICI-STATE-OF-RESID>
            <AZXICI-STATE-OF-ISSUE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:StateOfIssue)}</AZXICI-STATE-OF-ISSUE>
            <AZXICI-PCT-CTL-ID>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PctCtdlId)}</AZXICI-PCT-CTL-ID>
            <AZXICI-PCT-START-DATE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PctStartDate)}</AZXICI-PCT-START-DATE>
            <AZXICI-PCT-EXPIRE-DATE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PctExpireDate)}</AZXICI-PCT-EXPIRE-DATE>
            <AZXICI-PCT-LEVEL>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PctLevel)}</AZXICI-PCT-LEVEL>
            <AZXICI-PCT-LEVEL-START-DATE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PctLevelStartDate)}</AZXICI-PCT-LEVEL-START-DATE>
            <AZXICI-PCT-LEVEL-EXPIR-DATE>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PctLevelExpireDate)}</AZXICI-PCT-LEVEL-EXPIR-DATE>
            <AZXICI-CASH-PLAN-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:CashPlanNumber)}</AZXICI-CASH-PLAN-NBR>
            <AZXICI-RETAIL-PLAN-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:RetailPlanNumber)}</AZXICI-RETAIL-PLAN-NBR>
            <AZXICI-PROMO-PLAN-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:PromoPlanNumber)}</AZXICI-PROMO-PLAN-NBR>
            <AZXICI-DDA-RTNG-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:DdaRtngNumber)}</AZXICI-DDA-RTNG-NBR>
            <AZXICI-DDA-ACCT-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:DdaAccountNumber)}</AZXICI-DDA-ACCT-NBR>
            <AZXICI-SAV-RTNG-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:SavRtngNumber)}</AZXICI-SAV-RTNG-NBR>
            <AZXICI-SAV-ACCT-NBR/>
            <AZXICI-USR-ACCT-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:UserAccountNumber)}</AZXICI-USR-ACCT-NBR>
            <AZXICI-CARD-TECHNOLOGY>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:CardTechnology)}</AZXICI-CARD-TECHNOLOGY>
            <AZXICI-TEMP-CRLIM>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:TempCrlim)}</AZXICI-TEMP-CRLIM>
            <AZXICI-DATE-TEMP-CRLIM-EXP xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <!--Optional
            <AZXGCI-USER-DATE-3 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            Optional:-->
            <AZXICI-AUTH-LIMIT-OVRRD-FLAG>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:LimitOvrrdFlag)}</AZXICI-AUTH-LIMIT-OVRRD-FLAG>
            <AZXICI-OWNING-BRANCH-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:OwningBranchNumber)}</AZXICI-OWNING-BRANCH-NBR>
            <AZXICI-USER-CODE-1/>
            <AZXICI-USER-CODE-2/>
            <AZXICI-USER-CODE-3/>
            <AZXICI-USER-CODE-4/>
            <AZXICI-USER-CODE-5/>
            <AZXICI-USER-CODE-6/>
            <AZXICI-USER-CODE-7/>
            <AZXICI-USER-CODE-8/>
            <AZXICI-USER-CODE-9/>
            <AZXICI-USER-CODE-10/>
            <AZXICI-USER-CODE-11/>
            <AZXICI-USER-CODE-12/>
            <AZXICI-USER-CODE-13/>
            <AZXICI-USER-CODE-14/>
            <AZXICI-USER-DATE-1 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-2 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-3 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-4 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-5 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-6 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-7 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-8 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-9 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-10 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-11 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-12 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-13 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-DATE-14 xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>
            <AZXICI-USER-AMT-1>0</AZXICI-USER-AMT-1>
            <AZXICI-USER-AMT-2>0</AZXICI-USER-AMT-2>
            <AZXICI-USER-AMT-3>0</AZXICI-USER-AMT-3>
            <AZXICI-USER-AMT-4>0</AZXICI-USER-AMT-4>
            <AZXICI-USER-AMT-5>0</AZXICI-USER-AMT-5>
            <AZXICI-USER-AMT-6>0</AZXICI-USER-AMT-6>
            <AZXICI-USER-AMT-7>0</AZXICI-USER-AMT-7>
            <AZXICI-USER-AMT-8>0</AZXICI-USER-AMT-8>
            <AZXICI-USER-AMT-9>0</AZXICI-USER-AMT-9>
            <AZXICI-USER-AMT-10>0</AZXICI-USER-AMT-10>
            <AZXICI-USER-AMT-11>0</AZXICI-USER-AMT-11>
            <AZXICI-USER-AMT-12>0</AZXICI-USER-AMT-12>
            <AZXICI-USER-AMT-13>0</AZXICI-USER-AMT-13>
            <AZXICI-USER-AMT-14>0</AZXICI-USER-AMT-14>
            <AZXICI-SOURCE-CODE/>
            <AZXICI-APPL-USER-1/>
            <AZXICI-APPL-USER-2/>
            <AZXICI-APPL-USER-3/>
            <AZXICI-MISC-USER-1/>
            <AZXICI-MISC-USER-2/>
            <AZXICI-MISC-USER-3/>
            <AZXICI-MISC-USER-4/>
            <AZXICI-MISC-USER-5/>
            <AZXICI-MISC-USER-6/>
            <AZXICI-MISC-USER-7/>
            <AZXICI-MISC-USER-8/>
            <AZXICI-MISC-USER-9/>
            <AZXICI-MISC-USER-10/>
            <AZXICI-MISC-USER-11/>
            <AZXICI-MISC-USER-12/>
            <AZXICI-PREPAID-PLAN-NBR>0</AZXICI-PREPAID-PLAN-NBR>
            <AZXICI-PREPAID-LOAD-FREQ>0</AZXICI-PREPAID-LOAD-FREQ>
            <AZXICI-PREPAID-LOAD-NBR>0</AZXICI-PREPAID-LOAD-NBR>
            <AZXICI-PREPAID-LOAD-AMT>0</AZXICI-PREPAID-LOAD-AMT>
            <AZXICI-MIN-SNGL-LOAD-AMT>0</AZXICI-MIN-SNGL-LOAD-AMT>
            <AZXICI-MAX-SNGL-LOAD-AMT>0</AZXICI-MAX-SNGL-LOAD-AMT>
            <AZXICI-IR-PMT-RETL-PLAN>0</AZXICI-IR-PMT-RETL-PLAN>
            <AZXICI-IR-PMT-CASH-PLAN>0</AZXICI-IR-PMT-CASH-PLAN>
            <AZXICI-INTL-CASH-PLAN>{fn:data($creditCardDigitalApplicationRequest/ns1:AccountData/ns1:IntlCashPlan)}</AZXICI-INTL-CASH-PLAN>
            <AZXICI-INTL-RETAIL-PLAN>0</AZXICI-INTL-RETAIL-PLAN>
            <AZXICI-INTL-INST-PLAN>0</AZXICI-INTL-INST-PLAN>
            <AZXICI-IB-ISS-CASH-PLAN>0</AZXICI-IB-ISS-CASH-PLAN>
            <AZXICI-IB-ISS-RETAIL-PLAN>0</AZXICI-IB-ISS-RETAIL-PLAN>
            <AZXICI-IB-ACQ-RETAIL-PLAN>0</AZXICI-IB-ACQ-RETAIL-PLAN>
            <AZXICI-IB-AUTH-CTRL-TBL>0</AZXICI-IB-AUTH-CTRL-TBL>
            <AZXICI-GLOBAL-QUAL/>
            <AZXICI-AFFL-EMBLM>0</AZXICI-AFFL-EMBLM>
            <AZXICI-BS-MISC-USER-2/>
        </AZXICI-BASE-ACCT-DATA>
        <AZXICI-EMBOSSER-DATA>
            <AZXICI-PLASTIC-ID>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:PlasticId)}</AZXICI-PLASTIC-ID>
            <AZXICI-NAME1-TYPE-IND>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:Name1TypeIndicator)}</AZXICI-NAME1-TYPE-IND>
            <AZXICI-NAME2-TYPE-IND>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:Name2TypeIndicator)}</AZXICI-NAME2-TYPE-IND>
            <AZXICI-EMBOSSED-NAME-1>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:EmbossedName1)}</AZXICI-EMBOSSED-NAME-1>
            <AZXICI-EMBOSSED-NAME-2>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:EmbossedName2)}</AZXICI-EMBOSSED-NAME-2>
            <AZXICI-DATE-EXPIRE>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:ExpirationDate)}</AZXICI-DATE-EXPIRE>
            <AZXICI-CUSTOMER-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:CustomerNumber)}</AZXICI-CUSTOMER-NBR>
            <AZXICI-EMBR-NAME-1>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:Name1)}</AZXICI-EMBR-NAME-1>
            <AZXICI-EMBR-NAME-2>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:Name2)}</AZXICI-EMBR-NAME-2>
            <AZXICI-PIN-OFFSET>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:PinOffSet)}</AZXICI-PIN-OFFSET>
            <AZXICI-POS-SERVICE-CODE>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:PosServiceCode)}</AZXICI-POS-SERVICE-CODE>
            <AZXICI-CARDHOLDER-FLAG>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:CardHolderFlag)}</AZXICI-CARDHOLDER-FLAG>
            <AZXICI-ADDR-LINE-1>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AdressLine1)}</AZXICI-ADDR-LINE-1>
            <AZXICI-ADDR-LINE-2>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AdressLine2)}</AZXICI-ADDR-LINE-2>
            <AZXICI-CITY>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:City)}</AZXICI-CITY>
            <AZXICI-ST-PR>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:StateOrProvince)}</AZXICI-ST-PR>
            <AZXICI-PSTL-CD>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:PostalCode)}</AZXICI-PSTL-CD>
            <AZXICI-LANG-CODE>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:LanguageCode)}</AZXICI-LANG-CODE>
            <AZXICI-BLOCK-CODE>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:BlockCode)}</AZXICI-BLOCK-CODE>
            <AZXICI-AUTH-ATM-OTC-RTL-FREQ>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AtmOtcRtlFrequency)}</AZXICI-AUTH-ATM-OTC-RTL-FREQ>
            <AZXICI-AUTH-ATM-CASH-AMT>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AtmCashAmount)}</AZXICI-AUTH-ATM-CASH-AMT>
            <AZXICI-AUTH-ATM-CASH-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AtmCashNumber)}</AZXICI-AUTH-ATM-CASH-NBR>
            <AZXICI-AUTH-ATM-CASH-SNGL-TXN>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AtmCashSingleTransacctionLimit)}</AZXICI-AUTH-ATM-CASH-SNGL-TXN>
            <AZXICI-AUTH-OTC-CASH-AMT>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:OverTheCounterCashAmount)}</AZXICI-AUTH-OTC-CASH-AMT>
            <AZXICI-AUTH-OTC-CASH-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:OverTheCounterCashNumber)}</AZXICI-AUTH-OTC-CASH-NBR>
            <AZXICI-AUTH-OTC-CASH-SNGL-TXN>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:OverTheCounterSingleTransactionLimit)}</AZXICI-AUTH-OTC-CASH-SNGL-TXN>
            <AZXICI-AUTH-RTL-AMT>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:RetailPurchaseAmt)}</AZXICI-AUTH-RTL-AMT>
            <AZXICI-AUTH-RTL-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:RetailPurchaseNumber)}</AZXICI-AUTH-RTL-NBR>
            <AZXICI-AUTH-RTL-SNGL-TXN>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:RetailPurchaseSingleTransactionLimit)}</AZXICI-AUTH-RTL-SNGL-TXN>
            <AZXICI-AUTH-INTRNT-AMT>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:InternetPurchaseAmount)}</AZXICI-AUTH-INTRNT-AMT>
            <AZXICI-AUTH-INTRNT-NBR>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:InternerPurchaseNumber)}</AZXICI-AUTH-INTRNT-NBR>
            <AZXICI-AUTH-INTRNT-SNGL-TXN>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:InternetPurchaseSingleTransactionLimit)}</AZXICI-AUTH-INTRNT-SNGL-TXN>
            <AZXICI-USER-1/>
            <AZXICI-USER-2>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:Channel)}</AZXICI-USER-2>
            <AZXICI-USER-3/>
            <AZXICI-USER-4>0</AZXICI-USER-4>
            <AZXICI-USER-5/>
            <AZXICI-USER-6/>
            <AZXICI-USER-7/>
            <AZXICI-USER-8/>
            <AZXICI-USER-DATE-1>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:UserDate1)}</AZXICI-USER-DATE-1>
            <AZXICI-USER-DATE-2>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:UserDate2)}</AZXICI-USER-DATE-2>
            <AZXICI-ADMIN-BRANCH>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:BranchNumber)}</AZXICI-ADMIN-BRANCH>
            <AZXICI-FIRST-ISS-BRANCH>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:FirstIssueBranch)}</AZXICI-FIRST-ISS-BRANCH>
            <AZXICI-ISSUE-DELIV-OPTION>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:ReissueDeliveryOption)}</AZXICI-ISSUE-DELIV-OPTION>
            <AZXICI-PROGRAM-ID>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:ProgramId)}</AZXICI-PROGRAM-ID>
            <AZXICI-EMBLM-ID>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:CradHolderAffiliationGroupId)}</AZXICI-EMBLM-ID>
            <AZXICI-AUTH-CRITERIA-TBL>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:AuthorizationCriteriaTableNumber)}</AZXICI-AUTH-CRITERIA-TBL>
            <AZXICI-CARD-ACTION-REASON>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:CardActionReasonCode)}</AZXICI-CARD-ACTION-REASON>
            <AZXICI-IC-TOT-NUM-TXNS>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:IcTotalNumberTransactions)}</AZXICI-IC-TOT-NUM-TXNS>
            <AZXICI-IC-AMT-LMT-SNGL-TXN>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:IcAmountLimitSingleTransaction)}</AZXICI-IC-AMT-LMT-SNGL-TXN>  
            <AZXICI-DIG-CARD-IND>{fn:data($creditCardDigitalApplicationRequest/ns1:EmbosserData/ns1:DigitalCardFlag)}</AZXICI-DIG-CARD-IND>
        </AZXICI-EMBOSSER-DATA>
    </ns2:InstantCardAddL8V7Request>
};

local:func($creditCardDigitalApplicationRequest)
