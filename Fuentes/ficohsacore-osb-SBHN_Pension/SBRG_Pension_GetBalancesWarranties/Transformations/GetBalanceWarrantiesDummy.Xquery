<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetBalancesWarrantiesTypes.xsd" ::)

declare variable $request as element() external;

declare function local:func($request as element()) as element() (:: schema-element(ns1:getBalancesWarrantiesResponse) ::) {
    <ns1:getBalancesWarrantiesResponse>
        <StatusInfo>
            <Status>Success</Status>
            <ValueDate>{fn:current-date()}</ValueDate>
            <DateTime>{fn:current-dateTime()}</DateTime>
            <GlobalId>{fn-bea:uuid()}</GlobalId>
        </StatusInfo>
        <Data>
            <Account>
                <raised>
                    <DateOpening>2022-10-27-06:00</DateOpening>
                    <Status>1</Status>
                    <SubAccountCode>1</SubAccountCode>
                    <CurrencyCode>HNL</CurrencyCode>
                    <Balance>35728741.45</Balance>
                </raised>
                <raised>
                    <DateOpening>2021-10-27-06:00</DateOpening>
                    <Status>1</Status>
                    <SubAccountCode>2</SubAccountCode>
                    <CurrencyCode>HNL</CurrencyCode>
                    <Balance>35728741.45</Balance>
                </raised>
                <CodeLineProduct>1</CodeLineProduct>
                <ProductCode>1</ProductCode>
                <CodeCustomerIdentificationType>CC</CodeCustomerIdentificationType>
                <NumberCustomerIdentification>0826199500213</NumberCustomerIdentification>
            </Account>
            <Restrictions>
                <NameConceptRestriction>Inmovilización</NameConceptRestriction>
                <CodeLineProduct>1</CodeLineProduct>
                <DateStartApplicationRestriction>2023-07-26-06:00</DateStartApplicationRestriction>
                <CodeConceptRestriction>111</CodeConceptRestriction>
                <CodeBusinessLine>1</CodeBusinessLine>
                <CodeRestrictionType>INMOVILIZACION</CodeRestrictionType>
                <CodeTypeAmountRestriction>VALOR</CodeTypeAmountRestriction>
                <RestrictionValue>1000</RestrictionValue>
                <DateRecordRestriction>2023-07-26-06:00</DateRecordRestriction>
                <CodeProcessRecordRestriction>MANUAL</CodeProcessRecordRestriction>
            </Restrictions>
            <Restrictions>
                <NameConceptRestriction>Inmovilización</NameConceptRestriction>
                <CodeLineProduct>1</CodeLineProduct>
                <DateStartApplicationRestriction>2023-07-26-06:00</DateStartApplicationRestriction>
                <CodeConceptRestriction>111</CodeConceptRestriction>
                <CodeBusinessLine>1</CodeBusinessLine>
                <CodeRestrictionType>INMOVILIZACION</CodeRestrictionType>
                <CodeTypeAmountRestriction>VALOR</CodeTypeAmountRestriction>
                <RestrictionValue>1000</RestrictionValue>
                <DateRecordRestriction>2023-07-26-06:00</DateRecordRestriction>
                <CodeProcessRecordRestriction>MANUAL</CodeProcessRecordRestriction>
            </Restrictions>
            <Information>
                <SubAccountCode>1</SubAccountCode>
                <NameSubAccount>AVAO</NameSubAccount>
                <BalanceTotalLevel>60967607.78</BalanceTotalLevel>
            </Information>
        </Data>
    </ns1:getBalancesWarrantiesResponse>
};

local:func($request)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetBalancesWarrantiesTypes.xsd">
            <con:schema ref="SBRG_Pension_GetBalancesWarranties/Schemas/GetBalancesWarrantiesTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>