xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaSaldosTarjetaCreditoResponse" element="ns0:consultaSaldosTarjetaCreditoResponse" location="../../../../../Business_Resources/tarjetaCredito/ConsultaSaldosTarjetaCredito/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$responseHeader" element="ns2:ResponseHeader" location="../../../../Resources/esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:local-element-return type="ns1:sjConsultaMultipleProductosNIResponse/ns1:LIABILITIES/ns1:LIABILITY" location="../xsd/sjConsultaMultipleProductosNI.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosNI/xq/consultaSaldosTCOut/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosNI";

declare function numIsNull($item as item()?) as xs:decimal {
    if (fn:string($item/text()) != '' ) then (
        round-half-to-even( xs:decimal(data($item)), 2 )
    ) else (0.0)
};


declare function xf:consultaSaldosTCOut($consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse),
    $responseHeader as element(ns2:ResponseHeader),
    $productID as xs:string,
    $productType as xs:string,
    $buyRate as xs:string)
    as element() {
        <ns1:LIABILITY>
            <ns1:ID>{ $productID }</ns1:ID>
            {
                let $successIndicator := data($responseHeader/successIndicator)
                return
                    if (fn:upper-case($successIndicator) = 'SUCCESS')then(                  
                        
                        	let $productName := $consultaSaldosTarjetaCreditoResponse/CARD_HOLDER_NAME
                        	return
                            	<ns1:PRODUCT_NAME>{ data($productName) }</ns1:PRODUCT_NAME>,
                            	
                            let $saldosTarjetaCreditoLocal := $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[CURRENCY = 'NIO']
                        	let $saldosTarjetaCreditoForanea := $consultaSaldosTarjetaCreditoResponse/ns0:consultaSaldosTarjetaCreditoResponseType/ns0:consultaSaldosTarjetaCreditoResponseRecordType[CURRENCY = 'USD']
                        	return(
	                            <ns1:BALANCES>
	                            	{
	                                    for $nodoSaldoLocal in $saldosTarjetaCreditoLocal
	                                	return
	                                    <ns1:BALANCE>
	                                        <ns1:CURRENCY>{ data($nodoSaldoLocal/CURRENCY) }</ns1:CURRENCY>
	                                        <ns1:PRINCIPAL>{ numIsNull($nodoSaldoLocal/CURRENT_BALANCE) }</ns1:PRINCIPAL>
	                                        <ns1:INT_COMM>0.00</ns1:INT_COMM>,
	                                        <ns1:TOTAL>{ numIsNull($nodoSaldoLocal/CURRENT_BALANCE) }</ns1:TOTAL>
	                                        <ns1:WITHDRAWAL_LIMIT>{ numIsNull($nodoSaldoLocal/WITHDRAWAL_LIMIT) }</ns1:WITHDRAWAL_LIMIT>
	                                    </ns1:BALANCE>
	                                 } 
	                                       
	                                 {
	                                    for $nodoSaldoForanea in $saldosTarjetaCreditoForanea
	                                	return
	                                	<ns1:BALANCE>
	                                        <ns1:CURRENCY>{ data($nodoSaldoForanea/CURRENCY) }</ns1:CURRENCY>
	                                        <ns1:PRINCIPAL>{  numIsNull($nodoSaldoForanea/CURRENT_BALANCE) }</ns1:PRINCIPAL>
	                                        <ns1:INT_COMM>0.00</ns1:INT_COMM>,
	                                        <ns1:TOTAL>{ numIsNull($nodoSaldoForanea/CURRENT_BALANCE) }</ns1:TOTAL>
	                                        <ns1:WITHDRAWAL_LIMIT>{ numIsNull($nodoSaldoForanea/WITHDRAWAL_LIMIT) }</ns1:WITHDRAWAL_LIMIT>
	                                    </ns1:BALANCE>
	                                 }
	                            </ns1:BALANCES>,
	                            
	                            let $fecha := $consultaSaldosTarjetaCreditoResponse/MAX_PAYMENT_DATE
	                        	return
	                        	if(data($fecha) != "")then(
	                        		<ns1:NEXT_PAYMENT_DATE>{ fn-bea:date-from-string-with-format('yyyyMMdd',$fecha/text()) }</ns1:NEXT_PAYMENT_DATE>
	                        	)else(),
	                            
	                            <ns1:TSTANDING_TOTAL>
	                            {
		                            round-half-to-even(
			                            sum($saldosTarjetaCreditoLocal/CURRENT_BALANCE) + (sum($saldosTarjetaCreditoForanea/CURRENT_BALANCE) * xs:decimal($buyRate)),
			                             2
		                            )
		                        }
		                        </ns1:TSTANDING_TOTAL>,
		                        <ns1:CANCELATION_TOTAL>0.0</ns1:CANCELATION_TOTAL>,
		                        <ns1:TOTAL_AMOUNT>0.0</ns1:TOTAL_AMOUNT>,
	                            <ns1:TYPE>{ $productType }</ns1:TYPE>,
	                            <ns1:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns1:OPENING_DATE>,
	                    		<ns1:SOURCE_BANK>NI01</ns1:SOURCE_BANK>,
	                    		<ns1:SUCCESS_INDICATOR>{ $responseHeader/successIndicator }</ns1:SUCCESS_INDICATOR>
                    		)
                	   )
                   else( 
                        <ns1:TYPE>{ $productType }</ns1:TYPE>,
                        <ns1:SOURCE_BANK>NI01</ns1:SOURCE_BANK>,
                        <ns1:SUCCESS_INDICATOR>{ $responseHeader/successIndicator }</ns1:SUCCESS_INDICATOR>,
                        for $valDescripcionRespuesta in $responseHeader/messages
                        return(
                            <ns1:ERROR_MESSAGE>{ data($valDescripcionRespuesta) }</ns1:ERROR_MESSAGE>
                        )
                   )
            }
        </ns1:LIABILITY>
};

declare variable $consultaSaldosTarjetaCreditoResponse as element(ns0:consultaSaldosTarjetaCreditoResponse) external;
declare variable $responseHeader as element(ns2:ResponseHeader) external;
declare variable $productID as xs:string external;
declare variable $productType as xs:string external;
declare variable $buyRate as xs:string external;

xf:consultaSaldosTCOut($consultaSaldosTarjetaCreditoResponse,
    $responseHeader,
    $productID,
    $productType,
    $buyRate)