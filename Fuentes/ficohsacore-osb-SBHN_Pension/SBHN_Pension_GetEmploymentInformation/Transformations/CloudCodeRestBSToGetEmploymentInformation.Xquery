<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetEmploymentInformationTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:historicasLaboralesResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:func($response as element() (:: schema-element(ns1:historicasLaboralesResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) 
                            as element() (:: schema-element(ns2:getEmploymentInformationResponse) ::) {
    <ns2:getEmploymentInformationResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Data>
            <Employment>
                {
                    for $laborales in $response/ns1:datos/ns1:laborales/ns1:infoLaboralHistorica
                    return 
                    <HistoricalLaborInformation>
                        <AccountCode>{fn:data($laborales/ns1:codigoCuenta)}</AccountCode>
                        <AccountState>{fn:data($laborales/ns1:estadoCuenta)}</AccountState>
                        <StartDate>{fn:data($laborales/ns1:fechaInicio)}</StartDate>
                        <DateEnd>{fn:data($laborales/ns1:fechaFin)}</DateEnd>
                        <Period>{fn:data($laborales/ns1:periodo)}</Period>
                        <EmployerCode>{fn:data($laborales/ns1:codigoEmpleador)}</EmployerCode>
                        <RTNEmployer>{fn:data($laborales/ns1:RTNEmpleador)}</RTNEmployer>
                        <EmployeeName>{fn:data($laborales/ns1:nombreEmpleador)}</EmployeeName>
                        <TypeIncome>{fn:data($laborales/ns1:tipoIngreso)}</TypeIncome>
                        <ContributionAmount>{fn:data($laborales/ns1:montoAporte)}</ContributionAmount>
                        <CurrencySalary>{fn:data($laborales/ns1:monedaSalario)}</CurrencySalary>
                        <SalaryAmount>{fn:data($laborales/ns1:montoSalario)}</SalaryAmount>
                        <CodeOccupation>{fn:data($laborales/ns1:codigoOcupacion)}</CodeOccupation>
                        <DescriptionOccupation>{fn:data($laborales/ns1:descripcionOcupacion)}</DescriptionOccupation>
                        <JobCode>{fn:data($laborales/ns1:codigoTrabajo)}</JobCode>
                        <JobDescription>{fn:data($laborales/ns1:descripcionTrabajo)}</JobDescription>
                    </HistoricalLaborInformation>
                }
            </Employment>
        </Data>
    </ns2:getEmploymentInformationResponse>
};

local:func($response, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetEmploymentInformationTypes.xsd">
            <con:schema ref="SBHN_Pension_GetEmploymentInformation/Schemas/GetEmploymentInformationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>