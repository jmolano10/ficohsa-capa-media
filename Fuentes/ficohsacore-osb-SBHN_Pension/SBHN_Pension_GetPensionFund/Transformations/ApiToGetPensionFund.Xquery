<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetPensionFundTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $responseApi as element() (:: schema-element(ns1:cuentasFondosPensionesResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:func($responseApi as element() (:: schema-element(ns1:cuentasFondosPensionesResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) as element() (:: schema-element(ns2:getPensionFundResponse) ::) {
    <ns2:getPensionFundResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Data>
            <Account>
                <AccountCode>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:codigoCuenta)}</AccountCode>
                <CustomerCode>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:codigoCliente)}</CustomerCode>
                <CustomerName>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:nombreCliente)}</CustomerName>
                <CodeProductLine>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:codigoLineaProducto)}</CodeProductLine>
                <ProductName>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:nombreProducto)}</ProductName>
                <ProductCode>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:codigoProducto)}</ProductCode>
                <OpeningDate>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:fechaApertura)}</OpeningDate>
                <InsuredAmount>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:montoAsegurado)}</InsuredAmount>
                <LastContribution>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:ultimaContribucion)}</LastContribution>
                <NextContribution>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:siguienteContribucion)}</NextContribution>
                <LastContributionAmount>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:ultimoMontoContribucion)}</LastContributionAmount>
                <LastContributionExtra>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:ultimaContribucicionExtra)}</LastContributionExtra>
                <FrequencyContribution>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:frecuenciaAporte)}</FrequencyContribution>
                <FormContribution>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:formaAporte)}</FormContribution>
                <AmountContribution>{fn:data($responseApi/ns1:datos/ns1:cuenta/ns1:montoAporte)}</AmountContribution>
                {
                 for $beneficiaries in $responseApi/ns1:datos/ns1:cuenta/ns1:beneficiarios
                 return
                <Beneficiaries>
                    <NameBeneficiary>{fn:data($beneficiaries/ns1:nombreBeneficiario)}</NameBeneficiary>
                    <RelationshipBeneficiary>{fn:data($beneficiaries/ns1:relacionBeneficiario)}</RelationshipBeneficiary>
                </Beneficiaries>
                }
            </Account>
        </Data>
    </ns2:getPensionFundResponse>
};

local:func($responseApi, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetPensionFundTypes.xsd">
            <con:schema ref="SBHN_Pension_GetPensionFund/Schemas/GetPensionFundTypes"/>
        </con:importSchema>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>