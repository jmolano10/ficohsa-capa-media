xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAfiliacionCAPResponse" element="ns1:consultaAfiliacionCAPResponse" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAfiliacionCAPFacade/xq/consultaAfiliacionCAPFacadeOut/";

declare function xf:consultaAfiliacionCAPFacadeOut($consultaAfiliacionCAPResponse as element(ns1:consultaAfiliacionCAPResponse),
    $transactionId as xs:string,
    $sessionId as xs:string,
    $errorCode as xs:string,
    $validationMessage as xs:string)
    as element(ns0:procesaMensajeGenericoT24Response) {
        <ns0:procesaMensajeGenericoT24Response>
            <TRANSACTION_ID>{ $transactionId }</TRANSACTION_ID>
            <SESSION_ID>{ $sessionId }</SESSION_ID>
            {
            	if(upper-case($errorCode) = "SUCCESS")then(
            <MESSAGE>{ 
            	concat(
            		'Success||',
					fn:string-join((
                                $consultaAfiliacionCAPResponse/ID_CAP,
                                $consultaAfiliacionCAPResponse/ID_CLIENTE,
                                $consultaAfiliacionCAPResponse/ORIGEN_FONDOS,
                                $consultaAfiliacionCAPResponse/CUENTA_DESTINO,
                                $consultaAfiliacionCAPResponse/TIPO_ORIGEN_FONDOS,
                                $consultaAfiliacionCAPResponse/MONEDA,
                                $consultaAfiliacionCAPResponse/MONTO,
                     
		                        (: Formatear FECHA_AFILIACION a yyyyMMdd :)
                                  if ($consultaAfiliacionCAPResponse/FECHA_AFILIACION) then
                                    concat(
                                        fn:year-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION),
                                        if (fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION) < 10) then
                                            concat('0', fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION))
                                        else
                                            fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION),
                                        if (fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION) < 10) then
                                            concat('0', fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION))
                                        else
                                            fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_AFILIACION)
                                    )
                                else '',
                                
                                $consultaAfiliacionCAPResponse/TIEMPO_AFILIACION,
                                $consultaAfiliacionCAPResponse/FRECUENCIA_DEBITO,
                                
                                if($consultaAfiliacionCAPResponse/RENOVACION_AUTOMATICA = 0)then 'NO'
								else if ($consultaAfiliacionCAPResponse/RENOVACION_AUTOMATICA = 1)then 'SI'
								else ''
                                ,

                                (: Formatear FECHA_PRIMER_CREDITO a yyyyMMdd y manejar si está vacío :)
                                 if ($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO) then
                                    concat(
                                        fn:year-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO),
                                        if (fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO) < 10) then
                                            concat('0', fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO))
                                        else
                                            fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO),
                                        if (fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO) < 10) then
                                            concat('0', fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO))
                                        else
                                            fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_PRIMER_CREDITO)
                                    )
                                else '',
							
								if($consultaAfiliacionCAPResponse/NOTIFICACION_CORREO = 0)then 'NO'
								else if ($consultaAfiliacionCAPResponse/NOTIFICACION_CORREO = 1)then 'SI'
								else ''
                                ,
                                $consultaAfiliacionCAPResponse/ESTADO,
                                $consultaAfiliacionCAPResponse/CANAL_CREACION,
                                $consultaAfiliacionCAPResponse/OFICIAL_CREACION,
                                $consultaAfiliacionCAPResponse/OFICIAL_AUTORIZADOR,
                                $consultaAfiliacionCAPResponse/OFICIAL_MODIFICACION,
                                $consultaAfiliacionCAPResponse/OFICIAL_AUTORIZADOR_MODIFICADOR,
                                $consultaAfiliacionCAPResponse/AGENCIA,

                                (: Formatear FECHA_CAMBIO a yyyyMMdd y manejar si está vacío :)
                                    if ($consultaAfiliacionCAPResponse/FECHA_CAMBIO) then
                                    concat(
                                        fn:year-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO),
                                        if (fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO) < 10) then
                                            concat('0', fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO))
                                        else
                                            fn:month-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO),
                                        if (fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO) < 10) then
                                            concat('0', fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO))
                                        else
                                            fn:day-from-dateTime($consultaAfiliacionCAPResponse/FECHA_CAMBIO)
                                    )
                                else '',
                               $consultaAfiliacionCAPResponse/TRANSACCIONES_PENDIENTES,
                               $consultaAfiliacionCAPResponse/TRANSACCIONES_FALLIDAS,
                               $consultaAfiliacionCAPResponse/TRANSACCIONES_EXITOSAS
                            ), '@FM')
                        )
				}
			</MESSAGE>
            )else(			     
			     <MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
			     )
		 }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $consultaAfiliacionCAPResponse as element(ns1:consultaAfiliacionCAPResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:consultaAfiliacionCAPFacadeOut($consultaAfiliacionCAPResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $validationMessage)