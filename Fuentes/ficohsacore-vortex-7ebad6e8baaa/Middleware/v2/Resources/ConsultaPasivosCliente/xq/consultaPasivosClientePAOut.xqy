xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataPA/conDatosTarjetaCliente/xsd/conDatosTarjetaCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:consultaPasivosClienteResponse" location="../xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClientePAOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaCliente";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaPrestamos";

declare function xf:consultaPasivosClientePAOut($outputParameters1 as element(ns0:OutputParameters),
    $outputParameters2 as element(ns1:OutputParameters))
    as element(ns2:consultaPasivosClienteResponse) {
        <ns2:consultaPasivosClienteResponse>
           {
	        	if (fn:string($outputParameters2/ns1:ERROR_CODE/text()) = "SUCCESS") then ( 
		        	<ns2:consultaPasivosClientePrestamosResponseType>
		        	{	
		        		for $item at $i in $outputParameters2/ns1:LIABILITY_NUMBER/ns1:LIABILITY_NUMBER_ITEM
		        		return
		        		<ns2:consultaPasivosClienteResponseRecordType>
			                    <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
			                    <LIABILITY_NUMBER>{ fn:string($outputParameters2/ns1:LIABILITY_NUMBER/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_NUMBER>
			                    <LIABILITY_CUST_NAME>{ fn:string($outputParameters2/ns1:LIABILITY_CUST_NAME/ns1:LIABILITY_CUST_NAME_ITEM[$i]/text()) }</LIABILITY_CUST_NAME>
			                    <LIABILITY_CURRENCY_1>{ fn:string($outputParameters2/ns1:LIABILITY_CURRENCY_1/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_CURRENCY_1>
			                    <LIABILITY_PRINCIPAL_AMT_1>{ fn:string($outputParameters2/ns1:LIABILITY_PRINCIPAL_AMT_1/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_PRINCIPAL_AMT_1>
			                    <LIABILITY_INT_COM_AMT_1>{ fn:string($outputParameters2/ns1:LIABILITY_INT_COM_AMT_1/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_INT_COM_AMT_1>
			                    <LIABILITY_TOTAL_AMT_1>{ fn:string($outputParameters2/ns1:LIABILITY_TOTAL_AMT_1/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_TOTAL_AMT_1>
			                    <LIABILITY_TOTAL_AMT>{ fn:string($outputParameters2/ns1:LIABILITY_TOTAL_AMT_1/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_TOTAL_AMT>
			                    <LIABILITY_PAYMENT_DATE></LIABILITY_PAYMENT_DATE>
	                    		<LIABILITY_SOURCE_BANK>PA01</LIABILITY_SOURCE_BANK>
	                    		<LIABILITY_TOTAL_CANCELATION_AMT>{ fn:string($outputParameters2/ns1:LIABILITY_TOTAL_DEBT/ns1:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_TOTAL_CANCELATION_AMT>
			            </ns2:consultaPasivosClienteResponseRecordType>
			        }
		        	</ns2:consultaPasivosClientePrestamosResponseType>
		        ) else (
		        	<ns2:consultaPasivosClientePrestamosResponseType/>
		        )
		    }
		    {
            	if (fn:string($outputParameters1/ns0:CodigoError/text()) = "-1") then (
		            <ns2:consultaPasivosClienteTCreditoResponseType>
		            {
			            	for $datosTarjetaCliente in $outputParameters1/ns0:RowSet/ns0:Row
			            	return
			                <ns2:consultaPasivosClienteResponseRecordType>
			                    <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
			                    {
			                    let $numTarjeta  := fn:string($datosTarjetaCliente/ns0:Column[@name = 'numtarjeta']/text())
			                    return
			                         if ($numTarjeta != '')then (
			                            <LIABILITY_NUMBER>{ $numTarjeta }</LIABILITY_NUMBER>
			                         )else()
			                    }
			                    {
			                    let $cardHolderName := fn:string($datosTarjetaCliente/ns0:Column[@name = 'cardholder_name']/text())
			                    return
                                    if ($cardHolderName != '')then (
                                        <LIABILITY_CUST_NAME>{  $cardHolderName }</LIABILITY_CUST_NAME>
                                    )else () 
			                    }
			                    {
                                    let $codMoneda := fn:string($datosTarjetaCliente/ns0:Column[@name = 'codMoneda']/text())
                                    return
                                        if ($codMoneda != '')then (
                                            <LIABILITY_CURRENCY_1>{ $codMoneda }</LIABILITY_CURRENCY_1>
                                        )else ()
                                }
			                    {
                                    let $montoPrincipal := fn:string($datosTarjetaCliente/ns0:Column[@name = 'MontoPrincipal']/text())
                                    return
                                        if ($montoPrincipal != '')then (
                                            <LIABILITY_PRINCIPAL_AMT_1>{ $montoPrincipal }</LIABILITY_PRINCIPAL_AMT_1>
                                        )else ()
                                }
			                    {
                                    let $montoTotal := fn:string($datosTarjetaCliente/ns0:Column[@name = 'MontoTotal']/text())
                                    return
                                        if ($montoTotal != '')then (
                                            <LIABILITY_TOTAL_AMT_1>{ $montoTotal }</LIABILITY_TOTAL_AMT_1>
                                        )else ()
                                }
			                    {
                                    let $balanceTotal := fn:string($datosTarjetaCliente/ns0:Column[@name = 'BalanceTotal']/text())
                                    return
                                        if ($balanceTotal != '')then (
                                            <LIABILITY_TOTAL_AMT>{ $balanceTotal }</LIABILITY_TOTAL_AMT>
                                        )else ()
                                }
			                    {
			                    let $fechaMaximaPago := $datosTarjetaCliente/ns0:Column[@name = 'FechaMaximaPago']
			                    return
			                    	if (fn:string($fechaMaximaPago) != "") then (
			                    		  <LIABILITY_PAYMENT_DATE>{fn-bea:dateTime-to-string-with-format('YYY-MM-dd', $fechaMaximaPago)}</LIABILITY_PAYMENT_DATE>
			                    	) else ()
			                    }
			                    <LIABILITY_SOURCE_BANK>PA01</LIABILITY_SOURCE_BANK>
			                    {
                                    let $montoCancelacion := fn:string($datosTarjetaCliente/ns0:Column[@name = 'MontoCancelacion']/text())
                                    return
                                        if ($montoCancelacion != '')then (
                                            <LIABILITY_TOTAL_CANCELATION_AMT>{ $montoCancelacion }</LIABILITY_TOTAL_CANCELATION_AMT>
                                        )else ()
                                }
			                </ns2:consultaPasivosClienteResponseRecordType>
		            }
		            </ns2:consultaPasivosClienteTCreditoResponseType>
		        ) else (
		        	<ns2:consultaPasivosClienteTCreditoResponseType/>
		        )
		    }
		    </ns2:consultaPasivosClienteResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $outputParameters2 as element(ns1:OutputParameters) external;

xf:consultaPasivosClientePAOut($outputParameters1,
    $outputParameters2)