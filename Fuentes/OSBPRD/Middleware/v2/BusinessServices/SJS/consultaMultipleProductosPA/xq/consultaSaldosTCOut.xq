xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:local-element-return type="ns2:sjConsultaMultiplesProductosPAResponse/ns2:LIABILITIES/ns2:LIABILITY" location="../xsd/sjConsultaMultipleProductosPA.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosPA/xq/consultaSaldosTCOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultiplesProductosPA";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function numIsNull($item as item()?) as xs:decimal {
    if (fn:string($item/text()) != '' ) then (
        round-half-to-even( xs:decimal(data($item)), 2 )
    ) else (0.0)
};

declare function xf:consultaSaldosTCOut($consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse),
    $responseHeader as element(ns1:ResponseHeader),
    $productID as xs:string,
    $productType as xs:string)
    as element() {
        <ns2:LIABILITY>
        	<ns2:ID>{ $productID }</ns2:ID>
        	{
                let $successIndicator := data($responseHeader/successIndicator)
                return
                	if (fn:upper-case($successIndicator) = 'SUCCESS')then(
                		
                		let $productName := $consultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                        	return
                            	<ns2:PRODUCT_NAME>{ data($productName) }</ns2:PRODUCT_NAME>,
                            	
                            	let $saldosTarjetaCreditoLocal := $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType
                            	return(
	                            	<ns2:BALANCES>
	                            		{
	                                    for $nodoSaldoLocal in $saldosTarjetaCreditoLocal
	                                	return
	                                    	<ns2:BALANCE>
	                                        	<ns2:CURRENCY>{ data($nodoSaldoLocal/CURRENCY) }</ns2:CURRENCY>
	                                        	<ns2:PRINCIPAL>{ numIsNull($nodoSaldoLocal/CURRENT_BALANCE) }</ns2:PRINCIPAL>
	                                        	<ns2:INT_COMM>0.00</ns2:INT_COMM>,
	                                        	<ns2:TOTAL>{ numIsNull($nodoSaldoLocal/CURRENT_BALANCE) }</ns2:TOTAL>
	                                        	<ns2:WITHDRAWAL_LIMIT>{ numIsNull($nodoSaldoLocal/WITHDRAWAL_LIMIT) }</ns2:WITHDRAWAL_LIMIT>
	                                    	</ns2:BALANCE>
	                                 	} 
	                            	</ns2:BALANCES>,
	                            	
	                            	let $fecha := $consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
	                        		return
	                        			if(data($fecha) != "")then(
	                        				<ns2:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd',$fecha/text()) }</ns2:NEXT_PAYMENT_DATE>
	                        			)else(),
	                        		
	                        		let $balanceActual := $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENT_BALANCE
	                        		return
	                        			if(data($balanceActual)!= "")then(
	                        				<ns2:TSTANDING_TOTAL>{data($balanceActual)}</ns2:TSTANDING_TOTAL>
	                        			)else(
	                        				<ns2:TSTANDING_TOTAL>0</ns2:TSTANDING_TOTAL>
	                        			),
	                        			
	                        			<ns2:CANCELATION_TOTAL>0.0</ns2:CANCELATION_TOTAL>,
		                        		<ns2:TOTAL_AMOUNT>0.0</ns2:TOTAL_AMOUNT>,
	                            		<ns2:TYPE>{ $productType }</ns2:TYPE>,
	                            		<ns2:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns2:OPENING_DATE>,
	                    				<ns2:SOURCE_BANK>PA01</ns2:SOURCE_BANK>,
	                    				<ns2:SUCCESS_INDICATOR>{ $responseHeader/successIndicator }</ns2:SUCCESS_INDICATOR>
	                            )
                	)
                	else(
                		<ns2:TYPE>{ $productType }</ns2:TYPE>,
                        <ns2:SOURCE_BANK>PA01</ns2:SOURCE_BANK>,
                        <ns2:SUCCESS_INDICATOR>{ $responseHeader/successIndicator }</ns2:SUCCESS_INDICATOR>,
                        for $valDescripcionRespuesta in $responseHeader/messages
                        return(
                            <ns2:ERROR_MESSAGE>{ data($valDescripcionRespuesta) }</ns2:ERROR_MESSAGE>
                        )
                	)
            }
        </ns2:LIABILITY>
};

declare variable $consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse) external;
declare variable $responseHeader as element(ns1:ResponseHeader) external;
declare variable $productID as xs:string external;
declare variable $productType as xs:string external;

xf:consultaSaldosTCOut($consultaSaldosTarjetaCreditoResponse,
    $responseHeader,
    $productID,
    $productType)