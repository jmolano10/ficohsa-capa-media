<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetBalancesWarrantiesTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $responseRestricciones as element() (:: schema-element(ns1:restriccionesResponse) ::) external;
declare variable $responseIntegrales as element(*)? external;
declare variable $resultGroup as element(*)? external;
declare variable $globalId as xs:string external;

declare function local:func($responseRestricciones as element() (:: schema-element(ns1:restriccionesResponse) ::), 
                            $responseIntegrales as element(*)?,
                            $resultGroup as element(*)?,
                            $globalId as xs:string) 
                            as element() (:: schema-element(ns2:getBalancesWarrantiesResponse) ::) {
    <ns2:getBalancesWarrantiesResponse>
        <StatusInfo>
            <Status>Success</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{$globalId}</GlobalId>
        </StatusInfo>
        <Data>
            <Account>
            {
              for $resulGroupItem in $resultGroup/Response/ns1:datos
              return
                <raised>
                    <DateOpening>{fn:data($resulGroupItem/ns1:cuenta/ns1:fechaApertura)}</DateOpening>
                    <Status>{fn:data($resulGroupItem/ns1:cuenta/ns1:estado)}</Status>
                    <SubAccountCode>{fn:data($resulGroupItem/ns1:cuenta/ns1:codigoSubcuenta)}</SubAccountCode>
                    <CurrencyCode>{fn:data($resulGroupItem/ns1:cuenta/ns1:codigoMoneda)}</CurrencyCode>
                    <Balance>{fn:data($resulGroupItem/ns1:cuenta/ns1:saldo)}</Balance>
                </raised>
            }
                <CodeLineProduct>{fn:data($responseRestricciones/ns1:datos/ns1:cuenta/ns1:codigoLineaProducto)}</CodeLineProduct>
                <ProductCode>{fn:data($responseRestricciones/ns1:datos/ns1:cuenta/ns1:codigoProducto)}</ProductCode>
                <CodeCustomerIdentificationType>{fn:data($responseRestricciones/ns1:datos/ns1:cuenta/ns1:codigoTipoIdentificacionCliente)}</CodeCustomerIdentificationType>
                <NumberCustomerIdentification>{fn:data($responseRestricciones/ns1:datos/ns1:cuenta/ns1:numeroIdentificacionCliente)}</NumberCustomerIdentification>
            </Account>
            {
            for $item in $responseRestricciones/ns1:datos/ns1:restricciones
            return
            <Restrictions>
                <NameConceptRestriction>{fn:data($item/ns1:nombreConceptoRestriccion)}</NameConceptRestriction>
                <CodeLineProduct>{fn:data($item/ns1:codigoLineaProducto)}</CodeLineProduct>
                <DateStartApplicationRestriction>{fn:data($item/ns1:fechaInicioAplicacionRestriccion)}</DateStartApplicationRestriction>
                <CodeConceptRestriction>{fn:data($item/ns1:codigoConceptoRestriccion)}</CodeConceptRestriction>
                <CodeBusinessLine>{fn:data($item/ns1:codigoLineaNegocio)}</CodeBusinessLine>
                <CodeRestrictionType>{fn:data($item/ns1:codigoTipoRestriccion)}</CodeRestrictionType>
                <CodeTypeAmountRestriction>{fn:data($item/ns1:codigoTipoMontoRestriccion)}</CodeTypeAmountRestriction>
                <RestrictionValue>{fn:data($item/ns1:valorRestriccion)}</RestrictionValue>
                <DateRecordRestriction>{fn:data($item/ns1:fechaRegistroRestriccion)}</DateRecordRestriction>
                <CodeProcessRecordRestriction>{fn:data($item/ns1:codigoProcesoRegistroRestriccion)}</CodeProcessRecordRestriction>
            </Restrictions>
            }
            {
            for $item in $responseIntegrales/Response/ns1:datos/ns1:informacion
            return
            <Informations>
                <SubAccountCode>{fn:data($item/ns1:codigoSubcuenta)}</SubAccountCode>
                <NameSubAccount>{fn:data($item/ns1:nombreSubcuenta)}</NameSubAccount>
                <BalanceTotalLevel>{fn:data($item/ns1:saldoTotalNivelPesos)}</BalanceTotalLevel>
            </Informations>
            }
        </Data>
    </ns2:getBalancesWarrantiesResponse>
};

local:func($responseRestricciones, $responseIntegrales, $resultGroup,$globalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetBalancesWarrantiesTypes.xsd">
            <con:schema ref="SBHN_Pension_GetBalancesWarranties/Schemas/GetBalancesWarrantiesTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetBalancesWarranties/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>