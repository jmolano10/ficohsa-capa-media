<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetValidProductCustomerTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/pension/CloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $CloudCodeToGetValidProductCustomer as element() (:: schema-element(ns1:cloudCodeResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;
declare variable $currency as xs:string external;

declare function local:funcCloudCodeToGetValidProductCustome($CloudCodeToGetValidProductCustomer as element() (:: schema-element(ns1:cloudCodeResponse) ::),
$globalId as xs:string, 
$status as xs:string,
$currency) as element() (:: schema-element(ns2:getValidProductCustomerResponse) ::) {
    <ns2:getValidProductCustomerResponse>
    <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Error>{fn:data($CloudCodeToGetValidProductCustomer/error)}</Error>
        <Message>{fn:data($CloudCodeToGetValidProductCustomer/mensaje)}</Message>
        <TypeIdentification>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/tipoIdentificacion)}</TypeIdentification>
        <NumberAffiliateIdentification>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/numeroIdentificacionAfiliado)}</NumberAffiliateIdentification>
        <NameCustomer>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/nombreCliente)}</NameCustomer>
        <AccountCode>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/codigoCuenta)}</AccountCode>
        <CodeCurrency>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/codigoMoneda)}</CodeCurrency>
        <NumberApplicationRequestBinding>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/numeroSolicitudVinculacion)}</NumberApplicationRequestBinding>
        <LineProduct>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/lineaProducto)}</LineProduct>
        <Sponsor>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/patrocinador)}</Sponsor>
        <DateOpenAccount>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/fechaAperturaCuenta)}</DateOpenAccount>
        <BalanceTotalCurrent>{fn:data($CloudCodeToGetValidProductCustomer/datos/cuenta/saldoTotalActual)}</BalanceTotalCurrent>
        {
          for $item in $CloudCodeToGetValidProductCustomer/datos/cuenta/saldosSubcuenta
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
    </ns2:getValidProductCustomerResponse>
};

local:funcCloudCodeToGetValidProductCustome($CloudCodeToGetValidProductCustomer,$globalId, $status, $currency )]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetValidProductCustomerTypes.xsd">
            <con:schema ref="SBHN_Pension_GetValidProductCustomer/Schemas/GetValidProductCustomerTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetValidProductCustomer/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>