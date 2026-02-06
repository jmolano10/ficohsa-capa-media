xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opPagoTarjetaCreditoRespuesta" element="ns1:opPagoTarjetaCreditoRespuesta" location="../../../BusinessServices/CTS/pagoTarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:pagoTarjetaCreditoResponse" location="../../../../Business_Resources/tarjetaCredito/PagoTarjetaCredito/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobiscanalesentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobistarjetacreditov2.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoTarjetaCredito/xq/pagoTCNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoTypes";

declare function FormatoFecha($fecha) {

let $FechaDate  :=  fn-bea:dateTime-from-string-with-format("yyyy-MM-dd HH:mm", $fecha)
let $NuevaFecha :=  fn-bea:dateTime-to-string-with-format("yyyyMMddHHmm", $FechaDate)
return $NuevaFecha
};

declare function xf:pagoTCNIOut($opPagoTarjetaCreditoRespuesta as element(ns1:opPagoTarjetaCreditoRespuesta))
    as element(ns3:pagoTarjetaCreditoResponse) {
        <ns3:pagoTarjetaCreditoResponse>
        	{
        		for $montoADebitar in $opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:montoADebitar	
        		return
        		<LCY_PAYMENT>{ fn:round-half-to-even(xs:decimal(data($montoADebitar)), 2) }</LCY_PAYMENT>
        	}
            
            {
                for $monedaCuenta in $opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:monedaCuenta
                return
                    <PAYMENT_CURRENCY>{ data($monedaCuenta) }</PAYMENT_CURRENCY>
            }
            {
            	for $valMontoPago in $opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:valMontoPago
            	return
            	 <BALANCE_PAYMENT>{ fn:round-half-to-even(xs:decimal(data($valMontoPago)), 2) }</BALANCE_PAYMENT>
            }
           
            {
                for $monedaPago in $opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:monedaPago
                return
                    <BALANCE_CURRENCY>{ data($monedaPago) }</BALANCE_CURRENCY>
            }
            <EXCHANGE_RATE>
            	{ 
            		let $tasaCambio := fn:string($opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:tasaCambio/text())
            			return
            				if($tasaCambio != '') then(
                			$tasaCambio
	                		) else (
	                		 	1.00
	                		)
            	}
            </EXCHANGE_RATE>
            {
                for $numCuenta in $opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:numCuenta
                return
                    <DEBIT_ACCOUNT>{ data($numCuenta) }</DEBIT_ACCOUNT>
            }
            {
                for $fechaTransaccion in $opPagoTarjetaCreditoRespuesta/ns0:resulsetPagoTarjetaCredito/ns0:fechaTransaccion
                return
                    <DATE_TIME>{FormatoFecha(data($fechaTransaccion)) }</DATE_TIME>
            }
           
        </ns3:pagoTarjetaCreditoResponse>
};

declare variable $opPagoTarjetaCreditoRespuesta as element(ns1:opPagoTarjetaCreditoRespuesta) external;

xf:pagoTCNIOut($opPagoTarjetaCreditoRespuesta)