<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opTransferenciaRegionalRespuesta" element="ns3:opTransferenciaRegionalRespuesta" location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/TransferenciaIntergrupalNIHeaderOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://service.srvaplcobistransferencia.ecobis.cobiscorp";

declare function convertirStringFechaString($stringDate as xs:string?)
	as xs:string {
		if (fn-bea:trim($stringDate) != '') then 
			let $date := fn-bea:date-from-string-with-format("dd/MM/yyyy", $stringDate)
			return fn-bea:date-to-string-with-format("yyyyMMdd", $date)  
		else ("")
};

declare function xf:TransferenciaIntergrupalNIHeaderOut($opTransferenciaRegionalRespuesta as element(ns3:opTransferenciaRegionalRespuesta))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
        	{
	        	if ($opTransferenciaRegionalRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text() = "0") then
	            	<transactionId>{ $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:referencia/text() }</transactionId>
	            else
	            ()
            }
            {
                for $codTipoRespuesta in $opTransferenciaRegionalRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta
                return
                    <successIndicator>
                        {
                            if (data($codTipoRespuesta) = 0) then
                                ("SUCCESS")
                            else 
                                ($codTipoRespuesta/text())
                        }
					</successIndicator>
            }
            {
				if ($opTransferenciaRegionalRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text() = "0") then 
				() 
				else
				( 
		                for $valDescripcionRespuesta in $opTransferenciaRegionalRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta
		                return
		                    <messages>{ data($valDescripcionRespuesta) }</messages>
	            )
            }
            {
                for $fechaAplicacion in $opTransferenciaRegionalRespuesta/ns1:transferenciaRegional/ns1:fechaAplicacion
                return
                    <valueDate>{ convertirStringFechaString(data($fechaAplicacion)) }</valueDate>
            }
        </ns0:ResponseHeader>
};


declare variable $opTransferenciaRegionalRespuesta as element(ns3:opTransferenciaRegionalRespuesta) external;

xf:TransferenciaIntergrupalNIHeaderOut($opTransferenciaRegionalRespuesta)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/CTS/transferencia/xsd/services.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CTS/transferencia/xsd/services"/>
    </con:dependency>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
</con:xqueryEntry>