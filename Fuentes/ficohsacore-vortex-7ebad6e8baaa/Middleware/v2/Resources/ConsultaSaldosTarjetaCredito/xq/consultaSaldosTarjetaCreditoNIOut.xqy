xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/consultaSaldosTC/xsd/consultaSaldosTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTarjetaCreditoResponse" element="ns1:sjConsultaSaldosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldosTarjetaCreditoResponse" location="../xsd/consultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$saldosOffLine" element="ns3:OutputParameters" location="../../../BusinessServices/MasterDataHN/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/consultaSaldosTarjetaCreditoHN_v2Out/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldosTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";

declare function xf:consultaSaldosTarjetaCreditoNIOut($outputParameters as element(ns2:OutputParameters)?,
    $sjConsultaSaldosTarjetaCreditoResponse as element(ns1:sjConsultaSaldosTarjetaCreditoResponse)?,
    $valSaldoActual as xs:string?, $saldosOffLine as element(ns3:OutputParameters)?)
    as element(ns0:consultaSaldosTarjetaCreditoResponse) {
        <ns0:consultaSaldosTarjetaCreditoResponse>
        {
        	if(not(empty($outputParameters/ns2:PT_SALDOS_TARJETA/ns2:PT_SALDOS_TARJETA_ITEM))) then (
        		let $rowBase := $outputParameters/ns2:PT_SALDOS_TARJETA/ns2:PT_SALDOS_TARJETA_ITEM[ns2:ORG_TYPE = 'BASE']
        		let $rowAlt := $outputParameters/ns2:PT_SALDOS_TARJETA/ns2:PT_SALDOS_TARJETA_ITEM[ns2:ORG_TYPE = 'ALT']
        		return
        		(
        			for $CARD_NUMBER in $rowBase/ns2:CARD_NUMBER
        			return
        				<CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>,
        			for $CARD_HOLDER_NAME in $rowBase/ns2:CARD_HOLDER_NAME
        			return
        				<CARD_HOLDER_NAME>{ fn:replace(data($CARD_HOLDER_NAME), "[Ññ]", "#")} </CARD_HOLDER_NAME>,
        			for $LCY_MIN_PAYMENT in $rowBase/ns2:LCY_MIN_PAYMENT
        			return
        				<LCY_MIN_PAYMENT>{ data($LCY_MIN_PAYMENT) }</LCY_MIN_PAYMENT>,
        			for $LCY_TOTAL_PAYMENT in $rowBase/ns2:LCY_TOTAL_PAYMENT
        			return
        				<LCY_TOTAL_PAYMENT>{ data($LCY_TOTAL_PAYMENT) }</LCY_TOTAL_PAYMENT>,
        				
        			if(not(empty($rowAlt)))then(
        				for $FCY_MIN_PAYMENT in $rowAlt/ns2:FCY_MIN_PAYMENT
        				return
        				<FCY_MIN_PAYMENT>{ data($FCY_MIN_PAYMENT) }</FCY_MIN_PAYMENT>,
        				for $FCY_TOTAL_PAYMENT in $rowAlt/ns2:FCY_TOTAL_PAYMENT
        				return
        				<FCY_TOTAL_PAYMENT>{ data($FCY_TOTAL_PAYMENT) }</FCY_TOTAL_PAYMENT>
        			)else(
        				<FCY_MIN_PAYMENT>0</FCY_MIN_PAYMENT>,
        				<FCY_TOTAL_PAYMENT>0</FCY_TOTAL_PAYMENT>
        			),
        			for $CREDIT_LIMIT in $rowBase/ns2:CREDIT_LIMIT
        			return
        				<CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>,
        			for $CREDIT_LIMIT_CCY in $rowBase/ns2:CREDIT_LIMIT_CCY
        			return
        				<CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>,

        			for $POINTS_EARNED in $rowBase/ns2:POINTS_EARNED
        			return
        				<POINTS_EARNED>{ data($POINTS_EARNED) }</POINTS_EARNED>,
 

        			for $MAX_PAYMENT_DATE in $rowBase/ns2:MAX_PAYMENT_DATE
        			return
        				<MAX_PAYMENT_DATE>{ data($MAX_PAYMENT_DATE) }</MAX_PAYMENT_DATE>,
        			for $LAST_CUTOFF_DATE in $rowBase/ns2:LAST_CUTOFF_DATE
        			return
        				<LAST_CUTOFF_DATE>{ data($LAST_CUTOFF_DATE) }</LAST_CUTOFF_DATE>,
        			<ns0:consultaSaldosTarjetaCreditoResponseType>
        				<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
        					{
        						for $CURRENCY in $rowBase/ns2:CURRENCY
        						return
        							<CURRENCY>{ data($CURRENCY) }</CURRENCY>
        					}
        					{
        						for $OVERDUE_BALANCE in $rowBase/ns2:OVERDUE_BALANCE
        						return
        							<OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</OVERDUE_BALANCE>
        					}
        					{
        						for $FLOATING_BALANCE in $rowBase/ns2:FLOATING_BALANCE
        						return
        							<FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</FLOATING_BALANCE>
        					}
        					{
        						for $CURRENT_BALANCE in $rowBase/ns2:CURRENT_BALANCE
        						return
        							<CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>
        					}
        					{
        						for $PURCHASES_LIMIT in $rowBase/ns2:PURCHASES_LIMIT
        						return
        							<PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</PURCHASES_LIMIT>
        					}
        					{
        						for $WITHDRAWAL_LIMIT in $rowBase/ns2:WITHDRAWAL_LIMIT
        						return
        							<WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
        					}
        					{
        						for $PAYMENTS_TODAY in $rowBase/ns2:PAYMENTS_TODAY
        						return
        							<PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</PAYMENTS_TODAY>
        					}
        					{
        						for $AVAILABLE_EXTRA in $rowBase/ns2:AVAILABLE_EXTRA
        						return
        							<AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</AVAILABLE_EXTRA>
        					}
        					{
        						for $CURRENT_BALANCE_EXTRA in $rowBase/ns2:CURRENT_BALANCE_EXTRA
        						return
        							<CURRENT_BALANCE_EXTRA>{ data($CURRENT_BALANCE_EXTRA) }</CURRENT_BALANCE_EXTRA>
        					}
        					{
        						for $AVAILABLE_INTRA in $rowBase/ns2:AVAILABLE_INTRA
        						return
        							<AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</AVAILABLE_INTRA>
        					}
        					{
        						for $CURRENT_BALANCE_INTRA in $rowBase/ns2:CURRENT_BALANCE_INTRA
        						return
        							<CURRENT_BALANCE_INTRA>{ data($CURRENT_BALANCE_INTRA) }</CURRENT_BALANCE_INTRA>
        					}
        				</ns0:consultaSaldosTarjetaCreditoResponseRecordType>
        				{
        					if(not(empty($rowAlt))) then (
        						<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
        						{
        							for $CURRENCY in $rowAlt/ns2:CURRENCY
        							return
        								<CURRENCY>{ data($CURRENCY) }</CURRENCY>,
        							for $OVERDUE_BALANCE in $rowAlt/ns2:OVERDUE_BALANCE
        							return
        								<OVERDUE_BALANCE>{ data($OVERDUE_BALANCE) }</OVERDUE_BALANCE>,
        							for $FLOATING_BALANCE in $rowAlt/ns2:FLOATING_BALANCE
        							return
        								<FLOATING_BALANCE>{ data($FLOATING_BALANCE) }</FLOATING_BALANCE>,
        							for $CURRENT_BALANCE in $rowAlt/ns2:CURRENT_BALANCE
        							return
        								<CURRENT_BALANCE>{ data($CURRENT_BALANCE) }</CURRENT_BALANCE>,
        							for $PURCHASES_LIMIT in $rowAlt/ns2:PURCHASES_LIMIT
        							return
        								<PURCHASES_LIMIT>{ data($PURCHASES_LIMIT) }</PURCHASES_LIMIT>,
        							for $WITHDRAWAL_LIMIT in $rowAlt/ns2:WITHDRAWAL_LIMIT
        							return
        								<WITHDRAWAL_LIMIT>{ data($WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>,
        							for $PAYMENTS_TODAY in $rowAlt/ns2:PAYMENTS_TODAY
        							return
        								<PAYMENTS_TODAY>{ data($PAYMENTS_TODAY) }</PAYMENTS_TODAY>,
        							for $AVAILABLE_EXTRA in $rowAlt/ns2:AVAILABLE_EXTRA
        							return
        								<AVAILABLE_EXTRA>{ data($AVAILABLE_EXTRA) }</AVAILABLE_EXTRA>,
        							for $CURRENT_BALANCE_EXTRA in $rowAlt/ns2:CURRENT_BALANCE_EXTRA
        							return
        								<CURRENT_BALANCE_EXTRA>{ data($CURRENT_BALANCE_EXTRA) }</CURRENT_BALANCE_EXTRA>,
        							for $AVAILABLE_INTRA in $rowAlt/ns2:AVAILABLE_INTRA
        							return
        								<AVAILABLE_INTRA>{ data($AVAILABLE_INTRA) }</AVAILABLE_INTRA>,
        							for $CURRENT_BALANCE_INTRA in $rowAlt/ns2:CURRENT_BALANCE_INTRA
        							return
        								<CURRENT_BALANCE_INTRA>{ data($CURRENT_BALANCE_INTRA) }</CURRENT_BALANCE_INTRA>
        						}
        						</ns0:consultaSaldosTarjetaCreditoResponseRecordType>
        					) else ()
        				}
        			</ns0:consultaSaldosTarjetaCreditoResponseType>
        				
        		)
        	) else (
        		for  $rowBase in $saldosOffLine/ns3:RowSet/ns3:Row
				where $rowBase/ns3:Column[upper-case(@name) = 'TYPE_ORG']/text() = 'BASE'
				for $rowAlt in $saldosOffLine/ns3:RowSet/ns3:Row
		        where $rowAlt/ns3:Column[upper-case(@name) = 'TYPE_ORG']/text() = 'ALT'
		        let $orgBase := string($rowBase/ns3:Column[upper-case(@name) = 'ORG']/text())
		        let $orgAlt := string($rowAlt/ns3:Column[upper-case(@name) = 'ORG']/text())
		        let $currencyBase:= string($rowBase/ns3:Column[upper-case(@name) = 'CURRENCY']/text())
		        let $currencyAlt:= string($rowAlt/ns3:Column[upper-case(@name) = 'CURRENCY']/text())
		        let $saldosTCItemBase := $sjConsultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType[ORG = $orgBase]
	        	let $saldosTCItemAlt := $sjConsultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType[ORG = $orgAlt]
	        	let $valPagoContadoBase := xs:decimal($rowBase/ns3:Column[@name = 'INVOICED_BALANCE'])
	        	let $valPagoContadoAlt := xs:decimal($rowAlt/ns3:Column[@name = 'INVOICED_BALANCE'])
	        	    
	    		let $LCY_TOTAL_PAYMENT_BASE := $valPagoContadoBase - data($sjConsultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT)
	            let $FCY_TOTAL_PAYMENT_BASE := $valPagoContadoAlt - data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT)
	            
	    		let $LCY_TOTAL_PAYMENT_ALT := $valPagoContadoAlt - data($sjConsultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT)
	            let $FCY_TOTAL_PAYMENT_ALT := $valPagoContadoBase - data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT)	            
    			return(

    				<CARD_NUMBER>{ string($rowBase/ns3:Column[@name = 'CARD_NUMBER']/text()) }</CARD_NUMBER>,
                	<CARD_HOLDER_NAME>{ fn:replace(string($rowBase/ns3:Column[@name = 'CARD_HOLDER_NAME']/text()), "[Ññ]", "#")}</CARD_HOLDER_NAME>,
                	
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT/text()))))then(
                		<LCY_MIN_PAYMENT>{ data($sjConsultaSaldosTarjetaCreditoResponse/LCY_MIN_PAYMENT/text()) }</LCY_MIN_PAYMENT>
                	)else(
                		if($currencyBase='NIO')then(
                			<LCY_MIN_PAYMENT>{ string($rowBase/ns3:Column[@name = 'MIN_PAYMENT']/text())}</LCY_MIN_PAYMENT>
                		
                		)else(
	                		<LCY_MIN_PAYMENT>{ string($rowAlt/ns3:Column[@name = 'MIN_PAYMENT']/text())}</LCY_MIN_PAYMENT>
                		
                		)
                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/LCY_TOTAL_PAYMENT/text()))))then(
                		if($currencyBase='NIO')then(
	                		if($LCY_TOTAL_PAYMENT_BASE >= 0)then(
	                			<LCY_TOTAL_PAYMENT>{ $LCY_TOTAL_PAYMENT_BASE }</LCY_TOTAL_PAYMENT>
	                		)else(
	                			<LCY_TOTAL_PAYMENT>0</LCY_TOTAL_PAYMENT>
	                		)                		
                		
                		)else(
	                		if($LCY_TOTAL_PAYMENT_ALT >= 0)then(
	                			<LCY_TOTAL_PAYMENT>{ $LCY_TOTAL_PAYMENT_ALT }</LCY_TOTAL_PAYMENT>
	                		)else(
	                			<LCY_TOTAL_PAYMENT>0</LCY_TOTAL_PAYMENT>
	                		)                 		
                		
                		)	

                	)else(
                		if($currencyBase='NIO')then(
	                		<LCY_TOTAL_PAYMENT>{ string($rowBase/ns3:Column[@name = 'TOTAL_PAYMENT']/text()) }</LCY_TOTAL_PAYMENT>
                		
                		)else(
                			<LCY_TOTAL_PAYMENT>{ string($rowAlt/ns3:Column[@name = 'TOTAL_PAYMENT']/text()) }</LCY_TOTAL_PAYMENT>
                		
                		)
                	),
                	
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text()))))then(
                		<FCY_MIN_PAYMENT>{ data($sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text()) }</FCY_MIN_PAYMENT>  	
                	)else(
                		if($currencyBase='NIO')then(
                			<FCY_MIN_PAYMENT>{ string($rowAlt/ns3:Column[@name = 'MIN_PAYMENT']/text())}</FCY_MIN_PAYMENT>                		
                		)else(
                			<FCY_MIN_PAYMENT>{ string($rowBase/ns3:Column[@name = 'MIN_PAYMENT']/text())}</FCY_MIN_PAYMENT>                		
                		)
                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT/text()))))then(
                		if($currencyBase='NIO')then(
	                		if($FCY_TOTAL_PAYMENT_BASE >= 0)then(
	                			<FCY_TOTAL_PAYMENT>{ $FCY_TOTAL_PAYMENT_BASE }</FCY_TOTAL_PAYMENT>
	                		)else(
	                			<FCY_TOTAL_PAYMENT>0</FCY_TOTAL_PAYMENT>
	                		)                		
                		)else(
	                		if($FCY_TOTAL_PAYMENT_ALT >= 0)then(
	                			<FCY_TOTAL_PAYMENT>{ $FCY_TOTAL_PAYMENT_ALT }</FCY_TOTAL_PAYMENT>
	                		)else(
	                			<FCY_TOTAL_PAYMENT>0</FCY_TOTAL_PAYMENT>
	                		)                 		
                		)

                	)else(
                		if($currencyBase='NIO')then(
                 			<FCY_TOTAL_PAYMENT>{ string($rowAlt/ns3:Column[@name = 'TOTAL_PAYMENT']/text()) }</FCY_TOTAL_PAYMENT>               		
                		)else(
                			<FCY_TOTAL_PAYMENT>{ string($rowBase/ns3:Column[@name = 'TOTAL_PAYMENT']/text()) }</FCY_TOTAL_PAYMENT>
                		
                		)
                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT/text()))))then(
                		<CREDIT_LIMIT>{ data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT/text()) }</CREDIT_LIMIT>
                	)else(
                		if(($orgBase = '333') or ($orgBase = '332'))then(
	                		if(not(empty($rowBase))) then (
	                			<CREDIT_LIMIT>{ string($rowBase/ns3:Column[@name = 'CREDIT_LIMIT']/text()) }</CREDIT_LIMIT>
	                		)else(
	                			<CREDIT_LIMIT>{ string($rowAlt/ns3:Column[@name = 'CREDIT_LIMIT']/text()) }</CREDIT_LIMIT>
	                		)                		
                		)else(
	                		if(not(empty($rowAlt))) then (
	                			<CREDIT_LIMIT>{ string($rowAlt/ns3:Column[@name = 'CREDIT_LIMIT']/text()) }</CREDIT_LIMIT>
	                		)else(
	                			<CREDIT_LIMIT>{ string($rowBase/ns3:Column[@name = 'CREDIT_LIMIT']/text()) }</CREDIT_LIMIT>
	                		)                		
                		
                		)

                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY/text()))))then(
                		<CREDIT_LIMIT_CCY>{ data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY/text()) }</CREDIT_LIMIT_CCY>
                	)else(
                		if(($orgBase = '333') or ($orgBase = '332'))then(
	                		if(not(empty($rowBase))) then (
	                			<CREDIT_LIMIT_CCY>{ string($rowBase/ns3:Column[@name = 'CURRENCY']/text()) }</CREDIT_LIMIT_CCY>
	                		)else(
	                			<CREDIT_LIMIT_CCY>{ string($rowAlt/ns3:Column[@name = 'CURRENCY']/text()) }</CREDIT_LIMIT_CCY>
	                		)                		
                		)else(
	                		if(not(empty($rowAlt))) then (
	                			<CREDIT_LIMIT_CCY>{ string($rowAlt/ns0:Column[@name = 'CURRENCY']/text()) }</CREDIT_LIMIT_CCY>
	                		)else(
	                			<CREDIT_LIMIT_CCY>{ string($rowBase/ns0:Column[@name = 'CURRENCY']/text()) }</CREDIT_LIMIT_CCY>
	                		)                		
                		)

                	),
                	if($valSaldoActual != '') then (
        				<POINTS_EARNED>{ $valSaldoActual }</POINTS_EARNED>
        			) else (),
                	<MAX_PAYMENT_DATE>{ string($rowBase/ns3:Column[@name = 'MAX_PAYMENT_DATE']/text()) }</MAX_PAYMENT_DATE>,
		       		<LAST_CUTOFF_DATE>{ string($rowBase/ns3:Column[@name = 'LAST_CUTOFF_DATE']/text()) }</LAST_CUTOFF_DATE>,
		            <ns0:consultaSaldosTarjetaCreditoResponseType>
		            	<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
		            		<CURRENCY>{ string($rowBase/ns3:Column[@name = 'CURRENCY']/text()) }</CURRENCY>
		            		{
				       			if(not(empty(data($saldosTCItemBase/OVERDUE_BALANCE))))then(
				       				<OVERDUE_BALANCE>{ data($saldosTCItemBase/OVERDUE_BALANCE) }</OVERDUE_BALANCE>
				       			)else(
				       				<OVERDUE_BALANCE>{ string($rowBase/ns3:Column[@name = 'OVERDUE_BALANCE']/text()) }</OVERDUE_BALANCE>
				       			)
			       			}
			       			{
				       			if(not(empty(data($saldosTCItemBase/FLOATING_BALANCE))))then(
				       				<FLOATING_BALANCE>{ data($saldosTCItemBase/FLOATING_BALANCE) }</FLOATING_BALANCE>
				       			)else(
				       				<FLOATING_BALANCE>{ string($rowBase/ns3:Column[@name = 'FLOATING_BALANCE']/text()) }</FLOATING_BALANCE>
				       			)
			       			}
							{
					       		let $currentBalance := $rowBase/ns3:Column[@name = 'CURRENT_BALANCE']/text() - $saldosTCItemBase/PAYMENTS_TODAY/text()
					       		return
					       			if(string($currentBalance) != '')then(
				            			<CURRENT_BALANCE>{ fn-bea:decimal-round(xs:decimal($currentBalance), 2) }</CURRENT_BALANCE>
				            		)else(
				            			<CURRENT_BALANCE>{ $rowBase/ns3:Column[@name = 'CURRENT_BALANCE']/text() }</CURRENT_BALANCE>
				            		)
					       	}
			       			{
				       			if(not(empty(data($saldosTCItemBase/PURCHASES_LIMIT))))then(
				       				<PURCHASES_LIMIT>{ data($saldosTCItemBase/PURCHASES_LIMIT) }</PURCHASES_LIMIT>
				       			)else(
				       				<PURCHASES_LIMIT>{ string($rowBase/ns3:Column[@name = 'PURCHASES_LIMIT']/text()) }</PURCHASES_LIMIT>
				       			)
				       		}
				       		{
				       			if(not(empty(data($saldosTCItemBase/WITHDRAWAL_LIMIT))))then(
				       				<WITHDRAWAL_LIMIT>{ data($saldosTCItemBase/WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
				       			)else(
				       				<WITHDRAWAL_LIMIT>{ string($rowBase/ns3:Column[@name = 'WITHDRAWAL_LIMIT']/text()) }</WITHDRAWAL_LIMIT>
				       			)
				       		}
				       		{
				       			if(not(empty(data($saldosTCItemBase/PAYMENTS_TODAY))))then(
				       				<PAYMENTS_TODAY>{ data($saldosTCItemBase/PAYMENTS_TODAY) }</PAYMENTS_TODAY>
				       			)else(
				       				<PAYMENTS_TODAY>{ string($rowBase/ns3:Column[@name = 'PAYMENTS_TODAY']/text()) }</PAYMENTS_TODAY>
				       			)
				       		}
				       		{
				       			if(string($rowBase/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) ='0.0')then(
		                            	 <AVAILABLE_EXTRA>0</AVAILABLE_EXTRA>	
		                            )else(
		                            	<AVAILABLE_EXTRA>{ string($rowBase/ns3:Column[@name = 'EXTRA_AMOUNT']/text()) }</AVAILABLE_EXTRA>
		                        )
		                    }
	                        <CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>
		                	{
			                	if(string($rowBase/ns0:Column[@name = 'INTRA_AMOUNT']/text()) ='0.0')then(
		                        	 <AVAILABLE_INTRA>0</AVAILABLE_INTRA>	
		                        )else(
		                        	<AVAILABLE_INTRA>{ string($rowBase/ns3:Column[@name = 'INTRA_AMOUNT']/text())}</AVAILABLE_INTRA>
		                        )
		                    }
			               <CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>
		            	</ns0:consultaSaldosTarjetaCreditoResponseRecordType>
		            	{
			            	if(not(empty($rowAlt)))then(
			            		<ns0:consultaSaldosTarjetaCreditoResponseRecordType>
					            	<CURRENCY>{ string($rowAlt/ns3:Column[@name = 'CURRENCY']/text()) }</CURRENCY>
					            	{
						            	if(not(empty(data($saldosTCItemAlt/OVERDUE_BALANCE))))then(
						       				<OVERDUE_BALANCE>{ data($saldosTCItemAlt/OVERDUE_BALANCE) }</OVERDUE_BALANCE>
						       			)else(
						       				<OVERDUE_BALANCE>{ string($rowAlt/ns3:Column[@name = 'OVERDUE_BALANCE']/text()) }</OVERDUE_BALANCE>
						       			)
						       		}
						       		{
						       			if(not(empty(data($saldosTCItemAlt/FLOATING_BALANCE))))then(
						       				<FLOATING_BALANCE>{ data($saldosTCItemAlt/FLOATING_BALANCE) }</FLOATING_BALANCE>
						       			)else(
						       				<FLOATING_BALANCE>{ string($rowAlt/ns3:Column[@name = 'FLOATING_BALANCE']/text()) }</FLOATING_BALANCE>
						       			)
						       		}
									{
							       		let $currentBalance := $rowAlt/ns3:Column[@name = 'CURRENT_BALANCE']/text() - $saldosTCItemAlt/PAYMENTS_TODAY/text()
							       		return
							       			if(string($currentBalance) != '')then(
						            			<CURRENT_BALANCE>{ fn-bea:decimal-round(xs:decimal($currentBalance), 2) }</CURRENT_BALANCE>
						            		)else(
						            			<CURRENT_BALANCE>{ $rowAlt/ns3:Column[@name = 'CURRENT_BALANCE']/text() }</CURRENT_BALANCE>
						            		)
							       	}
					       			{
						       			if(not(empty(data($saldosTCItemAlt/PURCHASES_LIMIT))))then(
						       				<PURCHASES_LIMIT>{ data($saldosTCItemAlt/PURCHASES_LIMIT) }</PURCHASES_LIMIT>
						       			)else(
						       				<PURCHASES_LIMIT>{ string($rowAlt/ns3:Column[@name = 'PURCHASES_LIMIT']/text()) }</PURCHASES_LIMIT>
						       			)
						       		}
						       		{
						       			if(not(empty(data($saldosTCItemAlt/WITHDRAWAL_LIMIT))))then(
						       				<WITHDRAWAL_LIMIT>{ data($saldosTCItemAlt/WITHDRAWAL_LIMIT) }</WITHDRAWAL_LIMIT>
						       			)else(
						       				<WITHDRAWAL_LIMIT>{ string($rowAlt/ns3:Column[@name = 'WITHDRAWAL_LIMIT']/text()) }</WITHDRAWAL_LIMIT>
						       			)
						       		}
						       		{
						       			if(not(empty(data($saldosTCItemAlt/PAYMENTS_TODAY))))then(
						       				<PAYMENTS_TODAY>{ data($saldosTCItemAlt/PAYMENTS_TODAY) }</PAYMENTS_TODAY>
						       			)else(
						       				<PAYMENTS_TODAY>{ string($rowAlt/ns3:Column[@name = 'PAYMENTS_TODAY']/text()) }</PAYMENTS_TODAY>
						       			)
						       		}
						       		{
						       			if(string($rowAlt/ns3:Column[@name = 'EXTRA_AMOUNT']/text()) ='0.0')then(
				                            	 <AVAILABLE_EXTRA>0</AVAILABLE_EXTRA>	
				                            )else(
				                            	<AVAILABLE_EXTRA>{ string($rowAlt/ns3:Column[@name = 'EXTRA_AMOUNT']/text()) }</AVAILABLE_EXTRA>
				                        )
				                    }
			                        <CURRENT_BALANCE_EXTRA>0</CURRENT_BALANCE_EXTRA>
				                   {
					                	if(string($rowAlt/ns3:Column[@name = 'INTRA_AMOUNT']/text()) ='0.0')then(
				                        	 <AVAILABLE_INTRA>0</AVAILABLE_INTRA>	
				                        )else(
				                        	<AVAILABLE_INTRA>{ string($rowAlt/ns3:Column[@name = 'INTRA_AMOUNT']/text())}</AVAILABLE_INTRA>
				                        )
				                   }
					               <CURRENT_BALANCE_INTRA>0</CURRENT_BALANCE_INTRA>
				           		</ns0:consultaSaldosTarjetaCreditoResponseRecordType>
			            	) else ()
			            }
        			</ns0:consultaSaldosTarjetaCreditoResponseType>
        		)
        	)
        }
        </ns0:consultaSaldosTarjetaCreditoResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters)? external;
declare variable $sjConsultaSaldosTarjetaCreditoResponse as element(ns1:sjConsultaSaldosTarjetaCreditoResponse)? external;
declare variable $valSaldoActual as xs:string? external;
declare variable $saldosOffLine as element(ns3:OutputParameters)? external;

xf:consultaSaldosTarjetaCreditoNIOut($outputParameters,
    $sjConsultaSaldosTarjetaCreditoResponse,
    $valSaldoActual,
    $saldosOffLine)