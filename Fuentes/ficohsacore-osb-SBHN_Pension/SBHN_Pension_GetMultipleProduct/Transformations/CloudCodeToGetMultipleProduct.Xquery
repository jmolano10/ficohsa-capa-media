<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/GetMultipleProductTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $responseAPI as element() (:: schema-element(ns1:getPeriodosResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:funcCloudCodeToGetMultipleProduct($responseAPI as element() (:: schema-element(ns1:getPeriodosResponse) ::),
                                                        $globalId as xs:string, 
                                                        $status as xs:string) as element() (:: schema-element(ns2:getMultipleProductResponse) ::) {
    <ns2:getMultipleProductResponse>
    <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
    </StatusInfo>
    <ErrorInfo>
        <Code></Code>
        {
            if ($responseAPI/error)
            then <Error>{fn:data($responseAPI/error)}</Error>
            else ()
        }
        <Description></Description>
        <ShortDescription></ShortDescription>
        <DateTime></DateTime>
        <GlobalId></GlobalId>
        <Details>
            <SystemId></SystemId>
            <SystemStatus></SystemStatus>
            <MessageId></MessageId>
            {
                if ($responseAPI/mensaje)
                then <Messages>{fn:data($responseAPI/mensaje)}</Messages>
                else ()
            }
        </Details>
    </ErrorInfo>
        <TypeIdentification>{fn:data($responseAPI/datos/cuenta/tipoIdentificacion)}</TypeIdentification>
        <NumberAffiliateIdentification>{fn:data($responseAPI/datos/cuenta/numeroIdentificacionAfiliado)}</NumberAffiliateIdentification>
        <NameCustomer>{fn:data($responseAPI/datos/cuenta/nombreCliente)}</NameCustomer>
        <AccountCode>{fn:data($responseAPI/datos/cuenta/codigoCuenta)}</AccountCode>
        <CodeCurrency>{fn:data($responseAPI/datos/cuenta/codigoMoneda)}</CodeCurrency>
        <NumberApplicationRequestBinding>{fn:data($responseAPI/datos/cuenta/numeroSolicitudVinculacion)}</NumberApplicationRequestBinding>
        <LineProduct>{fn:data($responseAPI/datos/cuenta/lineaProducto)}</LineProduct>
        <Sponsor>{fn:data($responseAPI/datos/cuenta/patrocinador)}</Sponsor>
        <DateOpenAccount>{fn:data($responseAPI/datos/cuenta/fechaAperturaCuenta)}</DateOpenAccount>
        <BalanceTotalCurrent>{fn:data($responseAPI/datos/cuenta/saldoTotalActual)}</BalanceTotalCurrent>
        {
         for $item in $responseAPI/datos/cuenta/saldosSubcuenta
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
    
    </ns2:getMultipleProductResponse>
};

local:funcCloudCodeToGetMultipleProduct($responseAPI,$globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/GetMultipleProductTypes.xsd">
            <con:schema ref="SBHN_Pension_GetMultipleProduct/Schemas/GetMultipleProductTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetMultipleProduct/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>