<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetAssetsCustomerTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:saldosResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:func($response as element() (:: schema-element(ns1:saldosResponse) ::), 
                            $globalId as xs:string, 
                            $status as xs:string) 
                            as element() (:: schema-element(ns2:OutputParameters) ::) {
    <ns2:OutputParameters>
        <ns2:StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </ns2:StatusInfo>
        <ns2:PT_CUENTAS>
            {
                for $cuentas in $response/ns1:datos/ns1:cuentas
                return 
                <ns2:CUENTA>
                    {
                        if ($cuentas/ns1:cuenta)
                        then <ns2:NUMERO_CUENTA>{fn:data($cuentas/ns1:cuenta)}</ns2:NUMERO_CUENTA>
                        else ()
                    }
                    {
                        let $description := concat(fn:data($cuentas/ns1:primerNombre)," ",fn:data($cuentas/ns1:segundoNombre)," ",fn:data($cuentas/ns1:primerApellido)," ",
                        fn:data($cuentas/ns1:segundoApellido))
                        return 
                        <ns2:DESCRIPCION_CUENTA>{$description}</ns2:DESCRIPCION_CUENTA>
                    }
                    {
                        if ($cuentas/ns1:moneda)
                        then <ns2:MONEDA>{fn:data($cuentas/ns1:moneda)}</ns2:MONEDA>
                        else ()
                    }
                    {
                        if ($cuentas/ns1:saldoTotal)
                        then <ns2:SALDO_TOTAL>{fn:data($cuentas/ns1:saldoTotal)}</ns2:SALDO_TOTAL>
                        else ()
                    }
                </ns2:CUENTA>
            }
        </ns2:PT_CUENTAS>
        {
            if ($response/ns1:error)
            then <ns2:CODIGO_ERROR>{fn:data($response/ns1:error)}</ns2:CODIGO_ERROR>
            else ()
        }
        {
            if ($response/ns1:mensaje)
            then <ns2:DESCRIPCION_ERROR>{fn:data($response/ns1:mensaje)}</ns2:DESCRIPCION_ERROR>
            else ()
        }
    </ns2:OutputParameters>
};

local:func($response, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetAssetsCustomerTypes.xsd">
            <con:schema ref="SBHN_Pension_GetAssetsCustomer/Schemas/GetAssetsCustomerTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>