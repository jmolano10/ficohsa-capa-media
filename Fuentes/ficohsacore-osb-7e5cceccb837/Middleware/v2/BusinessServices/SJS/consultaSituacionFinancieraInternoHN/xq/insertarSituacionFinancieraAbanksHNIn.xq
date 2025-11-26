(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../ABK/consultaSituacionFinanciera/xsd/consultaSituacionFinanciera_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSituacionFinanciera";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/insertarSituacionFinancieraAbanksHNIn/";

declare function xf:insertarSituacionFinancieraAbanksHNIn($outputParameters as element(ns0:OutputParameters),
    $referenciaLlave as xs:string,
    $usuario as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns1:PV_REFERENCIA_LLAVE>
	            {
	                for $PV_REGION in $outputParameters/ns0:PV_REGION
	                return
	                    <ns1:PV_REGION>{ data($PV_REGION) }</ns1:PV_REGION>
	            }
            <ns1:PV_USUARIO_SERVICIO>{ $usuario }</ns1:PV_USUARIO_SERVICIO>
            <ns1:PT_APLICACION_CORE>
            	{
            		for $PT_TIPO_PRODUCTO_CLI_ITEM in $outputParameters/ns0:PT_TIPO_PRODUCTO_CLI_OUT/ns0:PT_TIPO_PRODUCTO_CLI_ITEM
            		return
                		<ns1:PT_APLICACION_CORE_ITEM>ABK</ns1:PT_APLICACION_CORE_ITEM>
                }
            </ns1:PT_APLICACION_CORE>
            <ns1:PT_ACTIVO_PASIVO>
                {
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in $outputParameters/ns0:PT_TIPO_PRODUCTO_CLI_OUT/ns0:PT_TIPO_PRODUCTO_CLI_ITEM
                    return
                        <ns1:PT_APLICACION_CORE_ITEM>{ data($PT_TIPO_PRODUCTO_CLI_ITEM) }</ns1:PT_APLICACION_CORE_ITEM>
                }
            </ns1:PT_ACTIVO_PASIVO>
            <ns1:PT_TIPO_PRODUCTO>
                {
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in $outputParameters/ns0:PT_TIPO_PRODUCTO_OUT/ns0:PT_TIPO_PRODUCTO_CLI_ITEM
                    return
                        <ns1:PT_APLICACION_CORE_ITEM>{ data($PT_TIPO_PRODUCTO_CLI_ITEM) }</ns1:PT_APLICACION_CORE_ITEM>
                }
            </ns1:PT_TIPO_PRODUCTO>
            <ns1:PT_CODIGO_MONEDA>
                {
                    for $PT_CODIGO_MONEDA_ITEM in $outputParameters/ns0:PT_CODIGO_MONEDA/ns0:PT_CODIGO_MONEDA_ITEM
                    return
                        <ns1:PT_CODIGO_MONEDA_ITEM>{ data($PT_CODIGO_MONEDA_ITEM) }</ns1:PT_CODIGO_MONEDA_ITEM>
                }
            </ns1:PT_CODIGO_MONEDA>
            <ns1:PT_SALDO_DISPONIBLE>
                {
                    for $PT_SALDO_DISPONIBLE_ITEM in $outputParameters/ns0:PT_SALDO_DISPONIBLE/ns0:PT_SALDO_DISPONIBLE_ITEM
                    return
                        <ns1:PT_SALDO_DISPONIBLE_ITEM>{ data($PT_SALDO_DISPONIBLE_ITEM) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
                }
            </ns1:PT_SALDO_DISPONIBLE>
            <ns1:PT_SALDO_TOTAL>
                {
                    for $PT_SALDO_DISPONIBLE_ITEM in $outputParameters/ns0:PT_SALDO_TOTAL/ns0:PT_SALDO_DISPONIBLE_ITEM
                    return
                        <ns1:PT_SALDO_DISPONIBLE_ITEM>{ data($PT_SALDO_DISPONIBLE_ITEM) }</ns1:PT_SALDO_DISPONIBLE_ITEM>
                }
            </ns1:PT_SALDO_TOTAL>
            <ns1:PT_SUCCESS_INDICADOR_IN>
                {
                    let $successIndicator := fn:string($outputParameters/ns0:PV_SUCCESS_INDICATOR/text())
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in 1 to count($outputParameters/ns0:PT_TIPO_PRODUCTO_CLI_OUT/ns0:PT_TIPO_PRODUCTO_CLI_ITEM)
                    return
                        <ns1:PT_APLICACION_CORE_ITEM>{ $successIndicator }</ns1:PT_APLICACION_CORE_ITEM>
                }
            </ns1:PT_SUCCESS_INDICADOR_IN>
            <ns1:PT_DESCRIPCION_MENSAJE>
                {
                    let $messages := fn:string($outputParameters/ns0:PV_MENSAJE_ERROR/text())
                    for $PT_TIPO_PRODUCTO_CLI_ITEM in 1 to count($outputParameters/ns0:PT_TIPO_PRODUCTO_CLI_OUT/ns0:PT_TIPO_PRODUCTO_CLI_ITEM)
                    return
                        <ns1:PT_DESCRIPCION_MENSAJE_ITEM>{ $messages }</ns1:PT_DESCRIPCION_MENSAJE_ITEM>
                }
            </ns1:PT_DESCRIPCION_MENSAJE>
        </ns1:InputParameters>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;

xf:insertarSituacionFinancieraAbanksHNIn($outputParameters,
    $referenciaLlave,
    $usuario)
