xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../../BusinessServices/ABKGT/consultaPasivosCliente/xsd/consultaPasivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataGT/conDatosTarjetaCliente/xsd/conDatosTarjetaCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteResponse" location="../xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteGTOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaCliente";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaPasivosCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";

declare function xf:consultaPasivosClienteGTOut($outputParameters1 as element(ns2:OutputParameters),
    $outputParameters2 as element(ns0:OutputParameters))
    as element(ns1:consultaPasivosClienteResponse) {
                <ns1:consultaPasivosClienteResponse>
           {
	        	if (fn:string($outputParameters1/ns2:ERROR_CODE/text()) = "SUCCESS") then ( 
		        	<ns1:consultaPasivosClientePrestamosResponseType>
		        	{	
		        		for $item at $i in $outputParameters1/ns2:LIABILITY_NUMBER/ns2:LIABILITY_NUMBER_ITEM
		        		return
		        		<ns1:consultaPasivosClienteResponseRecordType>
			                    <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
			                    <LIABILITY_NUMBER>{ fn:string($outputParameters1/ns2:LIABILITY_NUMBER/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_NUMBER>
			                    <LIABILITY_CUST_NAME>{ fn:string($outputParameters1/ns2:LIABILITY_CUST_NAME/ns2:LIABILITY_CUST_NAME_ITEM[$i]/text()) }</LIABILITY_CUST_NAME>
			                    <LIABILITY_CURRENCY_1>{ fn:string($outputParameters1/ns2:LIABILITY_CURRENCY_1/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_CURRENCY_1>
			                    <LIABILITY_PRINCIPAL_AMT_1>{ fn:string($outputParameters1/ns2:LIABILITY_PRINCIPAL_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_PRINCIPAL_AMT_1>
			                    <LIABILITY_INT_COM_AMT_1>{ fn:string($outputParameters1/ns2:LIABILITY_INT_COM_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_INT_COM_AMT_1>
			                    <LIABILITY_TOTAL_AMT_1>{ fn:string($outputParameters1/ns2:LIABILITY_TOTAL_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_TOTAL_AMT_1>
			                    <LIABILITY_TOTAL_AMT>{ fn:string($outputParameters1/ns2:LIABILITY_TOTAL_AMT_1/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_TOTAL_AMT>
			                    <LIABILITY_PAYMENT_DATE></LIABILITY_PAYMENT_DATE>
	                    		<LIABILITY_SOURCE_BANK>PA01</LIABILITY_SOURCE_BANK>
	                    		<LIABILITY_TOTAL_CANCELATION_AMT>{ fn:string($outputParameters1/ns2:LIABILITY_TOTAL_DEBT/ns2:LIABILITY_NUMBER_ITEM[$i]/text()) }</LIABILITY_TOTAL_CANCELATION_AMT>
			            </ns1:consultaPasivosClienteResponseRecordType>
			        }
		        	</ns1:consultaPasivosClientePrestamosResponseType>
		        ) else (
		        	<ns1:consultaPasivosClientePrestamosResponseType/>
		        )
		    }
		    {
            	if (fn:string($outputParameters2/ns0:CodigoError/text()) = "-1") then (
		            <ns1:consultaPasivosClienteTCreditoResponseType>
		            {
		            	for $cardNumber in distinct-values($outputParameters2/ns0:RowSet/ns0:Row/ns0:Column[@name = 'numtarjeta']/text())
		            	return(
		            		for $rowBase in $outputParameters2/ns0:RowSet/ns0:Row where $rowBase/ns0:Column[@name = 'numtarjeta']/text() = $cardNumber and $rowBase/ns0:Column[@name = 'TipoOrg']/text() = 'BASE'
		            		return
		            		<ns1:consultaPasivosClienteResponseRecordType>
			                    <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
			                    <LIABILITY_NUMBER>{ xs:long($cardNumber) }</LIABILITY_NUMBER>
			                    <LIABILITY_CUST_NAME>{  data($rowBase/ns0:Column[@name = 'cardholder_name']) }</LIABILITY_CUST_NAME>
			                    <LIABILITY_CURRENCY_1>{  data($rowBase/ns0:Column[@name = 'codMoneda']) }</LIABILITY_CURRENCY_1>
			                    <LIABILITY_PRINCIPAL_AMT_1>{  data($rowBase/ns0:Column[@name = 'MontoPrincipal']) }</LIABILITY_PRINCIPAL_AMT_1>
			                    <LIABILITY_TOTAL_AMT_1>{  data($rowBase/ns0:Column[@name = 'MontoTotal']) }</LIABILITY_TOTAL_AMT_1>
			                    {
			                    	for $rowAlt in $outputParameters2/ns0:RowSet/ns0:Row where $rowAlt/ns0:Column[@name = 'numtarjeta']/text() = $cardNumber and $rowAlt/ns0:Column[@name = 'TipoOrg']/text() = 'ALT'
			                    	return(
			                    	<LIABILITY_CURRENCY_2>{  data($rowAlt/ns0:Column[@name = 'codMoneda']) }</LIABILITY_CURRENCY_2>,
			                    	<LIABILITY_PRINCIPAL_AMT_2>{  data($rowAlt/ns0:Column[@name = 'MontoPrincipal']) }</LIABILITY_PRINCIPAL_AMT_2>,
			                    	<LIABILITY_TOTAL_AMT_2>{  data($rowAlt/ns0:Column[@name = 'MontoTotal']) }</LIABILITY_TOTAL_AMT_2>
			                    	)
			                    }
			                    <LIABILITY_TOTAL_AMT>{  data($rowBase/ns0:Column[@name = 'BalanceTotal']) }</LIABILITY_TOTAL_AMT>
			                    {
			                    	if(string($rowBase/ns0:Column[@name = 'FechaMaximaPago']/text()) != "") then (
			                    		<LIABILITY_PAYMENT_DATE>{  fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", data($rowBase/ns0:Column[@name = 'FechaMaximaPago'])) }</LIABILITY_PAYMENT_DATE>
			                    	) else()
			                    }
			                    <LIABILITY_SOURCE_BANK>GT01</LIABILITY_SOURCE_BANK>
			                    {
			                    	if(string($rowBase/ns0:Column[@name = 'MontoCancelacion']/text()) != "") then (
			                    		<LIABILITY_TOTAL_CANCELATION_AMT>{  data($rowBase/ns0:Column[@name = 'MontoCancelacion']) }</LIABILITY_TOTAL_CANCELATION_AMT>
			                    	) else()
			                    }
			                </ns1:consultaPasivosClienteResponseRecordType>
		            	)
			           }
		            </ns1:consultaPasivosClienteTCreditoResponseType>
		        ) else (
		        	<ns1:consultaPasivosClienteTCreditoResponseType/>
		        )
		    }
		    </ns1:consultaPasivosClienteResponse>
};

declare variable $outputParameters1 as element(ns2:OutputParameters) external;
declare variable $outputParameters2 as element(ns0:OutputParameters) external;

xf:consultaPasivosClienteGTOut($outputParameters1,
    $outputParameters2)