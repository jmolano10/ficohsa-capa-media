<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
(:: import schema at "../Schemas/ConsultaFICOPENTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFICOPENTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getFICOPENResponse) ::) external;

declare function local:func($responseRegional as element() (:: schema-element(ns1:getFICOPENResponse) ::)) as element() (:: schema-element(ns2:consultaFICOPENResponse) ::) {
    <ns2:consultaFICOPENResponse>
        <CUSTOMER_LEGAL_ID>{fn:data($responseRegional/NumberAffiliateIdentification)}</CUSTOMER_LEGAL_ID>
        <CUSTOMER_NAME>{fn:data($responseRegional/NameCustomer)}</CUSTOMER_NAME>
        <ACCOUNT_NUMBER>{fn:data($responseRegional/AccountCode)}</ACCOUNT_NUMBER>
        <ACCOUNT_CURRENCY>{fn:data($responseRegional/CodeCurrency)}</ACCOUNT_CURRENCY>
        <CONTRACT_NUMBER>{fn:data($responseRegional/NumberApplicationRequestBinding)}</CONTRACT_NUMBER>
        <CONTRACT_TYPE>{fn:data($responseRegional/LineProduct)}</CONTRACT_TYPE>
        <COMPANY>{fn:data($responseRegional/Sponsor)}</COMPANY>
        <START_DATE>{fn:data($responseRegional/DateOpenAccount)}</START_DATE>
        <consultaFICOPENResponseType>
        {
          for $item in $responseRegional/BalancesSubaccount
          return
            <consultaFICOPENResponseRecordType>
                <BALANCE_TYPE>{fn:data($item/subaccount)}</BALANCE_TYPE>
                <PREVIOUS_BALANCE>{fn:data($item/initialBalance)}</PREVIOUS_BALANCE>
                <GROSS_CONTRIBUTIONS_AMOUNT>{fn:data($item/contributions)}</GROSS_CONTRIBUTIONS_AMOUNT>
                <INTEREST_AMOUNT>{fn:data($item/commissions)}</INTEREST_AMOUNT>
                <WITHDRAWALS_AMOUNT>{fn:data($item/withdrawals)}</WITHDRAWALS_AMOUNT>
                <FEE_AMOUNT>{fn:data($item/profits)}</FEE_AMOUNT>
                <INSURANCE_AMOUNT>{fn:data($item/insurance)}</INSURANCE_AMOUNT>
                <CURRENT_BALANCE>{fn:data($item/balanceCurrent)}</CURRENT_BALANCE>
            </consultaFICOPENResponseRecordType>
        }  
        </consultaFICOPENResponseType>     
    </ns2:consultaFICOPENResponse>
};

local:func($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaFICOPENTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFICOPEN/Schemas/ConsultaFICOPENTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFICOPENTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFICOPEN/Schemas/GetFICOPENTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>