xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetRemittancesFields";
(:: import schema at "../../../../ProviderServices/XSD/GetRemittancesFields/GetRemittancesFields_sp.xsd" ::)

declare variable $getRemittancesFieldsResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($getRemittancesFieldsResponse as element() (:: schema-element(ns1:OutputParameters) ::)) as element(*) {
    let $codigoContrato := $getRemittancesFieldsResponse/ns1:PV_CODIGOCONTRATO
    let $claveRemesadora := $getRemittancesFieldsResponse/ns1:PV_CLAVEREMESA
    let $moneda := $getRemittancesFieldsResponse/ns1:PV_MONEDA
    let $fechaRemesa := $getRemittancesFieldsResponse/ns1:PV_FECHAREMESA
    let $monto := $getRemittancesFieldsResponse/ns1:PV_MONTO
    let $montoLocal := $getRemittancesFieldsResponse/ns1:PV_MONTOLOCAL
    let $tasaCambio := $getRemittancesFieldsResponse/ns1:PV_TASACAMBIO
    let $remitente := $getRemittancesFieldsResponse/ns1:PV_REMITENTE
    let $beneficiario := $getRemittancesFieldsResponse/ns1:PV_BENEFICIARIO
    let $paisOrigen := $getRemittancesFieldsResponse/ns1:PV_PAISORIGEN
    return
    <parametrosRemesa>
        <CODIGOCONTRATO>{data($codigoContrato)}</CODIGOCONTRATO>
        <CLAVEREMESA>{data($claveRemesadora)}</CLAVEREMESA>
        <MONEDA>{data($moneda)}</MONEDA>
        <FECHAREMESA>{data($fechaRemesa)}</FECHAREMESA>
        <MONTO>{data($monto)}</MONTO>
        <MONTOLOCAL>{data($montoLocal)}</MONTOLOCAL>
        <TASACAMBIO>{data($tasaCambio)}</TASACAMBIO>
        <REMITENTE>{data($remitente)}</REMITENTE>
        <BENEFICIARIO>{data($beneficiario)}</BENEFICIARIO>
        <PAISORIGEN>{data($paisOrigen)}</PAISORIGEN>
    </parametrosRemesa>
};

local:func($getRemittancesFieldsResponse)
