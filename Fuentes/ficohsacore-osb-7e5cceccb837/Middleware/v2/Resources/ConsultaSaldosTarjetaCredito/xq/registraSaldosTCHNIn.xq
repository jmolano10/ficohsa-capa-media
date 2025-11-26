xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTarjetaCreditoResponse" element="ns1:sjConsultaSaldosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataHN/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/registraSaldosTC/xsd/registraSaldosTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/registraSaldosHNTCIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraSaldosTC";

declare function xf:registraSaldosHNTCIn($sjConsultaSaldosTarjetaCreditoResponse as element(ns1:sjConsultaSaldosTarjetaCreditoResponse),
    $outputParameters as element(ns0:OutputParameters), $valSaldoActual as xs:string?, $countryCode as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
        	<ns2:PT_SALDOS_TARJETA>
        	{
	        	for  $row in $outputParameters/ns0:RowSet/ns0:Row
	            return(
	         		<ns2:PT_SALDOS_TARJETA_ITEM>
			        {
			        	for  $rowBase in $outputParameters/ns0:RowSet/ns0:Row
						where $rowBase/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text() = 'BASE'
						for $rowAlt in $outputParameters/ns0:RowSet/ns0:Row
				        where $rowAlt/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text() = 'ALT'
				        let $orgBase := string($rowBase/ns0:Column[upper-case(@name) = 'ORG']/text())
				        let $orgAlt := string($rowAlt/ns0:Column[upper-case(@name) = 'ORG']/text())
				        let $saldosTCItemBase := $sjConsultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType[ORG = $orgBase]
			        	let $saldosTCItemAlt := $sjConsultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType[ORG = $orgAlt]
			        	let $valPagoContadoBase := xs:decimal($rowBase/ns0:Column[@name = 'INVOICED_BALANCE'])
			        	let $valPagoContadoAlt := xs:decimal($rowAlt/ns0:Column[@name = 'INVOICED_BALANCE'])
			    		let $LCY_TOTAL_PAYMENT := $valPagoContadoBase - data($sjConsultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT)
			            let $FCY_TOTAL_PAYMENT := $valPagoContadoAlt - data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT)
			            return(
	            		<ns2:CARD_NUMBER>{ string($rowBase/ns0:Column[@name = 'CARD_NUMBER']/text()) }</ns2:CARD_NUMBER>,
	                	<ns2:CARD_HOLDER_NAME>{ string($rowBase/ns0:Column[@name = 'CARD_HOLDER_NAME']/text())}</ns2:CARD_HOLDER_NAME>,
	                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT/text()))))then(
	                		<ns2:LCY_MIN_PAYMENT>{ data($sjConsultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT/text()) }</ns2:LCY_MIN_PAYMENT>
	                	)else(
	                		<ns2:LCY_MIN_PAYMENT>{ string($rowBase/ns0:Column[@name = 'MIN_PAYMENT']/text())}</ns2:LCY_MIN_PAYMENT>
	                	),
	                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT/text()))))then(
	                		if($LCY_TOTAL_PAYMENT >= 0)then(
	                			<ns2:LCY_TOTAL_PAYMENT>{ $LCY_TOTAL_PAYMENT }</ns2:LCY_TOTAL_PAYMENT>
	                		)else(
	                			<ns2:LCY_TOTAL_PAYMENT>0</ns2:LCY_TOTAL_PAYMENT>
	                		)
	                	)else(
	                		<ns2:LCY_TOTAL_PAYMENT>{ string($rowBase/ns0:Column[@name = 'TOTAL_PAYMENT']/text()) }</ns2:LCY_TOTAL_PAYMENT>
	                	),
	                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text()))))then(
	                		<ns2:FCY_MIN_PAYMENT>{ data($sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text()) }</ns2:FCY_MIN_PAYMENT>  	
	                	)else(
	                		<ns2:FCY_MIN_PAYMENT>{ string($rowAlt/ns0:Column[@name = 'MIN_PAYMENT']/text())}</ns2:FCY_MIN_PAYMENT>
	                	),
	                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT/text()))))then(
	                		if($FCY_TOTAL_PAYMENT >= 0)then(
	                			<ns2:FCY_TOTAL_PAYMENT>{ $FCY_TOTAL_PAYMENT }</ns2:FCY_TOTAL_PAYMENT>
	                		)else(
	                			<ns2:FCY_TOTAL_PAYMENT>0</ns2:FCY_TOTAL_PAYMENT>
	                		)
	                	)else(
	                		<ns2:FCY_TOTAL_PAYMENT>{ string($rowAlt/ns0:Column[@name = 'TOTAL_PAYMENT']/text()) }</ns2:FCY_TOTAL_PAYMENT>
	                	),
	                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT/text()))))then(
	                		<ns2:CREDIT_LIMIT>{ data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT/text()) }</ns2:CREDIT_LIMIT>
	                	)else(
	                		if(not(empty($rowAlt))) then (
	                			<ns2:CREDIT_LIMIT>{ string($rowAlt/ns0:Column[@name = 'CREDIT_LIMIT']/text()) }</ns2:CREDIT_LIMIT>
	                		)else(
	                			<ns2:CREDIT_LIMIT>{ string($rowBase/ns0:Column[@name = 'CREDIT_LIMIT']/text()) }</ns2:CREDIT_LIMIT>
	                		)
	                	),
	                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY/text()))))then(
	                		<ns2:CREDIT_LIMIT_CCY>{ data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY/text()) }</ns2:CREDIT_LIMIT_CCY>
	                	)else(
	                		if(not(empty($rowAlt))) then (
	                			<ns2:CREDIT_LIMIT_CCY>USD</ns2:CREDIT_LIMIT_CCY>
	                		)else(
	                			<ns2:CREDIT_LIMIT_CCY>HNL</ns2:CREDIT_LIMIT_CCY>
	                		)
	                	),
	                	if($valSaldoActual != '') then (
	        				<ns2:POINTS_EARNED>{ $valSaldoActual }</ns2:POINTS_EARNED>
	        			) else (),
	                	<ns2:MAX_PAYMENT_DATE>{ string($rowBase/ns0:Column[@name = 'MAX_PAYMENT_DATE']/text()) }</ns2:MAX_PAYMENT_DATE>,
			       		<ns2:LAST_CUTOFF_DATE>{ string($rowBase/ns0:Column[@name = 'LAST_CUTOFF_DATE']/text()) }</ns2:LAST_CUTOFF_DATE>,
			       		if($row/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text() = 'BASE')then(
			       			<ns2:ORG_TYPE>{ string($rowBase/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text()) }</ns2:ORG_TYPE>,
			       			<ns2:ORG>{ string($rowBase/ns0:Column[upper-case(@name) = 'ORG']/text()) }</ns2:ORG>,
			       			<ns2:CURRENCY>{ string($rowBase/ns0:Column[@name = 'CURRENCY']/text()) }</ns2:CURRENCY>,
			       			if(not(empty(data($saldosTCItemBase/OVERDUE_BALANCE))))then(
			       				<ns2:OVERDUE_BALANCE>{ data($saldosTCItemBase/OVERDUE_BALANCE) }</ns2:OVERDUE_BALANCE>
			       			)else(
			       				<ns2:OVERDUE_BALANCE>{ string($rowBase/ns0:Column[@name = 'OVERDUE_BALANCE']/text()) }</ns2:OVERDUE_BALANCE>
			       			),
			       			if(not(empty(data($saldosTCItemBase/FLOATING_BALANCE))))then(
			       				<ns2:FLOATING_BALANCE>{ data($saldosTCItemBase/FLOATING_BALANCE) }</ns2:FLOATING_BALANCE>
			       			)else(
			       				<ns2:FLOATING_BALANCE>{ string($rowBase/ns0:Column[@name = 'FLOATING_BALANCE']/text()) }</ns2:FLOATING_BALANCE>
			       			),
			       			<ns2:CURRENT_BALANCE>{ string($rowBase/ns0:Column[@name = 'CURRENT_BALANCE']/text()) }</ns2:CURRENT_BALANCE>,
			       			if(not(empty(data($saldosTCItemBase/PURCHASES_LIMIT))))then(
			       				<ns2:PURCHASES_LIMIT>{ data($saldosTCItemBase/PURCHASES_LIMIT) }</ns2:PURCHASES_LIMIT>
			       			)else(
			       				<ns2:PURCHASES_LIMIT>{ string($rowBase/ns0:Column[@name = 'PURCHASES_LIMIT']/text()) }</ns2:PURCHASES_LIMIT>
			       			),
			       			if(not(empty(data($saldosTCItemBase/WITHDRAWAL_LIMIT))))then(
			       				<ns2:WITHDRAWAL_LIMIT>{ data($saldosTCItemBase/WITHDRAWAL_LIMIT) }</ns2:WITHDRAWAL_LIMIT>
			       			)else(
			       				<ns2:WITHDRAWAL_LIMIT>{ string($rowBase/ns0:Column[@name = 'WITHDRAWAL_LIMIT']/text()) }</ns2:WITHDRAWAL_LIMIT>
			       			),
			       			if(not(empty(data($saldosTCItemBase/PAYMENTS_TODAY))))then(
			       				<ns2:PAYMENTS_TODAY>{ data($saldosTCItemBase/PAYMENTS_TODAY) }</ns2:PAYMENTS_TODAY>
			       			)else(
			       				<ns2:PAYMENTS_TODAY>{ string($rowBase/ns0:Column[@name = 'PAYMENTS_TODAY']/text()) }</ns2:PAYMENTS_TODAY>
			       			),
			       			if(string($rowBase/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) ='0.0')then(
	                            	 <ns2:AVAILABLE_EXTRA>0</ns2:AVAILABLE_EXTRA>	
	                            )else(
	                            	<ns2:AVAILABLE_EXTRA>{ string($rowBase/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) }</ns2:AVAILABLE_EXTRA>
	                        ),
	                        <ns2:CURRENT_BALANCE_EXTRA>0</ns2:CURRENT_BALANCE_EXTRA>,
		                	if(string($rowBase/ns0:Column[@name = 'INTRA_AMOUNT']/text()) ='0.0')then(
	                        	 <ns2:AVAILABLE_INTRA>0</ns2:AVAILABLE_INTRA>	
	                        )else(
	                        	<ns2:AVAILABLE_INTRA>{ string($rowBase/ns0:Column[@name = 'INTRA_AMOUNT']/text())}</ns2:AVAILABLE_INTRA>
	                        ),
			               <ns2:CURRENT_BALANCE_INTRA>0</ns2:CURRENT_BALANCE_INTRA>
			       		)else(
			       			<ns2:ORG_TYPE>{ string($rowAlt/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text()) }</ns2:ORG_TYPE>,
			       			<ns2:ORG>{ string($rowAlt/ns0:Column[upper-case(@name) = 'ORG']/text()) }</ns2:ORG>,
			       			<ns2:CURRENCY>{ string($rowAlt/ns0:Column[@name = 'CURRENCY']/text()) }</ns2:CURRENCY>,
			       			if(not(empty(data($saldosTCItemAlt/OVERDUE_BALANCE))))then(
			       				<ns2:OVERDUE_BALANCE>{ data($saldosTCItemAlt/OVERDUE_BALANCE) }</ns2:OVERDUE_BALANCE>
			       			)else(
			       				<ns2:OVERDUE_BALANCE>{ string($rowAlt/ns0:Column[@name = 'OVERDUE_BALANCE']/text()) }</ns2:OVERDUE_BALANCE>
			       			),
			       			if(not(empty(data($saldosTCItemAlt/FLOATING_BALANCE))))then(
			       				<ns2:FLOATING_BALANCE>{ data($saldosTCItemAlt/FLOATING_BALANCE) }</ns2:FLOATING_BALANCE>
			       			)else(
			       				<ns2:FLOATING_BALANCE>{ string($rowAlt/ns0:Column[@name = 'FLOATING_BALANCE']/text()) }</ns2:FLOATING_BALANCE>
			       			),
			       			<ns2:CURRENT_BALANCE>{ string($rowAlt/ns0:Column[@name = 'CURRENT_BALANCE']/text()) }</ns2:CURRENT_BALANCE>,
			       			if(not(empty(data($saldosTCItemAlt/PURCHASES_LIMIT))))then(
			       				<ns2:PURCHASES_LIMIT>{ data($saldosTCItemAlt/PURCHASES_LIMIT) }</ns2:PURCHASES_LIMIT>
			       			)else(
			       				<ns2:PURCHASES_LIMIT>{ string($rowAlt/ns0:Column[@name = 'PURCHASES_LIMIT']/text()) }</ns2:PURCHASES_LIMIT>
			       			),
			       			if(not(empty(data($saldosTCItemAlt/WITHDRAWAL_LIMIT))))then(
			       				<ns2:WITHDRAWAL_LIMIT>{ data($saldosTCItemAlt/WITHDRAWAL_LIMIT) }</ns2:WITHDRAWAL_LIMIT>
			       			)else(
			       				<ns2:WITHDRAWAL_LIMIT>{ string($rowAlt/ns0:Column[@name = 'WITHDRAWAL_LIMIT']/text()) }</ns2:WITHDRAWAL_LIMIT>
			       			),
			       			if(not(empty(data($saldosTCItemAlt/PAYMENTS_TODAY))))then(
			       				<ns2:PAYMENTS_TODAY>{ data($saldosTCItemAlt/PAYMENTS_TODAY) }</ns2:PAYMENTS_TODAY>
			       			)else(
			       				<ns2:PAYMENTS_TODAY>{ string($rowAlt/ns0:Column[@name = 'PAYMENTS_TODAY']/text()) }</ns2:PAYMENTS_TODAY>
			       			),
			       			if(string($rowAlt/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) ='0.0')then(
	                            	 <ns2:AVAILABLE_EXTRA>0</ns2:AVAILABLE_EXTRA>	
	                            )else(
	                            	<ns2:AVAILABLE_EXTRA>{ string($rowAlt/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) }</ns2:AVAILABLE_EXTRA>
	                        ),
	                        <ns2:CURRENT_BALANCE_EXTRA>0</ns2:CURRENT_BALANCE_EXTRA>,
		                	if(string($rowAlt/ns0:Column[@name = 'INTRA_AMOUNT']/text()) ='0.0')then(
	                        	 <ns2:AVAILABLE_INTRA>0</ns2:AVAILABLE_INTRA>	
	                        )else(
	                        	<ns2:AVAILABLE_INTRA>{ string($rowAlt/ns0:Column[@name = 'INTRA_AMOUNT']/text())}</ns2:AVAILABLE_INTRA>
	                        ),
			               <ns2:CURRENT_BALANCE_INTRA>0</ns2:CURRENT_BALANCE_INTRA>
			       		)  
			       	)  	
			        
			        }
			        </ns2:PT_SALDOS_TARJETA_ITEM>
			     )
			  }
		     </ns2:PT_SALDOS_TARJETA>
		     <ns2:PV_COUNTRY_CODE>{ $countryCode }</ns2:PV_COUNTRY_CODE>
       </ns2:InputParameters>
};

declare variable $sjConsultaSaldosTarjetaCreditoResponse as element(ns1:sjConsultaSaldosTarjetaCreditoResponse) external;
declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $valSaldoActual as xs:string? external;
declare variable $countryCode as xs:string external;

xf:registraSaldosHNTCIn($sjConsultaSaldosTarjetaCreditoResponse,
    $outputParameters, $valSaldoActual, $countryCode)