(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MDW/obtenerCamposRemesasRel/xsd/obtenerCamposRemesasRel_sp.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerCamposRemesasRel";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/generaEntradaRelConsPagoConv/";

declare function xf:generaEntradaRelConsPagoConv($outputParameters as element(ns0:OutputParameters))
    as element(*) {
        let $codigoContrato := $outputParameters/ns0:PV_CODIGOCONTRATO
    	let $claveRemesadora := $outputParameters/ns0:PV_CLAVEREMESA
    	let $moneda := $outputParameters/ns0:PV_MONEDA
    	let $fechaRemesa := $outputParameters/ns0:PV_FECHAREMESA
    	let $monto := $outputParameters/ns0:PV_MONTO
    	let $montoLocal := $outputParameters/ns0:PV_MONTOLOCAL
    	let $tasaCambio := $outputParameters/ns0:PV_TASACAMBIO
    	let $remitente := $outputParameters/ns0:PV_REMITENTE
		let $beneficiario := $outputParameters/ns0:PV_BENEFICIARIO
		let $paisOrigen := $outputParameters/ns0:PV_PAISORIGEN
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

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:generaEntradaRelConsPagoConv($outputParameters)