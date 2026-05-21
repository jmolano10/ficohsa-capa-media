<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes";
(:: import schema at "../Schemas/ConsultaFondosPensionesClienteTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFundPensionClientTypes.xsd" ::)

declare variable $request11g as element() (:: schema-element(ns1:consultaFondosPensionesClienteRequest) ::) external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $userName as xs:string external;
declare variable $legalIdType as xs:string external;

declare function local:funcVirtual11gToRegional($request11g as element() (:: schema-element(ns1:consultaFondosPensionesClienteRequest) ::),
                                                $sourceBank as xs:string, 
                                                $destinationBank as xs:string, 
                                                $userName as xs:string,
                                                $legalIdType as xs:string) as element() (:: schema-element(ns2:getFundPensionClient) ::) {
    <ns2:getFundPensionClient>
        <GeneralInfo>
            <SourceBank>{fn:data($sourceBank)}</SourceBank>
            <DestinationBank>{fn:data($destinationBank)}</DestinationBank>
            <ApplicationId>{fn:data($userName)}</ApplicationId>
            <ApplicationUser>{fn:data($userName)}</ApplicationUser>
        </GeneralInfo>
        <IdentificationType>{fn:data($legalIdType)}</IdentificationType>
        <IdentificationNumber>{fn:data($request11g/ns1:CUSTOMER_ID_VALUE)}</IdentificationNumber>
        <Clientcode>{fn:data($request11g/ns1:CUSTOMER_CODE)}</Clientcode>
    </ns2:getFundPensionClient>
};

local:funcVirtual11gToRegional($request11g,$sourceBank, $destinationBank, $userName, $legalIdType)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/ConsultaFondosPensionesClienteTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFundPensionClient/Schemas/ConsultaFondosPensionesClienteTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFundPensionClientTypes.xsd">
            <con:schema ref="SBRG_Pension_GetFundPensionClient/Schemas/GetFundPensionClientTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>