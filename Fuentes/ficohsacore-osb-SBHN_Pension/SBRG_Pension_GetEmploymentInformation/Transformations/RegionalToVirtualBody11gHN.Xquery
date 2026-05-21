<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
(:: import schema at "../Schemas/ConsultaInformacionLaboralTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetEmploymentInformationTypes.xsd" ::)

declare variable $responseRegional as element() (:: schema-element(ns1:getEmploymentInformationResponse) ::) external;

declare function local:funcRegionalToVirtualBody11gHN($responseRegional as element() (:: schema-element(ns1:getEmploymentInformationResponse) ::)) as element() (:: schema-element(ns2:consultaInformacionLaboralResponse) ::) {
    <ns2:consultaInformacionLaboralResponse>

        <ns2:JOB_INFO_HISTORY>
            {
                for $HistoricalLaborInformation in $responseRegional/Data/Employment/HistoricalLaborInformation
                return 
                <ns2:JOB_INFO_HISTORY_ITEM>
                    <ns2:CUSTOMER_ACCOUNT>{fn:data($HistoricalLaborInformation/AccountCode)}</ns2:CUSTOMER_ACCOUNT>
                    <ns2:STATUS>{fn:data($HistoricalLaborInformation/AccountState)}</ns2:STATUS>
                    <ns2:START_DATE>{fn:data($HistoricalLaborInformation/StartDate)}</ns2:START_DATE>
                    <ns2:END_DATE>{fn:data($HistoricalLaborInformation/DateEnd)}</ns2:END_DATE>
                    <ns2:PAYMENT_PERIOD>{fn:data($HistoricalLaborInformation/Period)}</ns2:PAYMENT_PERIOD>
                    <ns2:EMPLOYER_CODE>{fn:data($HistoricalLaborInformation/EmployerCode)}</ns2:EMPLOYER_CODE>
                    <ns2:EMPLOYER_NAME>{fn:data($HistoricalLaborInformation/EmployeeName)}</ns2:EMPLOYER_NAME>
                    <ns2:EMPLOYER_RTN>{fn:data($HistoricalLaborInformation/RTNEmployer)}</ns2:EMPLOYER_RTN>
                    <ns2:BALANCE_TYPE>{fn:data($HistoricalLaborInformation/TypeIncome)}</ns2:BALANCE_TYPE>
                    <ns2:PAYMENT_CURRENCY/>
                    <ns2:PAYMENT_AMOUNT>{fn:data($HistoricalLaborInformation/ContributionAmount)}</ns2:PAYMENT_AMOUNT>
                    <ns2:SALARY_CURRENCY>{fn:data($HistoricalLaborInformation/CurrencySalary)}</ns2:SALARY_CURRENCY>
                    <ns2:SALARY_AMOUNT>{fn:data($HistoricalLaborInformation/SalaryAmount)}</ns2:SALARY_AMOUNT>
                    <ns2:OCCUPATION_CODE>{fn:data($HistoricalLaborInformation/CodeOccupation)}</ns2:OCCUPATION_CODE>
                    <ns2:OCCUPATION_DESC>{fn:data($HistoricalLaborInformation/DescriptionOccupation)}</ns2:OCCUPATION_DESC>
                    <ns2:JOB_TITLE_CODE>{fn:data($HistoricalLaborInformation/JobCode)}</ns2:JOB_TITLE_CODE>
                    <ns2:JOB_TITLE_DESC>{fn:data($HistoricalLaborInformation/JobDescription)}</ns2:JOB_TITLE_DESC>
                </ns2:JOB_INFO_HISTORY_ITEM>
            }
        </ns2:JOB_INFO_HISTORY>
    </ns2:consultaInformacionLaboralResponse>
};

local:funcRegionalToVirtualBody11gHN($responseRegional)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaInformacionLaboralTypes.xsd">
            <con:schema ref="SBRG_Pension_GetEmploymentInformation/Schemas/ConsultaInformacionLaboralTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetEmploymentInformationTypes.xsd">
            <con:schema ref="SBRG_Pension_GetEmploymentInformation/Schemas/GetEmploymentInformationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>