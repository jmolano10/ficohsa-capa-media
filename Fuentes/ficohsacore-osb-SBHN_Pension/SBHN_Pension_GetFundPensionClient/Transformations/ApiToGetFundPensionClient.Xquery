<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFundPensionClientTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $globalId as xs:string external;

declare variable $responseApi as element() (:: schema-element(ns1:fondosPensionesResponse) ::) external;

declare function local:func($responseApi as element() (:: schema-element(ns1:fondosPensionesResponse) ::),
                            $globalId as xs:string) as element() (:: schema-element(ns2:getFundPensionClientResponse) ::) {
    <ns2:getFundPensionClientResponse>
        <StatusInfo>
            <Status>{if(fn:data($responseApi/error) = 'false') then('Success')else('Error')}</Status>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Data>
            <Client>
                <IdentificationType>{fn:data($responseApi/datos/cliente/tipoIdentificacion)}</IdentificationType>
                <IdentificationNumber>{fn:data($responseApi/datos/cliente/numeroIdentificacion)}</IdentificationNumber>
                <Clientcode>{fn:data($responseApi/datos/cliente/codigoCliente)}</Clientcode>
                {
                    for $cuentas in $responseApi/datos/cliente/cuentas
                    return 
                    <Accounts>
                       <AccountCode>{fn:data($cuentas/codigoCuenta)}</AccountCode>
                       <CurrencyCode>{fn:data($cuentas/codigoMoneda)}</CurrencyCode>
                       <CurrencyName>{fn:data($cuentas/nombreMoneda)}</CurrencyName>
                       <CodeProductLine>{fn:data($cuentas/codigoLineaProducto)}</CodeProductLine>
                       <ProductLineName>{fn:data($cuentas/nombreLineaProducto)}</ProductLineName>
                       <ProductCode>{fn:data($cuentas/codigoProducto)}</ProductCode>
                       <ProductName>{fn:data($cuentas/nombreProducto)}</ProductName>
                       <Alternative>{fn:data($cuentas/alternativa)}</Alternative>
                    </Accounts>
                }
            </Client>
        </Data>

    </ns2:getFundPensionClientResponse>
};

local:func($responseApi, $globalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetFundPensionClientTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFundPensionClient/Schemas/GetFundPensionClientTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFundPensionClient/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>