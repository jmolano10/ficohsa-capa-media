xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../MasterData/conConsultaSituacionFinanciera/xsd/conConsultaSituacionFinanciera_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoPA/xq/insertarSituacionFinancieraMasterDataIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conConsultaSituacionFinanciera";

declare function getSuccessIndicator($code as xs:string) {
	if ($code = "0") then (
		"SUCCESS"
	) else (
		fn:concat("ERROR-", $code)
	)
};

declare function xf:insertarSituacionFinancieraMasterDataIn($outputParameters1 as element(ns1:OutputParameters),
    $referenciaLlave as xs:string,
    $usuario as xs:string)
    as element(ns0:InputParameters) {
          <ns0:InputParameters>
           { 
              let $response := fn:string($outputParameters1/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name=""]/text())
              let $responseXML := fn-bea:inlinedXML($response)
              return (
                        <ns0:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns0:PV_REFERENCIA_LLAVE>,
	            		<ns0:PV_REGION>{ fn:string($responseXML/REGION/text()) }</ns0:PV_REGION>,
            			<ns0:PV_USUARIO_SERVICIO>{ $usuario }</ns0:PV_USUARIO_SERVICIO>,
			            <ns0:PT_APLICACION_CORE>
			                    <ns0:PT_APLICACION_CORE_ITEM>MasterData</ns0:PT_APLICACION_CORE_ITEM>
			                    <ns0:PT_APLICACION_CORE_ITEM>MasterData</ns0:PT_APLICACION_CORE_ITEM>
			            </ns0:PT_APLICACION_CORE>,
			            <ns0:PT_ACTIVO_PASIVO>
			                    <ns0:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/PRODUCT_TYPE/text()) }</ns0:PT_APLICACION_CORE_ITEM>
			                    <ns0:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/PRODUCT_TYPE/text()) }</ns0:PT_APLICACION_CORE_ITEM>
			            </ns0:PT_ACTIVO_PASIVO>,
			            <ns0:PT_TIPO_PRODUCTO>
			                    <ns0:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/TYPE/text()) }</ns0:PT_APLICACION_CORE_ITEM>
			                    <ns0:PT_APLICACION_CORE_ITEM>{ fn:string($responseXML/TYPE/text()) }</ns0:PT_APLICACION_CORE_ITEM>
			            </ns0:PT_TIPO_PRODUCTO>,
			            <ns0:PT_CODIGO_MONEDA>
			                    <ns0:PT_CODIGO_MONEDA_ITEM>{ fn:string($responseXML/CURRENCY_CODE/text()) }</ns0:PT_CODIGO_MONEDA_ITEM>
			                    <ns0:PT_CODIGO_MONEDA_ITEM>USD</ns0:PT_CODIGO_MONEDA_ITEM>
			            </ns0:PT_CODIGO_MONEDA>,
			            <ns0:PT_SALDO_DISPONIBLE>
			                    <ns0:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/LOCAL_BALANCE/text()) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
			                    <ns0:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/FOREIGN_BALANCE/text()) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
			            </ns0:PT_SALDO_DISPONIBLE>,
			            <ns0:PT_SALDO_TOTAL>
			                    <ns0:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/LOCAL_BALANCE/text()) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
			                    <ns0:PT_SALDO_DISPONIBLE_ITEM>{ fn:string($responseXML/FOREIGN_BALANCE/text()) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
			            </ns0:PT_SALDO_TOTAL>,
			            <ns0:PT_SUCCESS_INDICADOR_IN>
			                    <ns0:PT_APLICACION_CORE_ITEM>{ getSuccessIndicator(fn:string($responseXML/MESSAGE_CODE/text())) }</ns0:PT_APLICACION_CORE_ITEM>
			                    <ns0:PT_APLICACION_CORE_ITEM>{ getSuccessIndicator(fn:string($responseXML/MESSAGE_CODE/text())) }</ns0:PT_APLICACION_CORE_ITEM>
			            </ns0:PT_SUCCESS_INDICADOR_IN>,
			            <ns0:PT_DESCRIPCION_MENSAJE>
			                    <ns0:PT_DESCRIPCION_MENSAJE_ITEM>{ fn:string($responseXML/MESSAGE/text()) }</ns0:PT_DESCRIPCION_MENSAJE_ITEM>
			                    <ns0:PT_DESCRIPCION_MENSAJE_ITEM>{ fn:string($responseXML/MESSAGE/text()) }</ns0:PT_DESCRIPCION_MENSAJE_ITEM>
			            </ns0:PT_DESCRIPCION_MENSAJE>
            )
           }
        </ns0:InputParameters>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;

xf:insertarSituacionFinancieraMasterDataIn($outputParameters1,
    $referenciaLlave,
    $usuario)