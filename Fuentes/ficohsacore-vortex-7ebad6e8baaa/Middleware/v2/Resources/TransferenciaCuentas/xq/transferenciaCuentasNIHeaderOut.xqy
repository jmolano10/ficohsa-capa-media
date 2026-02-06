xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opTransferenciaCuentaRespuesta" element="ns3:opTransferenciaCuentaRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaCuentasNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function convertirStringFechaString($stringDate as xs:string?)
	as xs:string {
		if (fn-bea:trim($stringDate) != '') then 
			let $date := fn-bea:date-from-string-with-format("yyyy-MM-dd", $stringDate)
			return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
		else ("")
};

declare function xf:transferenciaCuentasNIHeaderOut($opTransferenciaCuentaRespuesta as element(ns3:opTransferenciaCuentaRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
                if(fn:string($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:idTransaccion/text()) != "") then (
                	<transactionId>{ data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:idTransaccion) }</transactionId>
                ) else ()
            }
        	{
            	let $successIndicator := fn:string($opTransferenciaCuentaRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
            	let $message := fn:string($opTransferenciaCuentaRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta/text())
            	return 
	            	if ($successIndicator  = "0") then (
	            		<successIndicator>Success</successIndicator>
	            	) else (
	            		<successIndicator>{ $successIndicator }</successIndicator>,
	            		<messages>{ $message }</messages>
	            	) 
            }
            {
                if(fn:string($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:fechaValor/text()) != "") then (
                	<valueDate>{ convertirStringFechaString(data($opTransferenciaCuentaRespuesta/ns1:transaccionCuenta/ns1:fechaValor)) }</valueDate>
                ) else ()
            }
        </ns0:ResponseHeader>
};

declare variable $opTransferenciaCuentaRespuesta as element(ns3:opTransferenciaCuentaRespuesta) external;

xf:transferenciaCuentasNIHeaderOut($opTransferenciaCuentaRespuesta)