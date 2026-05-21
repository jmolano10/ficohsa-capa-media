<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/pension";
(:: import schema at "../Schemas/GetFICOPENTypes.xsd" ::)

declare variable $CloudCodeToGetFICOPEN as element() (:: schema-element(ns1:getFICOPENResponse) ::) external;
declare variable $globalId as xs:string external;
declare variable $status as xs:string external;

declare function local:funcCloudCodeToGetFICOPEN($CloudCodeToGetFICOPEN as element() (:: schema-element(ns1:getFICOPENResponse) ::),
                                                  $globalId as xs:string, 
                                                  $status as xs:string) as element() (:: schema-element(ns2:getFICOPENResponse) ::) {
    <ns2:getFICOPENResponse>
    <StatusInfo>
            <Status>{fn:data($status)}</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        <Error>{fn:data($CloudCodeToGetFICOPEN/error)}</Error>
        <Message>{fn:data($CloudCodeToGetFICOPEN/mensaje)}</Message>
        <TypeIdentification>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/tipoIdentificacion)}</TypeIdentification>
        <NumberAffiliateIdentification>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/numeroIdentificacionAfiliado)}</NumberAffiliateIdentification>
        <NameCustomer>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/nombreCliente)}</NameCustomer>
        <AccountCode>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/codigoCuenta)}</AccountCode>
        <CodeCurrency>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/codigoMoneda)}</CodeCurrency>
        <NumberApplicationRequestBinding>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/numeroSolicitudVinculacion)}</NumberApplicationRequestBinding>
        <LineProduct>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/lineaProducto)}</LineProduct>
        <Sponsor>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/patrocinador)}</Sponsor>
        <DateOpenAccount>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/fechaAperturaCuenta)}</DateOpenAccount>
        <BalanceTotalCurrent>{fn:data($CloudCodeToGetFICOPEN/datos/cuenta/saldoTotalActual)}</BalanceTotalCurrent>
        {
          for $item in $CloudCodeToGetFICOPEN/datos/cuenta/saldosSubcuenta
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
    </ns2:getFICOPENResponse>
};

local:funcCloudCodeToGetFICOPEN($CloudCodeToGetFICOPEN, $globalId, $status)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFICOPEN/Schemas/CloudCodeTypes"/>
        </con:importSchema>
        <con:importSchema location="../Schemas/GetFICOPENTypes.xsd">
            <con:schema ref="SBHN_Pension_GetFICOPEN/Schemas/GetFICOPENTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>