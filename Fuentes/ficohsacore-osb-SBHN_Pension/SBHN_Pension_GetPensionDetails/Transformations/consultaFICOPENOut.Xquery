<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/FICOPEN/OSB_K_CONSULTAFICOPEN/TOPLEVEL-24OSB_CON_FICOPEN/";
(:: import schema at "../Schemas/Ficopen.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/PensionInquiryTypes.xsd" ::)

declare variable $outputParameters1 as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $globalId as xs:string external;
 
declare function local:func($outputParameters1 as element() (:: schema-element(ns1:OutputParameters) ::)
,$globalId as xs:string) as element() (:: schema-element(ns2:getPensionDetailsResponse) ::) {
    <ns2:getPensionDetailsResponse>
          <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
                  
              </StatusInfo>
    
          <CustomerLegalId>{fn:data($outputParameters1/ns1:CUSTOMER_LEGAL_ID)}</CustomerLegalId>
          <CustomerName>{ data($outputParameters1/ns1:CUSTOMER_NAME) }</CustomerName>
          <AccountNumber>{ data($outputParameters1/ns1:ACCOUNT_NUMBER) }</AccountNumber>
          <AccountCurrency>
            { 
            	let $currency := data($outputParameters1/ns1:ACCOUNT_CURRENCY)
            	return
            	if ($currency = "1") then (
            		"HNL"
            	) else if ($currency ="2") then (
            		"USD"
            	) else if ($currency ="3") then (
            		"EUR"
            	) else (
            		""
            	)
            }
          </AccountCurrency>
          <ContractNumber>{ data($outputParameters1/ns1:CONTRACT_NUMBER) }</ContractNumber>
          <ContractType>{ data($outputParameters1/ns1:CONTRACT_TYPE) }</ContractType>
          <Company>{ data($outputParameters1/ns1:COMPANY) }</Company>
          <StartDate>{ data($outputParameters1/ns1:START_DATE_RESP) }</StartDate>
            {
                for $i in (1 to max( (	count($outputParameters1/ns1:BALANCE_TYPE/ns1:ITEM),
                    count($outputParameters1/ns1:PREVIOUS_BALANCE/ns1:ITEM),
                    count($outputParameters1/ns1:GROSS_CONTRIBUTIONS_AMOUNT/ns1:ITEM),
                    count($outputParameters1/ns1:INTEREST_AMOUNT/ns1:ITEM),
                    count($outputParameters1/ns1:WITHDRAWALS_AMOUNT/ns1:ITEM),
                    count($outputParameters1/ns1:FEE_AMOUNT/ns1:ITEM),
                    count($outputParameters1/ns1:INSURANCE_AMOUNT/ns1:ITEM),
                    count($outputParameters1/ns1:CURRENT_BALANCE/ns1:ITEM))))
                return
          <PensionDetails>
              <BalanceType>{ data($outputParameters1/ns1:BALANCE_TYPE/ns1:ITEM[$i]) }</BalanceType>
              <PreviousBalance>{ data($outputParameters1/ns1:PREVIOUS_BALANCE/ns1:ITEM[$i]) }</PreviousBalance>
              <GrossContributionsAmount>{ data($outputParameters1/ns1:GROSS_CONTRIBUTIONS_AMOUNT/ns1:ITEM[$i]) }</GrossContributionsAmount>
              <InterestAmount>{ data($outputParameters1/ns1:INTEREST_AMOUNT/ns1:ITEM[$i]) }</InterestAmount>
              <WithdrawalsAmount>{ data($outputParameters1/ns1:WITHDRAWALS_AMOUNT/ns1:ITEM[$i]) }</WithdrawalsAmount>
              <FeeAmount>{ data($outputParameters1/ns1:FEE_AMOUNT/ns1:ITEM[$i]) }</FeeAmount>
              <InsuranceAmount>{ data($outputParameters1/ns1:INSURANCE_AMOUNT/ns1:ITEM[$i]) }</InsuranceAmount>
              <CurrentBalance>{ data($outputParameters1/ns1:CURRENT_BALANCE/ns1:ITEM[$i]) }</CurrentBalance>
          </PensionDetails>
        }
    </ns2:getPensionDetailsResponse>
};

local:func($outputParameters1,$globalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/Ficopen.xsd">
            <con:schema ref="SBHN_Pension_GetPensionDetails/Schemas/Ficopen"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/PensionInquiryTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/PensionInquiryTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>