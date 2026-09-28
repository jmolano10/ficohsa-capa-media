xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$paramEntradaRemesa" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:consultaRemesasResponse" location="../xsd/consultaRemesasTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/EnrutadorConveniosOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";

declare function xf:EnrutadorConveniosOut($parametersOut as element(*),
    $paramEntradaRemesa as element(*),
    $remetter as xs:string)
    as element(ns0:consultaRemesasResponse) {
    
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
    
        if (fn:string($parametersOut/errorCode/text()) = ("0", "2")) then (
	        <ns0:consultaRemesasResponse>
	            <ns0:consultaRemesasResponseType>
	                <ns0:consultaRemesasResponseRecordType>
		               	<REMITTANCE_ID>{ data($parametersOut/primaryKey/text()) }</REMITTANCE_ID>       							              
               			<REMITTER_ID>{ data($parametersOut/moreParameters/data[@fieldName=$codigoContrato ]/text()) }</REMITTER_ID>
              			<REMITTER_NAME>{data($parametersOut/moreParameters/data[@fieldName=$remitente]/text())}</REMITTER_NAME>              	
               			<BENEFICIARY_NAME>{data($parametersOut/moreParameters/data[@fieldName=$beneficiario]/text()) }</BENEFICIARY_NAME>
		               	{
		               		if (data($parametersOut/errorCode/text()) = 0) then
		               		( 		               		
		               			<PAYMENT_DATE/>
		               		)
		               		else if (data($parametersOut/errorCode/text()) = 2) then
		               		(
		               			<PAYMENT_DATE>{data($parametersOut/moreParameters/data[@fieldName=$fechaRemesa]/text()) }</PAYMENT_DATE>
		               		)
		               		else
		               		(
		               		    <PAYMENT_DATE/>
		               		)		               	
		               	}	
               			<CURRENCY>{data($parametersOut/moreParameters/data[@fieldName=$moneda]/text())}</CURRENCY>
               			<EXCHANGE_RATE>{data($parametersOut/moreParameters/data[@fieldName=$tasaCambio]/text()) }</EXCHANGE_RATE>
		               	{
		               		if (data($parametersOut/errorCode/text()) = 0) then
		               		( 		               		
		               			<REMITTANCE_STATUS>DISPONIBLE</REMITTANCE_STATUS>
		               		)
		               		else if (data($parametersOut/errorCode/text()) = 2) then
		               		(
		               			<REMITTANCE_STATUS>PAGADA</REMITTANCE_STATUS>
		               		)
		               		else
		               		(
		               		    <REMITTANCE_STATUS>{ data($parametersOut/errorMessage/text()) }</REMITTANCE_STATUS>
		               		)		               	
		               	}
               		    <REMITTANCE_AMOUNT>{ data($parametersOut/totalAmount/text()) }</REMITTANCE_AMOUNT>
               		    <REMITTANCE_SOURCE_AMOUNT>{ data($parametersOut/moreParameters/data[@fieldName=$montoLocal]/text())}</REMITTANCE_SOURCE_AMOUNT>
               		    <ORIGIN_COUNTRY>{data($parametersOut/moreParameters/data[@fieldName=$paisOrigen]/text()) }</ORIGIN_COUNTRY>
	                </ns0:consultaRemesasResponseRecordType>
	            </ns0:consultaRemesasResponseType>
	        </ns0:consultaRemesasResponse>
	    ) else (
	    	<ns0:consultaRemesasResponse/>
	    )
};

declare variable $parametersOut as element(*) external;
declare variable $paramEntradaRemesa as element(*) external;
declare variable $remetter as xs:string external;

xf:EnrutadorConveniosOut($parametersOut,
    $paramEntradaRemesa,
    $remetter)