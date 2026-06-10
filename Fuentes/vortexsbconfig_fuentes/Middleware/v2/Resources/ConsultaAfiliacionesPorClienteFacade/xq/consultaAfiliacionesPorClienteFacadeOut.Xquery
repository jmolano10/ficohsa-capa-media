<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAfiliacionesPorClienteResponse" element="ns1:consultaAfiliacionesPorClienteResponse" location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoT24Response" location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCAPTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAfiliacionesPorClienteFacade/xq/consultaAfiliacionesPorClienteFacadeOut/";

declare function xf:consultaAfiliacionesPorClienteFacadeOut($consultaAfiliacionesPorClienteResponse as element(ns1:consultaAfiliacionesPorClienteResponse),
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
		                               string-join((
		                               for $afiliacion in $consultaAfiliacionesPorClienteResponse/LISTA_AFILIACIONES/AFILIACION
			                               return
			                               	fn:string-join(
			                               		(
			                               			$afiliacion/CUENTA_AP,
			                               			$afiliacion/ID_CLIENTE,
			                               			$afiliacion/MONEDA,
			                               			(: Formatear FECHA_AFILIACION a yyyyMMdd :)
					                                if ($afiliacion/FECHA_AFILIACION) then
					                                    concat(
					                                        fn:year-from-dateTime($afiliacion/FECHA_AFILIACION),
					                                        if (fn:month-from-dateTime($afiliacion/FECHA_AFILIACION) < 10) then
					                                            concat('0', fn:month-from-dateTime($afiliacion/FECHA_AFILIACION))
					                                        else
					                                            fn:month-from-dateTime($afiliacion/FECHA_AFILIACION),
					                                        if (fn:day-from-dateTime($afiliacion/FECHA_AFILIACION) < 10) then
					                                            concat('0', fn:day-from-dateTime($afiliacion/FECHA_AFILIACION))
					                                        else
					                                            fn:day-from-dateTime($afiliacion/FECHA_AFILIACION)
					                                    )
					                                else '',
			                               			$afiliacion/MONTO,
			                               			$afiliacion/TIEMPO_AFILIACION
			                               ),'@FM')
	                              ),'@GM')
		                      )
						}
					</MESSAGE>
	            )else(			     
				     <MESSAGE>{concat('ERROR|', $validationMessage)}</MESSAGE>
				     )
		 }
        </ns0:procesaMensajeGenericoT24Response>
};

declare variable $consultaAfiliacionesPorClienteResponse as element(ns1:consultaAfiliacionesPorClienteResponse) external;
declare variable $transactionId as xs:string external;
declare variable $sessionId as xs:string external;
declare variable $errorCode as xs:string external;
declare variable $validationMessage as xs:string external;

xf:consultaAfiliacionesPorClienteFacadeOut($consultaAfiliacionesPorClienteResponse,
    $transactionId,
    $sessionId,
    $errorCode,
    $validationMessage)]]></con:xquery>
    <con:dependency location="../../OperacionesCAP/xsd/operacionesCAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesCAP/xsd/operacionesCAPTypes"/>
    </con:dependency>
    <con:dependency location="../../ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
</con:xqueryEntry>