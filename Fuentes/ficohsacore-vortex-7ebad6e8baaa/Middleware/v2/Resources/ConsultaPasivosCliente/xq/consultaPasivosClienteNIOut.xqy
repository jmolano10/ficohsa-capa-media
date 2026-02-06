xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaPasivosClienteRespuesta1" element="ns1:opConsultaPasivosClienteRespuesta" location="../../../BusinessServices/CTS/pasivos/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns3:consultaPasivosClienteResponse" location="../xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace ns1 = "http://service.srvaplcobispasivos.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteNIOut/";
declare namespace ns4 = "http://dto2.sdf.cts.cobis.cobiscorp.com";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

declare function xf:consultaPasivosClienteNIOut($opConsultaPasivosClienteRespuesta1 as element(ns1:opConsultaPasivosClienteRespuesta)?,
$CodigoBloqueo as xs:string, $Bines as xs:string, $ProductoEntrada as xs:string)
    as element(ns3:consultaPasivosClienteResponse) {
        <ns3:consultaPasivosClienteResponse>
            <ns3:consultaPasivosClientePrestamosResponseType>
                {
                    for $pasivos in $opConsultaPasivosClienteRespuesta1/ns0:pasivos[ns0:cuenta/ns0:codTipoProducto = 'CCA']
                    return
                        <ns3:consultaPasivosClienteResponseRecordType>
                        	<LIABILITY_TYPE>PTM</LIABILITY_TYPE>                            
                            {
                                for $codCuentaHabiente in $pasivos/ns0:cuenta/ns0:codCuentaHabiente
                                return
                                    <LIABILITY_NUMBER>{ data($codCuentaHabiente) }</LIABILITY_NUMBER>
                            }
                            {
                                for $valCuentaHabiente in $pasivos/ns0:cuenta/ns0:valCuentaHabiente
                                return
                                    <LIABILITY_CUST_NAME>{ data($valCuentaHabiente) }</LIABILITY_CUST_NAME>
                            }
                            {
                                for $valSimboloMoneda in $pasivos/ns0:cuenta/ns0:moneda/ns0:valSimboloMoneda
                                return
                                    <LIABILITY_CURRENCY_1>{ data($valSimboloMoneda) }</LIABILITY_CURRENCY_1>
                            }
                            {
                                for $deudaPrincipalAmt1 in $pasivos/ns0:deudaPrincipalAmt1
                                return
                                    <LIABILITY_PRINCIPAL_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaPrincipalAmt1)), 2) }</LIABILITY_PRINCIPAL_AMT_1>
                            }
                            {
                                for $deudaIntComAmt1 in $pasivos/ns0:deudaIntComAmt1
                                return
                                    <LIABILITY_INT_COM_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaIntComAmt1)), 2) }</LIABILITY_INT_COM_AMT_1>
                            }
                            {
                                for $deudaTotalAmt1 in $pasivos/ns0:deudaTotalAmt1
                                return
                                    <LIABILITY_TOTAL_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaTotalAmt1)), 2) }</LIABILITY_TOTAL_AMT_1>
                            }
                            {
                                for $monedadeuda2 in $pasivos/ns0:monedadeuda2
                                return
                                    <LIABILITY_CURRENCY_2>{ data($monedadeuda2) }</LIABILITY_CURRENCY_2>
                            }
                            {
                                for $deudaPrincipalAmt2 in $pasivos/ns0:deudaPrincipalAmt2
                                return
                                    <LIABILITY_PRINCIPAL_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaPrincipalAmt2)), 2) }</LIABILITY_PRINCIPAL_AMT_2>
                            }
                            
                            {
                                for $deudaIntComAmt2 in $pasivos/ns0:deudaIntComAmt2
                                return
                                    <LIABILITY_INT_COM_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaIntComAmt2)), 2) }</LIABILITY_INT_COM_AMT_2>
                            }
                            
                            {
                                for $deudaTotalAmt2 in $pasivos/ns0:deudaTotalAmt2
                                return
                                    <LIABILITY_TOTAL_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaTotalAmt2)), 2) }</LIABILITY_TOTAL_AMT_2>
                            }
                            
                            {
                                for $deudaTotal in $pasivos/ns0:deudaTotal
                                return
                                    <LIABILITY_TOTAL_AMT>{ fn:round-half-to-even(xs:decimal(data($deudaTotal)), 2) }</LIABILITY_TOTAL_AMT>
                            }
                            {
		                        for $fechaDePago in $pasivos/ns0:fechaDePago
		                        return
		                            <LIABILITY_PAYMENT_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaDePago)) }</LIABILITY_PAYMENT_DATE>
		                    }
                            <LIABILITY_SOURCE_BANK>NI01</LIABILITY_SOURCE_BANK>
                        </ns3:consultaPasivosClienteResponseRecordType>
                }
            </ns3:consultaPasivosClientePrestamosResponseType>     
                   
            <ns3:consultaPasivosClienteTCreditoResponseType>
                {
                	if($ProductoEntrada = ('TRC', 'ALL')) then(
		                let $estadosBloqueo := fn:tokenize($CodigoBloqueo,'\|\|')
		                let $binesTC := fn:tokenize($Bines,'\|\|')
		                for $pasivo  in $opConsultaPasivosClienteRespuesta1/ns0:pasivos
		                where string($pasivo/ns0:cuenta/ns0:codTipoProducto/text()) = 'TCR' and 
		                	  not(substring(string($pasivo/ns0:cuenta/ns0:codCuentaHabiente/text()), 1, 6) = ($binesTC))
		                return
		                let $codigoDelBloqueDol1 := fn:string($pasivo/ns0:codigoDelBloqueDol1/text())
		                let $codigoDelBloque1 := fn:string($pasivo/ns0:codigoDelBloque1/text())
		                let $deudaTotalAmt1 := ($pasivo/ns0:deudaTotalAmt1)
		                return
		                    if (
		                    	($codigoDelBloqueDol1 != "" and $codigoDelBloqueDol1 = ($estadosBloqueo)) 
		                    	or ($codigoDelBloque1 != "" and $codigoDelBloque1 = ($estadosBloqueo))
		                    ) then ()
		                       else (
		                                <ns3:consultaPasivosClienteResponseRecordType>
		                                    <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
		                                    {
			                                    for $codCuentaHabiente in $pasivo/ns0:cuenta/ns0:codCuentaHabiente
			                                    return
			                                    	<LIABILITY_NUMBER>{ data($codCuentaHabiente) }</LIABILITY_NUMBER>
		                                    }
		                                    {
			                                    for $valCuentaHabiente in $pasivo/ns0:cuenta/ns0:valCuentaHabiente
			                                    return
			                                    	<LIABILITY_CUST_NAME>{ data($valCuentaHabiente) }</LIABILITY_CUST_NAME>
		                                    }
		                                    {
			                                    for $valSimboloMoneda in $pasivo/ns0:cuenta/ns0:moneda/ns0:valSimboloMoneda
			                                    return
			                                    	<LIABILITY_CURRENCY_1>{ data($valSimboloMoneda) }</LIABILITY_CURRENCY_1>
		                                    }
		                                    {
			                                    for $deudaPrincipalAmt1 in $pasivo/ns0:deudaPrincipalAmt1
			                                    return
			                                    	<LIABILITY_PRINCIPAL_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaPrincipalAmt1)), 2) }</LIABILITY_PRINCIPAL_AMT_1>
		                                    }
		                                    {
			                                    for $deudaIntComAmt1 in $pasivo/ns0:deudaIntComAmt1
			                                    return
			                                    	<LIABILITY_INT_COM_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaIntComAmt1)), 2) }</LIABILITY_INT_COM_AMT_1>
		                                    }
		                                    {
			                                    for $deudaTotalAmt1 in $pasivo/ns0:deudaTotalAmt1
			                                    return
			                                    	<LIABILITY_TOTAL_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaTotalAmt1)), 2) }</LIABILITY_TOTAL_AMT_1>
		                                    }
		                                    {
			                                    for $monedadeuda2 in $pasivo/ns0:monedadeuda2
			                                    return
			                                    	<LIABILITY_CURRENCY_2>{ data($monedadeuda2) }</LIABILITY_CURRENCY_2>
		                                    }
		                                    {
			                                    for $deudaPrincipalAmt2 in $pasivo/ns0:deudaPrincipalAmt2
			                                    return
			                                    	<LIABILITY_PRINCIPAL_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaPrincipalAmt2)), 2) }</LIABILITY_PRINCIPAL_AMT_2>
		                                    }
		                                    {
			                                    for $deudaIntComAmt2 in $pasivo/ns0:deudaIntComAmt2
			                                    return
			                                    	<LIABILITY_INT_COM_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaIntComAmt2)), 2) }</LIABILITY_INT_COM_AMT_2>
		                                    }
		                                    {
			                                    for $deudaTotalAmt2 in $pasivo/ns0:deudaTotalAmt2
			                                    return
			                                    	<LIABILITY_TOTAL_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaTotalAmt2)), 2) }</LIABILITY_TOTAL_AMT_2>
		                                    }
		                                    {
		                                    for $deudaTotal in $pasivo/ns0:deudaTotal
			                                    return
			                                    <LIABILITY_TOTAL_AMT>{ fn:round-half-to-even(xs:decimal(data($deudaTotal)), 2) }</LIABILITY_TOTAL_AMT>
		                                    }
		                                    {
		                        				for $fechaDePago in $pasivo/ns0:fechaDePago
						                        return
						                            <LIABILITY_PAYMENT_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaDePago)) }</LIABILITY_PAYMENT_DATE>
		                    				}
		                                    <LIABILITY_SOURCE_BANK>NI01</LIABILITY_SOURCE_BANK>
		                                </ns3:consultaPasivosClienteResponseRecordType>
		                            )
		              ) else()
                }
            </ns3:consultaPasivosClienteTCreditoResponseType>
            
            <ns3:consultaPasivosClientePrestamosTCResponseType>
                {
		            if($ProductoEntrada = ('PTC', 'ALL')) then(
		                let $estadosBloqueo := fn:tokenize($CodigoBloqueo,'\|\|')
		                let $binesTC := fn:tokenize($Bines,'\|\|')
		                for $pasivo  in $opConsultaPasivosClienteRespuesta1/ns0:pasivos
		                where string($pasivo/ns0:cuenta/ns0:codTipoProducto/text()) = 'TCR' and 
		                	  substring(string($pasivo/ns0:cuenta/ns0:codCuentaHabiente/text()), 1, 6) = ($binesTC)
		               return
		                let $codigoDelBloqueDol1 := fn:string($pasivo/ns0:codigoDelBloqueDol1/text())
		                let $codigoDelBloque1 := fn:string($pasivo/ns0:codigoDelBloque1/text())
		                let $deudaTotalAmt1 := data($pasivo/ns0:deudaTotalAmt1)
		                let $deudaTotalAmt2 := data($pasivo/ns0:deudaTotalAmt2)
		                return
		                    if ($codigoDelBloqueDol1 = ($estadosBloqueo) and  $codigoDelBloque1 = ($estadosBloqueo)) 
		                       then (
		                            if (($codigoDelBloqueDol1 = "A" or $codigoDelBloque1 = "A")
		                                and (data($pasivo/ns0:deudaPrincipalAmt1) <= 0
		                                and data($pasivo/ns0:deudaPrincipalAmt2) <= 0)) then()
		                            else (
		                                <ns3:consultaPasivosClienteResponseRecordType>
		                                    <LIABILITY_TYPE>PTC</LIABILITY_TYPE>
		                                    {
			                                    for $codCuentaHabiente in $pasivo/ns0:cuenta/ns0:codCuentaHabiente
			                                    return
			                                    	<LIABILITY_NUMBER>{ data($codCuentaHabiente) }</LIABILITY_NUMBER>
		                                    }
		                                    {
			                                    for $valCuentaHabiente in $pasivo/ns0:cuenta/ns0:valCuentaHabiente
			                                    return
			                                    	<LIABILITY_CUST_NAME>{ data($valCuentaHabiente) }</LIABILITY_CUST_NAME>
		                                    }
		                                    {
			                                    for $valSimboloMoneda in $pasivo/ns0:cuenta/ns0:moneda/ns0:valSimboloMoneda
			                                    return
			                                    	if($deudaTotalAmt1 > 0 ) then (
			                                    		<LIABILITY_CURRENCY_1>{ data($valSimboloMoneda) }</LIABILITY_CURRENCY_1>
			                                    	) else ()
			                                    	
		                                    }
		                                    {
			                                    for $deudaPrincipalAmt1 in $pasivo/ns0:deudaPrincipalAmt1
			                                    return
			                                    	 if($deudaTotalAmt1 > 0) then ( 
			                                    		<LIABILITY_PRINCIPAL_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaPrincipalAmt1)), 2) }</LIABILITY_PRINCIPAL_AMT_1>
			                                    	) else()  	
		                                    }
		                                    {
			                                    for $deudaIntComAmt1 in $pasivo/ns0:deudaIntComAmt1
			                                    return
			                                    
			                                    	if($deudaTotalAmt1 > 0) then ( 
			                                    		<LIABILITY_INT_COM_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaIntComAmt1)), 2) }</LIABILITY_INT_COM_AMT_1>
			                                    	) else ()
		                                    }
		                                    {
			                                    for $deudaTotalAmt1 in $pasivo/ns0:deudaTotalAmt1
			                                    return
			                                    	if($deudaTotalAmt1 > 0) then (  
			                                    		<LIABILITY_TOTAL_AMT_1>{ fn:round-half-to-even(xs:decimal(data($deudaTotalAmt1)), 2) }</LIABILITY_TOTAL_AMT_1>
			                                    	) else ()
		                                    }
		                                    {
			                                    for $monedadeuda2 in $pasivo/ns0:monedadeuda2
			                                    return
			                                    	if($deudaTotalAmt2 > 0) then (
			                                    		<LIABILITY_CURRENCY_2>{ data($monedadeuda2) }</LIABILITY_CURRENCY_2>
			                                    	) else ()
		                                    }
		                                    {
			                                    for $deudaPrincipalAmt2 in $pasivo/ns0:deudaPrincipalAmt2
			                                    return
			                                    	if($deudaTotalAmt2 > 0) then (
			                                    		<LIABILITY_PRINCIPAL_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaPrincipalAmt2)), 2) }</LIABILITY_PRINCIPAL_AMT_2>
			                                    	) else ()
		                                    }
		                                    {
			                                    for $deudaIntComAmt2 in $pasivo/ns0:deudaIntComAmt2
			                                    return
			                                    	if($deudaTotalAmt2 > 0) then (
			                                    		<LIABILITY_INT_COM_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaIntComAmt2)), 2) }</LIABILITY_INT_COM_AMT_2>
			                                    	) else ()
		                                    }
		                                    {
			                                    for $deudaTotalAmt2 in $pasivo/ns0:deudaTotalAmt2
			                                    return
			                                    	if($deudaTotalAmt2 > 0) then (
			                                    		<LIABILITY_TOTAL_AMT_2>{ fn:round-half-to-even(xs:decimal(data($deudaTotalAmt2)), 2) }</LIABILITY_TOTAL_AMT_2>
			                                    	) else ()
		                                    }
		                                    {
		                                    for $deudaTotal in $pasivo/ns0:deudaTotal
			                                    return
			                                    	<LIABILITY_TOTAL_AMT>{ fn:round-half-to-even(xs:decimal(data($deudaTotal)), 2) }</LIABILITY_TOTAL_AMT>
		                                    }
		                                    {
		                        				for $fechaDePago in $pasivo/ns0:fechaDePago
						                        return
						                            <LIABILITY_PAYMENT_DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($fechaDePago)) }</LIABILITY_PAYMENT_DATE>
		                    				}
		                                    <LIABILITY_SOURCE_BANK>NI01</LIABILITY_SOURCE_BANK>
		                                </ns3:consultaPasivosClienteResponseRecordType>
		                                )
		                            )
		                    else ()
		              ) else()
                }
            </ns3:consultaPasivosClientePrestamosTCResponseType>
            
        </ns3:consultaPasivosClienteResponse>
};

declare variable $opConsultaPasivosClienteRespuesta1 as element(ns1:opConsultaPasivosClienteRespuesta)? external;
declare variable $CodigoBloqueo as xs:string external;
declare variable $Bines as xs:string external;
declare variable $ProductoEntrada as xs:string external;

xf:consultaPasivosClienteNIOut($opConsultaPasivosClienteRespuesta1,
$CodigoBloqueo,
$Bines,
$ProductoEntrada)