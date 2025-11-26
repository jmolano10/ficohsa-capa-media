(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../../Business_Resources/consultasCliente/Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)
(:: pragma  parameter="$PrestamoAdicResponse" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$outputParametersTC" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatosTarjetaCliente/xsd/conDatoTarjetaClienteHN_sp.xsd" ::)
(:: pragma  parameter="$tarjetaCreditoAdicResponse" type="anyType" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteResponse" location="../xsd/consultaPasivosClienteTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetaClienteHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteSPOut/";

declare function xf:consultaPasivosClienteSPOut($outputParameters as element(ns2:OutputParameters),
    $PrestamoAdicResponse as element(*),
    $outputParametersTC as element(ns0:OutputParameters),
    $tarjetaCreditoAdicResponse as element(*),
    $functionalityDisplayIndicator as xs:string)
    as element(ns1:consultaPasivosClienteResponse) {
        <ns1:consultaPasivosClienteResponse>
            <ns1:consultaPasivosClientePrestamosResponseType>
                {
                    for $ITEM at $i in $PrestamoAdicResponse/Prestamo
                    return
                        <ns1:consultaPasivosClienteResponseRecordType>
                            <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
                            <LIABILITY_NUMBER>{ data($PrestamoAdicResponse/Prestamo[$i]/LOAN_ID) }</LIABILITY_NUMBER>
                            <LIABILITY_CUST_NAME>{ data($PrestamoAdicResponse/Prestamo[$i]/LOAN_CUSTOMER_NAME) }</LIABILITY_CUST_NAME>
                            <LIABILITY_CURRENCY_1>{ data($PrestamoAdicResponse/Prestamo[$i]/CURRENCY) }</LIABILITY_CURRENCY_1>
                            {
	                            if ($functionalityDisplayIndicator = ('ALL','PTM')) then (
	                            
									<LIABILITY_PRINCIPAL_AMT_1>{ data($PrestamoAdicResponse/Prestamo[$i]/PRINCIPAL_AMOUNT) }</LIABILITY_PRINCIPAL_AMT_1>,
		                            <LIABILITY_INT_COM_AMT_1>{ fn:string($PrestamoAdicResponse/Prestamo[$i]/INTEREST_AND_COMISSION_AMOUNT/text()) }</LIABILITY_INT_COM_AMT_1>,
		                            <LIABILITY_TOTAL_AMT_1>{ data($PrestamoAdicResponse/Prestamo[$i]/TOTAL_AMOUNT) }</LIABILITY_TOTAL_AMT_1>,
		                            <LIABILITY_TOTAL_AMT>{ data($PrestamoAdicResponse/Prestamo[$i]/TOTAL_AMOUNT) }</LIABILITY_TOTAL_AMT>
								
								)else
								(
								)
							}  
                            <LIABILITY_PAYMENT_DATE>{ data($PrestamoAdicResponse/Prestamo[$i]/MATURITY_DATE) }</LIABILITY_PAYMENT_DATE>
                            <LIABILITY_SOURCE_BANK>HN01</LIABILITY_SOURCE_BANK>
                            <LIABILITY_TOTAL_CANCELATION_AMT>{ data($PrestamoAdicResponse/Prestamo[$i]/TOTAL_DEBT) }</LIABILITY_TOTAL_CANCELATION_AMT>                                                                                                                                      
                        </ns1:consultaPasivosClienteResponseRecordType>
                }
            </ns1:consultaPasivosClientePrestamosResponseType>
            <ns1:consultaPasivosClienteTCreditoResponseType>
            	{
		            	for $cardNumber in distinct-values($tarjetaCreditoAdicResponse/ns0:RowSet/ns0:Row/ns0:Column[@name = 'numtarjeta']/text())
		            	return(
		            		for $rowBase in $tarjetaCreditoAdicResponse/ns0:RowSet/ns0:Row where $rowBase/ns0:Column[@name = 'numtarjeta']/text() = $cardNumber and $rowBase/ns0:Column[@name = 'TipoOrg']/text() = 'BASE'
		            		return
		            		<ns1:consultaPasivosClienteResponseRecordType>
			                    <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
			                    <LIABILITY_NUMBER>{ xs:long($cardNumber) }</LIABILITY_NUMBER>
			                    <LIABILITY_CUST_NAME>{  data($rowBase/ns0:Column[@name = 'cardholder_name']) }</LIABILITY_CUST_NAME>
			                    <LIABILITY_CURRENCY_1>{  data($rowBase/ns0:Column[@name = 'codMoneda']) }</LIABILITY_CURRENCY_1>
			                    <LIABILITY_PRINCIPAL_AMT_1>{  data($rowBase/ns0:Column[@name = 'MontoPrincipal']) }</LIABILITY_PRINCIPAL_AMT_1>
			                    <LIABILITY_TOTAL_AMT_1>{  data($rowBase/ns0:Column[@name = 'MontoTotal']) }</LIABILITY_TOTAL_AMT_1>
			                    {
			                    	for $rowAlt in $tarjetaCreditoAdicResponse/ns0:RowSet/ns0:Row where $rowAlt/ns0:Column[@name = 'numtarjeta']/text() = $cardNumber and $rowAlt/ns0:Column[@name = 'TipoOrg']/text() = 'ALT'
			                    	return(
			                    	<LIABILITY_CURRENCY_2>{  data($rowAlt/ns0:Column[@name = 'codMoneda']) }</LIABILITY_CURRENCY_2>,
			                    	<LIABILITY_PRINCIPAL_AMT_2>{  data($rowAlt/ns0:Column[@name = 'MontoPrincipal']) }</LIABILITY_PRINCIPAL_AMT_2>,
			                    	<LIABILITY_TOTAL_AMT_2>{  data($rowAlt/ns0:Column[@name = 'MontoTotal']) }</LIABILITY_TOTAL_AMT_2>
			                    	)
			                    }
			                    <LIABILITY_TOTAL_AMT>{  data($rowBase/ns0:Column[@name = 'BalanceTotal']) }</LIABILITY_TOTAL_AMT>
			                    {
			                    	if(string($rowBase/ns0:Column[@name = 'FechaMaximaPago']/text()) != "") then (
			                    		<LIABILITY_PAYMENT_DATE>{  fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($rowBase/ns0:Column[@name = 'FechaMaximaPago'])) }</LIABILITY_PAYMENT_DATE>
			                    	) else()
			                    }
			                    <LIABILITY_SOURCE_BANK>HN01</LIABILITY_SOURCE_BANK>
			                    {
			                    	if(string($rowBase/ns0:Column[@name = 'MontoCancelacion']/text()) != "") then (
			                    		<LIABILITY_TOTAL_CANCELATION_AMT>{  data($rowBase/ns0:Column[@name = 'MontoCancelacion']) }</LIABILITY_TOTAL_CANCELATION_AMT>
			                    	) else()
			                    }
			                </ns1:consultaPasivosClienteResponseRecordType>
		            	)
			           }
            </ns1:consultaPasivosClienteTCreditoResponseType>
   </ns1:consultaPasivosClienteResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;
declare variable $PrestamoAdicResponse as element(*) external;
declare variable $outputParametersTC as element(ns0:OutputParameters) external;
declare variable $tarjetaCreditoAdicResponse as element(*) external;
declare variable $functionalityDisplayIndicator as xs:string external;

xf:consultaPasivosClienteSPOut($outputParameters,
    $PrestamoAdicResponse,
    $outputParametersTC,
    $tarjetaCreditoAdicResponse,
    $functionalityDisplayIndicator)