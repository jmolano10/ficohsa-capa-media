(:: pragma bea:global-element-parameter parameter="$opConsultaSituacionFinancieraRespuesta" element="ns3:opConsultaSituacionFinancieraRespuesta" location="../../../CTS/consultaSituacionFinanciera/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../INTFC/insertarSituacionFinanciera/xsd/insertarSituacionFinanciera_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/insertarSituacionFinanciera";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoNI/xq/insertarSituacionFinancieraCTSIn/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobiscliente.ecobis.cobiscorp";

declare function getSuccessIndicator($code as xs:string) {
	if ($code = "0") then (
		"SUCCESS"
	) else (
		fn:concat("ERROR-", $code)
	)
};

declare function xf:insertarSituacionFinancieraCTSIn($referenciaLlave as xs:string,
    $usuario as xs:string,
    $opConsultaSituacionFinancieraRespuesta as element(ns3:opConsultaSituacionFinancieraRespuesta))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REFERENCIA_LLAVE>{ $referenciaLlave }</ns0:PV_REFERENCIA_LLAVE>
            <ns0:PV_REGION>NI01</ns0:PV_REGION>
            <ns0:PV_USUARIO_SERVICIO>{ $usuario }</ns0:PV_USUARIO_SERVICIO>
            <ns0:PT_APLICACION_CORE>
            {
                    for $codTipoRespuesta in 1 to count( $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:tipo union $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:tipo)
                    return
                          <ns0:PT_APLICACION_CORE_ITEM>COBIS</ns0:PT_APLICACION_CORE_ITEM>         
            }
              
            </ns0:PT_APLICACION_CORE>
            <ns0:PT_ACTIVO_PASIVO>
                {
                    for $activo in $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>ASSET</ns0:PT_APLICACION_CORE_ITEM>
                }
                                    {
                    for $activo in $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>LIABILITY</ns0:PT_APLICACION_CORE_ITEM>
                }    
            </ns0:PT_ACTIVO_PASIVO>
            <ns0:PT_TIPO_PRODUCTO>
                {
                    for $activo in $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:tipo
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>{ data($activo) }</ns0:PT_APLICACION_CORE_ITEM>
                }            
                {
                    for $activo in $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:tipo
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>{ data($activo) }</ns0:PT_APLICACION_CORE_ITEM>
                }
            </ns0:PT_TIPO_PRODUCTO>                             
            <ns0:PT_CODIGO_MONEDA>
                {
                    for $moneda in $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:moneda
                    return
                        <ns0:PT_CODIGO_MONEDA_ITEM>{ data($moneda) }</ns0:PT_CODIGO_MONEDA_ITEM>
                }
                {
                    for $monedapasiva in $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:moneda
                    return
                        <ns0:PT_CODIGO_MONEDA_ITEM>{ data($monedapasiva) }</ns0:PT_CODIGO_MONEDA_ITEM>
                }                
                
            </ns0:PT_CODIGO_MONEDA>
            <ns0:PT_SALDO_DISPONIBLE>
                {
                    for $disponible in $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:disponible
                    return
                        <ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($disponible) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                }
                {                                    
                    for $disponiblepasiva in 1 to count ($opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:tipo)
                    return
                        <ns0:PT_SALDO_DISPONIBLE_ITEM/>
                }                
            </ns0:PT_SALDO_DISPONIBLE>
            <ns0:PT_SALDO_TOTAL>
                {
                    for $total in $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:total
                    return
                        <ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($total) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                }
                {
                    for $totalpasiva in $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:total
                    return
                        <ns0:PT_SALDO_DISPONIBLE_ITEM>{ data($totalpasiva) }</ns0:PT_SALDO_DISPONIBLE_ITEM>
                }                
            </ns0:PT_SALDO_TOTAL>
            <ns0:PT_SUCCESS_INDICADOR_IN>
                {
                	let $successIndicator := fn:string($opConsultaSituacionFinancieraRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
                    for $codTipoRespuesta in 1 to count( $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:tipo union $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:tipo)
                    return
                        <ns0:PT_APLICACION_CORE_ITEM>{ getSuccessIndicator(data($successIndicator)) }</ns0:PT_APLICACION_CORE_ITEM>
                }
                         
            </ns0:PT_SUCCESS_INDICADOR_IN>
            <ns0:PT_DESCRIPCION_MENSAJE>
                {
                    let $messages := fn:string($opConsultaSituacionFinancieraRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
                    for $codTipoRespuesta in 1 to count( $opConsultaSituacionFinancieraRespuesta/ns1:detalleAssets/ns1:tipo union $opConsultaSituacionFinancieraRespuesta/ns1:detalleLiabilities/ns1:tipo)
                    return
                        <ns0:PT_DESCRIPCION_MENSAJE_ITEM>{ data($messages) }</ns0:PT_DESCRIPCION_MENSAJE_ITEM>
                }
            </ns0:PT_DESCRIPCION_MENSAJE>
        </ns0:InputParameters>
};

declare variable $referenciaLlave as xs:string external;
declare variable $usuario as xs:string external;
declare variable $opConsultaSituacionFinancieraRespuesta as element(ns3:opConsultaSituacionFinancieraRespuesta) external;

xf:insertarSituacionFinancieraCTSIn($referenciaLlave,
    $usuario,
    $opConsultaSituacionFinancieraRespuesta)
