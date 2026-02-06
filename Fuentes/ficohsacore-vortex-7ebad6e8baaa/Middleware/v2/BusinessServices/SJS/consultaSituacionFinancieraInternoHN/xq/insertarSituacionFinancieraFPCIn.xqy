xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:clientesFinancierosResponse" location="../../../FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace ns2 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns1 = "https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/insertarSituacionFinancieraFPCIn/";

declare function xf:insertarSituacionFinancieraFPCIn($outputParameters as element(ns1:clientesFinancierosResponse),
    $referenciaLlave as xs:string,
    $usuario as xs:string)
    as element(ns0:InputParameters) {
 <ns0:InputParameters>
            <ns0:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns0:PV_REFERENCIA_LLAVE>
            {
                for $PV_BANCO_REGION_OUT in $outputParameters/ns1:datos/ns1:bancoRegion
                return
                    <ns0:PV_REGION>{ data($PV_BANCO_REGION_OUT) }</ns0:PV_REGION>
            }
            <ns0:PV_USUARIO_SERVICIO>{ $usuario }</ns0:PV_USUARIO_SERVICIO>
            {
            	if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
            		<ns0:PT_APLICACION_CORE>
            		{
            			for $i in 1 to count($outputParameters/ns1:datos/ns1:cuentas)
                    	return(
                        	<ns0:PT_APLICACION_CORE_ITEM>FPC</ns0:PT_APLICACION_CORE_ITEM>
                    	)
            		}
            		</ns0:PT_APLICACION_CORE>
            	) else ()
            }
            {
            	if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
            		<ns0:PT_ACTIVO_PASIVO>
            		{
            			for $i in 1 to count($outputParameters/ns1:datos/ns1:cuentas)
                    	return(
                        	<ns0:PT_APLICACION_CORE_ITEM>ASSET</ns0:PT_APLICACION_CORE_ITEM>
                    	)
            		}
            		</ns0:PT_ACTIVO_PASIVO>
            	) else ()
            }
            {
            	if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
            		<ns0:PT_TIPO_PRODUCTO>
            		{
            			for $i in 1 to count($outputParameters/ns1:datos/ns1:cuentas)
                    	return(
                        	<ns0:PT_APLICACION_CORE_ITEM>FPC</ns0:PT_APLICACION_CORE_ITEM>
                    	)
            		}
            		</ns0:PT_TIPO_PRODUCTO>
            	) else ()
            }
            {
            	if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
            		<ns0:PT_CODIGO_MONEDA>
            		{
            			for $Currency in $outputParameters/ns1:datos/ns1:cuentas
                    	return(
                        	<ns0:PT_CODIGO_MONEDA_ITEM>{ fn:data($Currency/ns1:moneda) }</ns0:PT_CODIGO_MONEDA_ITEM>
                    	)
            		}
            		</ns0:PT_CODIGO_MONEDA>
            	) else ()
            }
            {
            	if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
            		<ns0:PT_SALDO_DISPONIBLE>
                	{
                    	for $PT_SALDO_TOTAL_ITEM in $outputParameters/ns1:datos/ns1:cuentas
                    	return(
                    		<ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($PT_SALDO_TOTAL_ITEM/ns1:saldoTotal) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                    	)
                	}
            		</ns0:PT_SALDO_DISPONIBLE>,
            		<ns0:PT_SALDO_TOTAL>
                	{
                    	for $PT_SALDO_TOTAL_ITEM in $outputParameters/ns1:datos/ns1:cuentas
                    	return(
                    		<ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($PT_SALDO_TOTAL_ITEM/ns1:saldoTotal) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                    	)
                	}
            		</ns0:PT_SALDO_TOTAL>
            	) else ()
            }
            {
            	if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
            		<ns0:PT_SUCCESS_INDICADOR_IN>
                	{
                    	for $i in 1 to count($outputParameters/ns1:datos/ns1:cuentas)
                    	return(
                        	<ns0:PT_APLICACION_CORE_ITEM>{ if(fn:data($outputParameters/ns1:error) = 'false')then('SUCCESS')else('ERROR') }</ns0:PT_APLICACION_CORE_ITEM>
                    	)
                	}
            		</ns0:PT_SUCCESS_INDICADOR_IN>
            	) else ()
           }
           {
           		if(fn:exists($outputParameters/ns1:datos/ns1:cuentas)) then (
           			<ns0:PT_DESCRIPCION_MENSAJE>
                	{
                    	for $i in 1 to count($outputParameters/ns1:datos/ns1:cuentas)
                    	return(
                        	<ns0:PT_DESCRIPCION_MENSAJE_ITEM>{ if(fn:data($outputParameters/ns1:error) = 'false')then('')else(fn:string($outputParameters/ns1:mensaje)) }</ns0:PT_DESCRIPCION_MENSAJE_ITEM>
                        )
                	}
            		</ns0:PT_DESCRIPCION_MENSAJE>
           		) else ()
           }
        </ns0:InputParameters>
};

declare variable $outputParameters as element(ns1:clientesFinancierosResponse) external;
declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;

xf:insertarSituacionFinancieraFPCIn($outputParameters,
    $referenciaLlave,
    $usuario)