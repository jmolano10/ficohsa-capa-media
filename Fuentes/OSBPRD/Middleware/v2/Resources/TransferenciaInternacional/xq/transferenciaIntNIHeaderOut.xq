(:: pragma bea:global-element-parameter parameter="$opTransferenciaInternacionalRespuesta" element="ns0:opTransferenciaInternacionalRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaInternacional/xq/transferenciaIntNIHeaderOut/";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function convertirStringFechaString($stringDate as xs:string?)
	as xs:string {
		if (fn-bea:trim($stringDate) != '') then 
			let $date := fn-bea:date-from-string-with-format("yyyy-MM-dd", $stringDate)
			return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
		else ("")
};

declare function xf:transferenciaIntNIHeaderOut($opTransferenciaInternacionalRespuesta as element(ns0:opTransferenciaInternacionalRespuesta))
    as element(ns4:ResponseHeader) {
        <ns4:ResponseHeader>
        	{
                if(fn:string($opTransferenciaInternacionalRespuesta/ns2:idTransaccion/text()) != "") then (
                	<transactionId>{ data($opTransferenciaInternacionalRespuesta/ns2:idTransaccion) }</transactionId>
                ) else ()
            }
            {
                let $successIndicator := fn:string($opTransferenciaInternacionalRespuesta/ns2:contextoRespuesta/ns2:codTipoRespuesta/text())
                let $message := fn:string($opTransferenciaInternacionalRespuesta/ns2:contextoRespuesta/ns2:valDescripcionRespuesta/text())
                return 
                    if ($successIndicator  = "0") then (
                        <successIndicator>Success</successIndicator>
                    ) else (
                        <successIndicator>{ $successIndicator }</successIndicator>,
                        <messages>{ $message }</messages>
                    )                 
            }
            {
                if(fn:string($opTransferenciaInternacionalRespuesta/ns2:fechaTransaccion/text()) != "") then (
                	<valueDate>{ convertirStringFechaString(data($opTransferenciaInternacionalRespuesta/ns2:fechaTransaccion)) }</valueDate>
                ) else ()
            }
        </ns4:ResponseHeader>
};

declare variable $opTransferenciaInternacionalRespuesta as element(ns0:opTransferenciaInternacionalRespuesta) external;

xf:transferenciaIntNIHeaderOut($opTransferenciaInternacionalRespuesta)