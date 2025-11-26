xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/regRemittancesPayer";
(:: import schema at "../../../../ProviderServices/XSD/RegRemittancesPayer/regRemittancesPayer_sp.xsd" ::)

declare variable $RemittancesPayerParam as element(*) external;
declare variable $parametersOut as element(*) external;

declare function local:func($RemittancesPayerParam as element(*), 
                            $parametersOut as element(*)) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    let $codigoContrato := $RemittancesPayerParam/CODIGOCONTRATO
    let $claveRemesadora := $RemittancesPayerParam/CLAVEREMESA
    let $moneda := $RemittancesPayerParam/MONEDA
    let $fechaRemesa := $RemittancesPayerParam/FECHAREMESA
    let $monto := $RemittancesPayerParam/MONTO
    let $montoLocal := $RemittancesPayerParam/MONTOLOCAL
    let $tasaCambio := $RemittancesPayerParam/TASACAMBIO
    let $remitente := $RemittancesPayerParam/REMITENTE
    let $beneficiario := $RemittancesPayerParam/BENEFICIARIO
    let $paisOrigen := $RemittancesPayerParam/PAISORIGEN
    return    
        <ns1:InputParameters>
            <ns1:PV_CODIGOCONTRATO>{data($parametersOut/moreParameters/data[@fieldName=$codigoContrato ]/text()) }</ns1:PV_CODIGOCONTRATO>            
            <ns1:PV_CLAVEREMESA>{ data($parametersOut/primaryKey/text()) }</ns1:PV_CLAVEREMESA>
            <ns1:PV_MONEDA>{ data($parametersOut/moreParameters/data[@fieldName=$moneda]/text()) }</ns1:PV_MONEDA>
            <ns1:PD_FECHAREMESA>{ fn:concat(fn:substring($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text(),1,4),'-',fn:substring($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text(),5,2),'-',fn:substring($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text(),7,2)) }</ns1:PD_FECHAREMESA>            
            <ns1:PN_MONTO>{ data($parametersOut/totalAmount/text()) }</ns1:PN_MONTO>
            <ns1:PN_MONTOLOCAL>{ data($parametersOut/moreParameters/data[@fieldName=$montoLocal]/text()) }</ns1:PN_MONTOLOCAL>
            <ns1:PN_TASACAMBIO>{ data($parametersOut/moreParameters/data[@fieldName=$tasaCambio]/text()) }</ns1:PN_TASACAMBIO>
            <ns1:PV_REMITENTE>{ data($parametersOut/moreParameters/data[@fieldName=$remitente]/text()) }</ns1:PV_REMITENTE>
            <ns1:PV_BENEFICIARIO>{ data($parametersOut/moreParameters/data[@fieldName=$beneficiario]/text()) }</ns1:PV_BENEFICIARIO>
            <ns1:PV_PAISORIGEN>{ data($parametersOut/moreParameters/data[@fieldName=$paisOrigen]/text()) }</ns1:PV_PAISORIGEN>
        </ns1:InputParameters>
};

local:func($RemittancesPayerParam, $parametersOut)
