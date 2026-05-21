<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/pagoRetiroFPCTypes";
(:: import schema at "../Schemas/PagoRetiroFPCTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/PaymentWithdrawalFPCTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:pagoRetiroFPC) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:pagoRetiroFPC) ::),
                                              $sourceBank as xs:string, 
                                              $destinationBank as xs:string, 
                                              $userName as xs:string) as element() (:: schema-element(ns2:paymentWithdrawalFPC) ::) {
    <ns2:paymentWithdrawalFPC>
        <GeneralInfo>
          <SourceBank>{fn:data($sourceBank)}</SourceBank>
          <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
          <ApplicationId>{fn:data($userName)}</ApplicationId>
          <ApplicationUser>{fn:data($userName)}</ApplicationUser>
       </GeneralInfo>
        <ApplicationNumber>{fn:data($request11g/APPLICATION_NUMBER)}</ApplicationNumber>
        <Currency>{fn:data($request11g/CURRENCY)}</Currency>
        <Amount>{fn:data($request11g/AMOUNT)}</Amount>
        <PaidUse>{fn:data($request11g/USER_PAY)}</PaidUse>
        <PaymentDate>{fn:data($request11g/DATE)}</PaymentDate>
        <Transaction>{fn:data($request11g/TRANSACTION)}</Transaction>
        <AgencyCode>{fn:data($request11g/CODE_AGENCY)}</AgencyCode>
        <AgencyName>{fn:data($request11g/AGENCY_NAME)}</AgencyName>
    </ns2:paymentWithdrawalFPC>
};

local:funcVirtual11gToRegional($request11g, $sourceBank, $destinationBank, $userName)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/PagoRetiroFPCTypes.xsd">
            <con:schema ref="SBRG_Pension_PaymentWithdrawalFPC/Schemas/PagoRetiroFPCTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/PaymentWithdrawalFPCTypes.xsd">
            <con:schema ref="SBRG_Pension_PaymentWithdrawalFPC/Schemas/PaymentWithdrawalFPCTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>