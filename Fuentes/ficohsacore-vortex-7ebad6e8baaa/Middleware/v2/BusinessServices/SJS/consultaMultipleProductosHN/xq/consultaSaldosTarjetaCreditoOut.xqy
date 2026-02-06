xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns1:consultaSaldosTarjetaCreditoResponse" location="../../../../Resources/ConsultaSaldosTarjetaCredito/xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultipleProductosHNResponse/ns0:LIABILITIES/ns0:LIABILITY" location="../xsd/sjConsultaMultipleProductosHN.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns1:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosHN";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaSaldosTarjetaCreditoOut/";
declare namespace aut = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function numIsNull($item as item()?) as xs:decimal {
    if (fn:string($item/text()) != '' ) then (
        round-half-to-even( xs:decimal(data($item)), 2 )
    ) else (0.0)
};

declare function xf:consultaSaldosTarjetaCreditoOut($productID as xs:string,
	$responseHeader as element(aut:ResponseHeader),
    $productType as xs:string,
    $consultaSaldosTarjetaCreditoResponse as element(ns1:consultaSaldosTarjetaCreditoResponse))
    as element() {
        <ns0:LIABILITY>
        	<ns0:ID>{ $productID }</ns0:ID>
        	{
                let $successIndicator := data($responseHeader/successIndicator)
                return
                	if (fn:upper-case($successIndicator) = 'SUCCESS')then(
                		
                		let $productName := $consultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                        	return
                            	<ns0:PRODUCT_NAME>{ data($productName) }</ns0:PRODUCT_NAME>,
                            	
                            	let $saldosTarjetaCreditoLocal := $consultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType
                            	return(
	                            	<ns0:BALANCES>
	                            		{
	                                    for $nodoSaldoLocal in $saldosTarjetaCreditoLocal
	                                	return
	                                    	<ns0:BALANCE>
	                                        	<ns0:CURRENCY>{ data($nodoSaldoLocal/CURRENCY) }</ns0:CURRENCY>
	                                        	<ns0:PRINCIPAL>{ numIsNull($nodoSaldoLocal/CURRENT_BALANCE) }</ns0:PRINCIPAL>
	                                        	<ns0:INT_COMM>0.00</ns0:INT_COMM>,
	                                        	<ns0:TOTAL>{ numIsNull($nodoSaldoLocal/CURRENT_BALANCE) }</ns0:TOTAL>
	                                        	<ns0:WITHDRAWAL_LIMIT>{ numIsNull($nodoSaldoLocal/WITHDRAWAL_LIMIT) }</ns0:WITHDRAWAL_LIMIT>
	                                    	</ns0:BALANCE>
	                                 	} 
	                            	</ns0:BALANCES>,
	                            	
	                            	let $fecha := $consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
	                        		return
	                        			if(data($fecha) != "")then(
	                        				<ns0:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd',$fecha/text()) }</ns0:NEXT_PAYMENT_DATE>
	                        			)else(),
	                        		
	                        		let $balanceActual := $consultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType[1]/CURRENT_BALANCE
	                        		return
	                        			if(data($balanceActual)!= "")then(
	                        				<ns0:TSTANDING_TOTAL>{data($balanceActual)}</ns0:TSTANDING_TOTAL>
	                        			)else(
	                        				<ns0:TSTANDING_TOTAL>0</ns0:TSTANDING_TOTAL>
	                        			),
	                        			
	                        			<ns0:CANCELATION_TOTAL>0.0</ns0:CANCELATION_TOTAL>,
		                        		<ns0:TOTAL_AMOUNT>0.0</ns0:TOTAL_AMOUNT>,
	                            		<ns0:TYPE>{ $productType }</ns0:TYPE>,
	                            		<ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>,
	                    				<ns0:SOURCE_BANK>HN01</ns0:SOURCE_BANK>,
	                    				<ns0:SUCCESS_INDICATOR>{ $responseHeader/successIndicator }</ns0:SUCCESS_INDICATOR>
	                            )
                	)
                	else(
                		<ns0:TYPE>{ $productType }</ns0:TYPE>,
                        <ns0:SOURCE_BANK>HN01</ns0:SOURCE_BANK>,
                        <ns0:SUCCESS_INDICATOR>{ $responseHeader/successIndicator }</ns0:SUCCESS_INDICATOR>,
                        for $valDescripcionRespuesta in $responseHeader/messages
                        return(
                            <ns0:ERROR_MESSAGE>{ data($valDescripcionRespuesta) }</ns0:ERROR_MESSAGE>
                        )
                	)
            }
        </ns0:LIABILITY>
};

declare variable $productID as xs:string external;
declare variable $productType as xs:string external;
declare variable $responseHeader as element(aut:ResponseHeader) external;
declare variable $consultaSaldosTarjetaCreditoResponse as element(ns1:consultaSaldosTarjetaCreditoResponse) external;

xf:consultaSaldosTarjetaCreditoOut($productID,
	$responseHeader,
    $productType,
    $consultaSaldosTarjetaCreditoResponse)