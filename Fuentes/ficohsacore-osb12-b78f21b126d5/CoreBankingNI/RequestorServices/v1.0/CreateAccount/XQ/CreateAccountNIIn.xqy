xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/accountsTypes";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountsTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConnectionCobisNI";
(:: import schema at "../../../../ProviderServices/XSD/CreateAccount/CreateAccountNI_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $request as element() (:: schema-element(ns1:createAccountRequest) ::) external;

declare function local:func($request as element() (:: schema-element(ns1:createAccountRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        {
            if ($request/ns1:GeneralInfo/com:SourceBank)
            then <ns2:i_SourceBank>{fn:data($request/ns1:GeneralInfo/com:SourceBank)}</ns2:i_SourceBank>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:DestinationBank)
            then <ns2:i_DestinationBank>{fn:data($request/ns1:GeneralInfo/com:DestinationBank)}</ns2:i_DestinationBank>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:GlobalId)
            then <ns2:i_GlobalId>{fn:data($request/ns1:GeneralInfo/com:GlobalId)}</ns2:i_GlobalId>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:ApplicationId)
            then <ns2:i_ApplicationId>{fn:data($request/ns1:GeneralInfo/com:ApplicationId)}</ns2:i_ApplicationId>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:ApplicationUser)
            then <ns2:i_ApplicationUser>{fn:data($request/ns1:GeneralInfo/com:ApplicationUser)}</ns2:i_ApplicationUser>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:BranchId)
            then <ns2:i_BranchId>{fn:data($request/ns1:GeneralInfo/com:BranchId)}</ns2:i_BranchId>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:TransactionDate)
            then <ns2:i_TransactionDate>{fn:data($request/ns1:GeneralInfo/com:TransactionDate)}</ns2:i_TransactionDate>
            else ()
        }
        {
            if ($request/ns1:GeneralInfo/com:Language)
            then <ns2:i_Lang>{fn:data($request/ns1:GeneralInfo/com:Language)}</ns2:i_Lang>
            else ()
        }
        {
            if ($request/ns1:ProcessType)
            then <ns2:i_ProcessType>{fn:data($request/ns1:ProcessType)}</ns2:i_ProcessType>
            else ()
        }
        {
            if ($request/ns1:InterfaceUser)
            then <ns2:i_InterfaceUser>{fn:data($request/ns1:InterfaceUser)}</ns2:i_InterfaceUser>
            else ()
        }
        {
            if ($request/ns1:CustomerCode)
            then <ns2:i_CustomerCode>{fn:data($request/ns1:CustomerCode)}</ns2:i_CustomerCode>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:Category)
            then <ns2:i_Category>{fn:data($request/ns1:AccountDetail/ns1:Category)}</ns2:i_Category>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:Currency)
            then <ns2:i_Currency>{fn:data($request/ns1:AccountDetail/ns1:Currency)}</ns2:i_Currency>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:OperationType)
            then <ns2:i_OperationType>{fn:data($request/ns1:AccountDetail/ns1:OperationType)}</ns2:i_OperationType>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:ReferredType)
            then <ns2:i_ReferredType>{fn:data($request/ns1:AccountDetail/ns1:ReferredType)}</ns2:i_ReferredType>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:Passbook)
            then <ns2:i_Passbook>{fn:data($request/ns1:AccountDetail/ns1:Passbook)}</ns2:i_Passbook>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:PassbookNumber)
            then <ns2:i_PassbookNumber>{fn:data($request/ns1:AccountDetail/ns1:PassbookNumber)}</ns2:i_PassbookNumber>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:PayrollGroup)
            then <ns2:i_PayrollGroup>{fn:data($request/ns1:AccountDetail/ns1:PayrollGroup)}</ns2:i_PayrollGroup>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:InitialDeposit)
            then <ns2:i_InitialDeposit>{fn:data($request/ns1:AccountDetail/ns1:InitialDeposit)}</ns2:i_InitialDeposit>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:Purpose)
            then <ns2:i_Purpose>{fn:data($request/ns1:AccountDetail/ns1:Purpose)}</ns2:i_Purpose>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:OrigenOfFunds)
            then <ns2:i_OrigenOfFunds>{fn:data($request/ns1:AccountDetail/ns1:OrigenOfFunds)}</ns2:i_OrigenOfFunds>
            else ()
        }
        {
            if ($request/ns1:AccountDetail/ns1:MonthlyTxnVolume)
            then <ns2:i_MonthlyTxnVolume>{fn:data($request/ns1:AccountDetail/ns1:MonthlyTxnVolume)}</ns2:i_MonthlyTxnVolume>
            else ()
        }
        {
            if ($request/ns1:TransactionDetails/ns1:NumTxnDeb)
            then <ns2:i_NumTxnDeb>{fn:data($request/ns1:TransactionDetails/ns1:NumTxnDeb)}</ns2:i_NumTxnDeb>
            else ()
        }
        {
            if ($request/ns1:TransactionDetails/ns1:NumTxnCred)
            then <ns2:i_NumTxnCred>{fn:data($request/ns1:TransactionDetails/ns1:NumTxnCred)}</ns2:i_NumTxnCred>
            else ()
        }
        {
            if ($request/ns1:TransactionDetails/ns1:MonthlyTxnCred)
            then <ns2:i_MonthlyTxnCred>{fn:data($request/ns1:TransactionDetails/ns1:MonthlyTxnCred)}</ns2:i_MonthlyTxnCred>
            else ()
        }
        {
            if ($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:BeneficiaryName)
            then <ns2:i_BeneficiaryName>{fn:data($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:BeneficiaryName)}</ns2:i_BeneficiaryName>
            else ()
        }
        {
            if ($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:Relation)
            then <ns2:i_Relation>{fn:data($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:Relation)}</ns2:i_Relation>
            else ()
        }
        {
            if ($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:DocumentType)
            then <ns2:i_DocumentType>{fn:data($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:DocumentType)}</ns2:i_DocumentType>
            else ()
        }
        {
            if ($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:LegalId)
            then <ns2:i_LegalId>{fn:data($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:LegalId)}</ns2:i_LegalId>
            else ()
        }
        {
            if ($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:BeneficiaryPercentage)
            then <ns2:i_BeneficiaryPercentage>{fn:data($request/ns1:BeneficiaryDetails/ns1:BeneficiaryDetail/ns1:BeneficiaryPercentage)}</ns2:i_BeneficiaryPercentage>
            else ()
        }
        {
            if ($request/ns1:SignatoryDetails/ns1:RegisteredSignatory)
            then <ns2:i_RegisteredSignatory>{fn:data($request/ns1:SignatoryDetails/ns1:RegisteredSignatory)}</ns2:i_RegisteredSignatory>
            else ()
        }
        {
            if ($request/ns1:SignatoryDetails/ns1:RequiredSignatory)
            then <ns2:i_RequiredSignatory>{fn:data($request/ns1:SignatoryDetails/ns1:RequiredSignatory)}</ns2:i_RequiredSignatory>
            else ()
        }
        {
            if ($request/ns1:SignatoryDetails/ns1:SignatoryDescription)
            then <ns2:i_SignatoryDescription>{fn:data($request/ns1:SignatoryDetails/ns1:SignatoryDescription)}</ns2:i_SignatoryDescription>
            else ()
        }
        
    </ns2:InputParameters>
};

local:func($request)