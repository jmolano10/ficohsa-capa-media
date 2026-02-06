xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../VASA/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSituacionFinanciera";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoGT/xq/insertarSituacionFinancieraVasaIn/";


declare function getSuccessIndicator($code as xs:string) {
	if ($code = "0") then (
		"SUCCESS"
	) else (
		fn:concat("ERROR-", $code)
	)
};

declare function xf:insertarSituacionFinancieraVasaIn($outputParameters as element(ns0:OutputParameters),
    $referenciaLlave as xs:string,
    $usuario as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
	            let $response := fn:string($outputParameters/ns0:RowSet[1]/ns0:Row[1]/ns0:Column[@name="LIABILITY_DETAILS"]/text())
				let $responseXML := fn-bea:inlinedXML($response)
	            	return (
	            		<ns1:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns1:PV_REFERENCIA_LLAVE>,
	            		<ns1:PV_REGION>{ fn:string($responseXML/REGION/text()) }</ns1:PV_REGION>,
            			<ns1:PV_USUARIO_SERVICIO>{ $usuario }</ns1:PV_USUARIO_SERVICIO>,
			            <ns1:PT_APLICACION_CORE>
			                    <ns1:PT_APLICACION_CORE_ITEM>VASA</ns1:PT_APLICACION_CORE_ITEM>
			                    <ns1:PT_APLICACION_CORE_ITEM>VASA</ns1:PT_APLICACION_CORE_ITEM>
			            </ns1:PT_APLICACION_CORE>,
			            <ns1:PT_ACTIVO_PASIVO>
			                    <ns1:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/PRODUCT_TYPE/text()) }</ns1:PT_APLICACION_CORE_ITEM>
			                    <ns1:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/PRODUCT_TYPE/text()) }</ns1:PT_APLICACION_CORE_ITEM>
			            </ns1:PT_ACTIVO_PASIVO>,
			            <ns1:PT_TIPO_PRODUCTO>
			                    <ns1:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/TYPE/text()) }</ns1:PT_APLICACION_CORE_ITEM>
			                    <ns1:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/TYPE/text()) }</ns1:PT_APLICACION_CORE_ITEM>
			            </ns1:PT_TIPO_PRODUCTO>,
			            <ns1:PT_CODIGO_MONEDA>
			                    <ns1:PT_CODIGO_MONEDA_ITEM>{ fn:string($responseXML/CURRENCY_CODE/text()) }</ns1:PT_CODIGO_MONEDA_ITEM>
			                    <ns1:PT_CODIGO_MONEDA_ITEM>USD</ns1:PT_CODIGO_MONEDA_ITEM>
			            </ns1:PT_CODIGO_MONEDA>,
			            <ns1:PT_SALDO_DISPONIBLE>
			                    <ns1:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/LOCAL_BALANCE/text()) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
			                    <ns1:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/FOREIGN_BALANCE/text()) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
			            </ns1:PT_SALDO_DISPONIBLE>,
			            <ns1:PT_SALDO_TOTAL>
			                    <ns1:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/LOCAL_BALANCE/text()) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
			                    <ns1:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/FOREIGN_BALANCE/text()) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
			            </ns1:PT_SALDO_TOTAL>,
			            <ns1:PT_SUCCESS_INDICADOR_IN>
			                    <ns1:PT_APLICACION_CORE_ITEM>{ getSuccessIndicator(fn:string($responseXML/MESSAGE_CODE/text())) }</ns1:PT_APLICACION_CORE_ITEM>
			                    <ns1:PT_APLICACION_CORE_ITEM>{ getSuccessIndicator(fn:string($responseXML/MESSAGE_CODE/text())) }</ns1:PT_APLICACION_CORE_ITEM>
			            </ns1:PT_SUCCESS_INDICADOR_IN>,
			            <ns1:PT_DESCRIPCION_MENSAJE>
			                    <ns1:PT_DESCRIPCION_MENSAJE_ITEM>{ fn:string($responseXML/MESSAGE/text()) }</ns1:PT_DESCRIPCION_MENSAJE_ITEM>
			                    <ns1:PT_DESCRIPCION_MENSAJE_ITEM>{ fn:string($responseXML/MESSAGE/text()) }</ns1:PT_DESCRIPCION_MENSAJE_ITEM>
			            </ns1:PT_DESCRIPCION_MENSAJE>
					)
			}	
        </ns1:InputParameters>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;

xf:insertarSituacionFinancieraVasaIn($outputParameters,
    $referenciaLlave,
    $usuario)