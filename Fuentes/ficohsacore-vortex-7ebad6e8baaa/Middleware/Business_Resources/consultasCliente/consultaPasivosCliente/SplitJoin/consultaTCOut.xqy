xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTarjetaCreditoTypeResponse1" element="ns0:ConsultaTarjetaCreditoTypeResponse" location="../consultaTC/ConsultaTarjetaCreditoCliente.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/SplitJoin/consultaTCOut2/";
declare namespace ns0 = "ConsultaTarjetaCreditoCliente";

declare function xf:consultaTCOut2($consultaTarjetaCreditoTypeResponse1 as element(ns0:ConsultaTarjetaCreditoTypeResponse),
    $exchangeRate as xs:string)
    as element(*) {
    	<TarjetasCredito>
    	{
	        for $detalleTarjetaCredito in $consultaTarjetaCreditoTypeResponse1/ns0:CREDIT_CARD_DETAILS/ns0:CREDIT_CARD_DETAIL
	        return
	        	let $cardNumber := fn:string($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:CARD_NUMBER/text())
	        	let $cardHolderName := fn:string($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:CARD_HOLDER_NAME/text())
	        	let $fechaMaxima := fn:string($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:MAX_PAYMENT_DATE/text())
	        	let $localCcy := fn:string($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:BALANCE_DETAILS/ns0:BALANCE_DETAIL[1]/ns0:CURRENCY/text())
	        	let $foreignCcy := fn:string($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:BALANCE_DETAILS/ns0:BALANCE_DETAIL[2]/ns0:CURRENCY/text())
	        	let $lcyCurrentBalance := xs:decimal($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:BALANCE_DETAILS/ns0:BALANCE_DETAIL[ns0:CURRENCY=$localCcy]/ns0:CURRENT_BALANCE/text())
	        	let $fcyCurrentBalance := xs:decimal($detalleTarjetaCredito/ns0:RESPONSE_BODY/ns0:BALANCE_DETAILS/ns0:BALANCE_DETAIL[ns0:CURRENCY=$foreignCcy]/ns0:CURRENT_BALANCE/text())
	        	let $totalBalance := fn-bea:format-number(fn-bea:decimal-round($lcyCurrentBalance + ( $fcyCurrentBalance * xs:decimal($exchangeRate)), 2),"########0.00")
	        	return
		        	<Tarjeta>
		        		<CARD_NUMBER>{ $cardNumber }</CARD_NUMBER>
		        		<CARD_HOLDER_NAME>{ $cardHolderName }</CARD_HOLDER_NAME>
	    				<LOCAL_CURRENCY>{ $localCcy }</LOCAL_CURRENCY>
	    				<LOCAL_BALANCE>{ fn-bea:format-number($lcyCurrentBalance,"#########0.00") }</LOCAL_BALANCE>
	    				<FOREIGN_CURRENCY>{ $foreignCcy }</FOREIGN_CURRENCY>
	    				<FOREIGN_BALANCE>{ fn-bea:format-number($fcyCurrentBalance,"#########0.00") }</FOREIGN_BALANCE>
	    				<TOTAL_BALANCE>
	    				{
	    					if (fn:string($totalBalance) != "NaN") then (
			    				$totalBalance
			    			) else (
			    				"0.00"
			    			)
	    				}	    				  				
	    				</TOTAL_BALANCE>
	    				<MAX_PAYMENT_DATE>{ $fechaMaxima }</MAX_PAYMENT_DATE>
		        	</Tarjeta>
		}
        </TarjetasCredito>
};

declare variable $consultaTarjetaCreditoTypeResponse1 as element(ns0:ConsultaTarjetaCreditoTypeResponse) external;
declare variable $exchangeRate as xs:string external;

xf:consultaTCOut2($consultaTarjetaCreditoTypeResponse1,
    $exchangeRate)