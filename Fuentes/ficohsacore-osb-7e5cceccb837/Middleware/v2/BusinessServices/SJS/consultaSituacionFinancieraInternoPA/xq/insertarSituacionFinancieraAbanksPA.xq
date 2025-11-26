xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../ABKPA/obtenerSitFinanciera/xsd/obtenerSitFinanciera_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoPA/xq/insertarSituacionFinancieraAbanksPA/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSitFinanciera";

declare function xf:insertarSituacionFinancieraAbanksPA($outputParameters as element(ns1:OutputParameters),
     $referenciaLlave as xs:string,
    $usuario as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns0:PV_REFERENCIA_LLAVE>
	            {
	                for $PV_REGION in $outputParameters/ns1:PV_REGION
	                return
	                    <ns1:PV_REGION>{ data($PV_REGION) }</ns1:PV_REGION>
	            }
            <ns0:PV_USUARIO_SERVICIO>{ $usuario }</ns0:PV_USUARIO_SERVICIO>
            <ns0:PT_APLICACION_CORE>
            	{
            		for $PT_TIPO_PRODUCTO_CLI_ITEM in $outputParameters/ns1:PT_TIPO_PRODUCTO_CLI_OUT/ns1:PT_TIPO_PRODUCTO_CLI_ITEM
            		return
                		<ns0:PT_APLICACION_CORE_ITEM>ABK</ns0:PT_APLICACION_CORE_ITEM>
                }
            </ns0:PT_APLICACION_CORE>
            <ns0:PT_ACTIVO_PASIVO>
                {
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in $outputParameters/ns1:PT_TIPO_PRODUCTO_CLI_OUT/ns1:PT_TIPO_PRODUCTO_CLI_ITEM
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>{ data($PT_TIPO_PRODUCTO_CLI_ITEM) }</ns0:PT_APLICACION_CORE_ITEM>
                }
            </ns0:PT_ACTIVO_PASIVO>
            <ns0:PT_TIPO_PRODUCTO>
                {
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in $outputParameters/ns1:PT_TIPO_PRODUCTO_OUT/ns1:PT_TIPO_PRODUCTO_CLI_ITEM
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>{ data($PT_TIPO_PRODUCTO_CLI_ITEM) }</ns0:PT_APLICACION_CORE_ITEM>
                }
            </ns0:PT_TIPO_PRODUCTO>
            <ns0:PT_CODIGO_MONEDA>
                {
                    for $PT_CODIGO_MONEDA_ITEM in $outputParameters/ns1:PT_CODIGO_MONEDA/ns1:PT_CODIGO_MONEDA_ITEM
                    return
                        <ns0:PT_CODIGO_MONEDA_ITEM>{ data($PT_CODIGO_MONEDA_ITEM) }</ns0:PT_CODIGO_MONEDA_ITEM>
                }
            </ns0:PT_CODIGO_MONEDA>
            <ns0:PT_SALDO_DISPONIBLE>
                {
                    for $PT_SALDO_DISPONIBLE_ITEM in $outputParameters/ns1:PT_SALDO_DISPONIBLE/ns1:PT_SALDO_DISPONIBLE_ITEM
                    return
                        <ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($PT_SALDO_DISPONIBLE_ITEM) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                }
            </ns0:PT_SALDO_DISPONIBLE>
            <ns0:PT_SALDO_TOTAL>
                {
                    for $PT_SALDO_DISPONIBLE_ITEM in $outputParameters/ns1:PT_SALDO_TOTAL/ns1:PT_SALDO_DISPONIBLE_ITEM
                    return
                        <ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($PT_SALDO_DISPONIBLE_ITEM) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                }
            </ns0:PT_SALDO_TOTAL>
            <ns0:PT_SUCCESS_INDICADOR_IN>
                {
                    let $successIndicator := fn:string($outputParameters/ns1:PV_SUCCESS_INDICATOR/text())
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in 1 to count($outputParameters/ns1:PT_TIPO_PRODUCTO_CLI_OUT/ns1:PT_TIPO_PRODUCTO_CLI_ITEM)
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>{ $successIndicator }</ns0:PT_APLICACION_CORE_ITEM>
                }
            </ns0:PT_SUCCESS_INDICADOR_IN>
            <ns0:PT_DESCRIPCION_MENSAJE>
                {
                    let $messages := fn:string($outputParameters/ns1:PV_MENSAJE_ERROR/text())
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in 1 to count($outputParameters/ns1:PT_TIPO_PRODUCTO_CLI_OUT/ns1:PT_TIPO_PRODUCTO_CLI_ITEM)
                    return
                        <ns0:PT_DESCRIPCION_MENSAJE_ITEM>{ $messages }</ns0:PT_DESCRIPCION_MENSAJE_ITEM>
                }
            </ns0:PT_DESCRIPCION_MENSAJE>
        </ns0:InputParameters>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;

xf:insertarSituacionFinancieraAbanksPA($outputParameters,
	$referenciaLlave,
    $usuario)
