xquery version "2004-draft";
(:: pragma  parameter="$parametersOut" type="anyType" ::)
(:: pragma  parameter="$paramEntradaRemesa" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/registraRelConsPagoRem/xsd/ingresoRelConsPagoRem_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresoRelConsPagoRem";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/ingRelConsPagoConv/";

declare function xf:ingRelConsPagoConv($parametersOut as element(*),
    $paramEntradaRemesa as element(*),
    $remetter as xs:string)
    as element(ns0:InputParameters) {
    
    let $codigoContrato := $paramEntradaRemesa/CODIGOCONTRATO
    let $claveRemesadora := $paramEntradaRemesa/CLAVEREMESA
    let $moneda := $paramEntradaRemesa/MONEDA
    let $fechaRemesa := $paramEntradaRemesa/FECHAREMESA
    let $monto := $paramEntradaRemesa/MONTO
    let $montoLocal := $paramEntradaRemesa/MONTOLOCAL
    let $tasaCambio := $paramEntradaRemesa/TASACAMBIO
    let $remitente := $paramEntradaRemesa/REMITENTE
	let $beneficiario := $paramEntradaRemesa/BENEFICIARIO
	let $paisOrigen := $paramEntradaRemesa/PAISORIGEN
    return    
        <ns0:InputParameters>
            <ns0:PV_CODIGOCONTRATO>{data($parametersOut/moreParameters/data[@fieldName=$codigoContrato ]/text()) }</ns0:PV_CODIGOCONTRATO>            
            <ns0:PV_CLAVEREMESA>{ data($parametersOut/primaryKey/text()) }</ns0:PV_CLAVEREMESA>
            <ns0:PV_MONEDA>{ data($parametersOut/moreParameters/data[@fieldName=$moneda]/text()) }</ns0:PV_MONEDA>
            <ns0:PD_FECHAREMESA>{ fn:concat(fn:substring($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text(),1,4),'-',fn:substring($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text(),5,2),'-',fn:substring($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text(),7,2)) }</ns0:PD_FECHAREMESA>            
            <ns0:PN_MONTO>{ data($parametersOut/totalAmount/text()) }</ns0:PN_MONTO>
            <ns0:PN_MONTOLOCAL>{ data($parametersOut/moreParameters/data[@fieldName=$montoLocal]/text()) }</ns0:PN_MONTOLOCAL>
            <ns0:PN_TASACAMBIO>{ data($parametersOut/moreParameters/data[@fieldName=$tasaCambio]/text()) }</ns0:PN_TASACAMBIO>
            <ns0:PV_REMITENTE>{ data($parametersOut/moreParameters/data[@fieldName=$remitente]/text()) }</ns0:PV_REMITENTE>
            <ns0:PV_BENEFICIARIO>{ data($parametersOut/moreParameters/data[@fieldName=$beneficiario]/text()) }</ns0:PV_BENEFICIARIO>
            <ns0:PV_PAISORIGEN>{ data($parametersOut/moreParameters/data[@fieldName=$paisOrigen]/text()) }</ns0:PV_PAISORIGEN>
        </ns0:InputParameters>
};

declare variable $parametersOut as element(*) external;
declare variable $paramEntradaRemesa as element(*) external;
declare variable $remetter as xs:string external;

xf:ingRelConsPagoConv($parametersOut,
    $paramEntradaRemesa,
    $remetter)