<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetProductOnBaseTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $CloudCodeToGetProductOnBase as element() (:: schema-element(ns1:cloudCodeResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;
declare variable $currency as xs:string external;

declare function local:funcCloudCodeToGetProductOnBase($CloudCodeToGetProductOnBase as element() (:: schema-element(ns1:cloudCodeResponse) ::),
                                                       $globalId as xs:string, 
                                                       $status as xs:string,
                                                       $currency as xs:string) as element() (:: schema-element(ns2:getProductOnBaseResponse) ::) {
    <ns2:getProductOnBaseResponse>
        <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Error>{fn:data($CloudCodeToGetProductOnBase/error)}</Error>
        <Message>{fn:data($CloudCodeToGetProductOnBase/mensaje)}</Message>
        <TypeIdentification>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/tipoIdentificacion)}</TypeIdentification>
        <NumberAffiliateIdentification>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/numeroIdentificacionAfiliado)}</NumberAffiliateIdentification>
        <NameCustomer>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/nombreCliente)}</NameCustomer>
        <AccountCode>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/codigoCuenta)}</AccountCode>
        <CodeCurrency>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/codigoMoneda)}</CodeCurrency>
        <NumberApplicationRequestBinding>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/numeroSolicitudVinculacion)}</NumberApplicationRequestBinding>
        <LineProduct>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/lineaProducto)}</LineProduct>
        <Sponsor>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/patrocinador)}</Sponsor>
        <DateOpenAccount>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/fechaAperturaCuenta)}</DateOpenAccount>
        <BalanceTotalCurrent>{fn:data($CloudCodeToGetProductOnBase/datos/cuenta/saldoTotalActual)}</BalanceTotalCurrent>
        {
        for $item in $CloudCodeToGetProductOnBase/datos/cuenta/saldosSubcuenta
        return
        <BalancesSubaccount>
            <subaccount>{fn:data($item/subcuenta)}</subaccount>
            <initialBalance>{fn:data($item/saldoInicial)}</initialBalance>
            <contributions>{fn:data($item/aportes)}</contributions>
            <commissions>{fn:data($item/comisiones)}</commissions>
            <withdrawals>{fn:data($item/retiros)}</withdrawals>
            <profits>{fn:data($item/rendimientos)}</profits>
            <insurance>{fn:data($item/seguros)}</insurance>
            <balanceCurrent>{fn:data($item/saldoActual)}</balanceCurrent>
        </BalancesSubaccount>
        }
    </ns2:getProductOnBaseResponse>
};

local:funcCloudCodeToGetProductOnBase($CloudCodeToGetProductOnBase,$globalId, $status,$currency)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetProductOnBaseTypes.xsd">
            <con:schema ref="SBHN_Pension_GetProductOnBase/Schemas/GetProductOnBaseTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetProductOnBase/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>