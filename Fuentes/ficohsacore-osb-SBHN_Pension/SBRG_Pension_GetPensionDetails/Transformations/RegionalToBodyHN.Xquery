<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace con="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/Virtual/consultaFICOPENTypes.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/regional/pension";
(:: import schema at "../../SBRG_Pension_Commons/Schemas/PensionInquiryTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns0:getPensionDetailsResponse) ::) external;

declare function local:func($responseRegional as element() (:: schema-element(ns0:getPensionDetailsResponse) ::)) as element() 
(:: schema-element(con:consultaFICOPENResponse) ::) {
    <con:consultaFICOPENResponse>
            <CUSTOMER_LEGAL_ID>{ data($responseRegional/CustomerLegalId) }</CUSTOMER_LEGAL_ID>
            <CUSTOMER_NAME>{ data($responseRegional/CustomerName) }</CUSTOMER_NAME>
            <ACCOUNT_NUMBER>{ data($responseRegional/AccountNumber) }</ACCOUNT_NUMBER>
            <ACCOUNT_CURRENCY>{data($responseRegional/AccountCurrency)}</ACCOUNT_CURRENCY>
            <CONTRACT_NUMBER>{ data($responseRegional/ContractNumber) }</CONTRACT_NUMBER>
            <CONTRACT_TYPE>{ data($responseRegional/ContractType) }</CONTRACT_TYPE>
            <COMPANY>{ data($responseRegional/Company) }</COMPANY>
            <START_DATE>{ data($responseRegional/StartDate) }</START_DATE>
            <consultaFICOPENResponseType>
            {
                for $item in $responseRegional/PensionDetails
                return
                    <consultaFICOPENResponseRecordType>
                        <BALANCE_TYPE>{ data($item/BalanceType) }</BALANCE_TYPE>
                        <PREVIOUS_BALANCE>{ data($item/PreviousBalance) }</PREVIOUS_BALANCE>
                        <GROSS_CONTRIBUTIONS_AMOUNT>{ data($item/GrossContributionsAmount) }</GROSS_CONTRIBUTIONS_AMOUNT>
                        <INTEREST_AMOUNT>{ data($item/InterestAmount) }</INTEREST_AMOUNT>
                        <WITHDRAWALS_AMOUNT>{ data($item/WithdrawalsAmount) }</WITHDRAWALS_AMOUNT>
                        <FEE_AMOUNT>{ data($item/FeeAmount) }</FEE_AMOUNT>
                        <INSURANCE_AMOUNT>{ data($item/InsuranceAmount) }</INSURANCE_AMOUNT>
                        <CURRENT_BALANCE>{ data($item/CurrentBalance) }</CURRENT_BALANCE>
                    </consultaFICOPENResponseRecordType>
            }
            </consultaFICOPENResponseType>
        </con:consultaFICOPENResponse>
};

local:func($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/Virtual/consultaFICOPENTypes.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/Virtual/consultaFICOPENTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBRG_Pension_Commons/Schemas/PensionInquiryTypes.xsd">
            <con:schema ref="SBRG_Pension_Commons/Schemas/PensionInquiryTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>