xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opPagoTarjetaCreditoRespuesta1" element="ns2:opPagoTarjetaCreditoRespuesta" location="../../../../v3/BusinessServices/CTS/tarjetaCredito/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns1:pagoTarjetaCreditoResponse" location="../xsd/pagoTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobiscanalesentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobistarjetacreditov3.ecobis.cobiscorp";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoTarjetaCreditoType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/pagoTarjetaCreditoOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://dto2.commons.ecobis.cobiscorp";

declare function xf:pagoTarjetaCreditoOut($opPagoTarjetaCreditoRespuesta1 as element(ns2:opPagoTarjetaCreditoRespuesta), $balanceCurrency as xs:string, $transactionCurrency as xs:string)
    as element(ns1:pagoTarjetaCreditoResponse) {
        <ns1:pagoTarjetaCreditoResponse>
            <TRANSACTION_CURRENCY>{ $transactionCurrency }</TRANSACTION_CURRENCY>
            <BALANCE_CURRENCY>{ $balanceCurrency }</BALANCE_CURRENCY>
            {
                for $valMontoPago in $opPagoTarjetaCreditoRespuesta1/ns0:resulsetPagoTarjetaCredito/ns0:valMontoPago
                return
                if(string($valMontoPago/text()) != '')then(
                    <BALANCE_PAYMENT>{ data($valMontoPago) }</BALANCE_PAYMENT>
                )else()
            }
            {
                for $monedaCuenta in $opPagoTarjetaCreditoRespuesta1/ns0:resulsetPagoTarjetaCredito/ns0:monedaCuenta
                return
                    <DEBIT_CURRENCY>{ data($monedaCuenta) }</DEBIT_CURRENCY>
            }
            {
                for $montoADebitar in $opPagoTarjetaCreditoRespuesta1/ns0:resulsetPagoTarjetaCredito/ns0:montoADebitar
                return
                if(string($montoADebitar/text()) != '')then(
                    <DEBIT_AMOUNT>{ data($montoADebitar) }</DEBIT_AMOUNT>
                )else()
            }
            {
            	for $exchangeRate in $opPagoTarjetaCreditoRespuesta1/ns0:resulsetPagoTarjetaCredito/ns0:tasaCambio
            	return
            	if(string($exchangeRate/text()) != '')then(
            		<EXCHANGE_RATE>{ data($exchangeRate) }</EXCHANGE_RATE>
            	)else() 
            }
            {
                for $numCuenta in $opPagoTarjetaCreditoRespuesta1/ns0:resulsetPagoTarjetaCredito/ns0:numCuenta
                return
                    <DEBIT_ACCOUNT>{ data($numCuenta) }</DEBIT_ACCOUNT>
            }
            {
                for $fechaTransaccion in string($opPagoTarjetaCreditoRespuesta1/ns0:resulsetPagoTarjetaCredito/ns0:fechaTransaccion/text())
                return
                if($fechaTransaccion != '')then(
                	<DATE_TIME>{ fn-bea:dateTime-from-string-with-format('yyyy-MM-dd HH:mm:ss.SSS', $fechaTransaccion) }</DATE_TIME>
                )else()
            }
        </ns1:pagoTarjetaCreditoResponse>
};

declare variable $opPagoTarjetaCreditoRespuesta1 as element(ns2:opPagoTarjetaCreditoRespuesta) external;
declare variable $balanceCurrency as xs:string external;
declare variable $transactionCurrency as xs:string external;

xf:pagoTarjetaCreditoOut($opPagoTarjetaCreditoRespuesta1, $balanceCurrency, $transactionCurrency)