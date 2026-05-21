<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFinancialSituationTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:financierosResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:func($response as element() (:: schema-element(ns1:financierosResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) 
                            as element() (:: schema-element(ns2:OutputParameters) ::) {
    <ns2:OutputParameters>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
            for $PV_BANCO_REGION_OUT in $response/ns1:datos/ns1:bancoRegion
            return
            <PV_BANCO_REGION_OUT>{fn:data($PV_BANCO_REGION_OUT)}</PV_BANCO_REGION_OUT>
        }
        {
            for $PV_TIPO_PRODUCTO_CLI in $response/ns1:datos/ns1:tipoProductoCli
            return
            <PV_TIPO_PRODUCTO_CLI>{fn:data($PV_TIPO_PRODUCTO_CLI)}</PV_TIPO_PRODUCTO_CLI>
        }
        {
            for $PV_TIPO_PRODUCTO in $response/ns1:datos/ns1:tipoProducto
            return
            <PV_TIPO_PRODUCTO>{fn:data($PV_TIPO_PRODUCTO)}</PV_TIPO_PRODUCTO>
        }
        {
            if (fn:exists($response/ns1:datos/ns1:cuentas)) then (
                <PT_CODIGO_MONEDA>
                {
                    for $account in $response/ns1:datos/ns1:cuentas
                    return (
                        <PT_CODIGO_MONEDA_ITEM>{ fn:data($account/ns1:moneda) }</PT_CODIGO_MONEDA_ITEM>
                    )
                }
                </PT_CODIGO_MONEDA>,
                <PT_SALDO_TOTAL>
                {
                    for $account in $response/ns1:datos/ns1:cuentas
                    return (
                        <PT_SALDO_TOTAL_ITEM>{ fn:data($account/ns1:saldoTotal) }</PT_SALDO_TOTAL_ITEM>
                    )
                }
                </PT_SALDO_TOTAL>
            ) else ()
        }
        {
            for $PV_CODIGO_ERROR in $response/ns1:error
            return
            if (xs:boolean($PV_CODIGO_ERROR)) then (
                <PV_CODIGO_ERROR>ERROR</PV_CODIGO_ERROR>
            ) else (
                <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
            )
        }
        {
            let $errorCode := fn:data($response/ns1:error)
            let $validationMessage := fn:data($response/ns1:mensaje)
            return
            if (xs:boolean($errorCode)) then (
                <PV_DESCRIPCION_ERROR>{ $validationMessage }</PV_DESCRIPCION_ERROR>
            ) else (
                <PV_DESCRIPCION_ERROR/>
            )
        }
    </ns2:OutputParameters>
};

local:func($response, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFinancialSituationTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFinancialSituation/Schemas/GetFinancialSituationTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>