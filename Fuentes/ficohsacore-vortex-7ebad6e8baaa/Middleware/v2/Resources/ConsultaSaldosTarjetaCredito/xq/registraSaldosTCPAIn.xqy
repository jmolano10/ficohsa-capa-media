xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldosTarjetaCreditoResponse" element="ns1:sjConsultaSaldosTarjetaCreditoResponse" location="../../../BusinessServices/SJS/consultaSaldosTarjetaCredito/xsd/sjConsultaSaldosTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataPA/osbConSaldosTCOffLine/xsd/osbConSaldosTCOffLine_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/registraSaldosTC/xsd/registraSaldosTC_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldosTarjetaCredito/xq/registraSaldosHNTCIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConSaldosTCOffLine";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldosTarjetaCreditoTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraSaldosTC";

declare function xf:registraSaldosPATCIn($sjConsultaSaldosTarjetaCreditoResponse as element(ns1:sjConsultaSaldosTarjetaCreditoResponse),
    $outputParameters as element(ns0:OutputParameters), $valSaldoActual as xs:string?, $countryCode as xs:string)
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
        	<ns2:PT_SALDOS_TARJETA>
        	{
        	for  $row in $outputParameters/ns0:RowSet/ns0:Row
            return(
         		<ns2:PT_SALDOS_TARJETA_ITEM>
		        {
			        let $saldosTCItemBase := $sjConsultaSaldosTarjetaCreditoResponse/ns1:consultaSaldosTarjetaCreditoResponseType/ns1:consultaSaldosTarjetaCreditoResponseRecordType
		        	let $valPagoContadoBase := xs:decimal($row/ns0:Column[@name = 'INVOICED_BALANCE'])
		            let $FCY_TOTAL_PAYMENT := $valPagoContadoBase -  xs:decimal(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT))
		            return(
            		<ns2:CARD_NUMBER>{ string($row/ns0:Column[@name = 'CARD_NUMBER']/text()) }</ns2:CARD_NUMBER>,
                	<ns2:CARD_HOLDER_NAME>{ string($row/ns0:Column[@name = 'CARD_HOLDER_NAME']/text())}</ns2:CARD_HOLDER_NAME>,
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text()))))then(
                		<ns2:FCY_MIN_PAYMENT>{ data($sjConsultaSaldosTarjetaCreditoResponse/FCY_MIN_PAYMENT/text()) }</ns2:FCY_MIN_PAYMENT>  	
                	)else(
                		<ns2:FCY_MIN_PAYMENT>{ string($row/ns0:Column[@name = 'MIN_PAYMENT']/text())}</ns2:FCY_MIN_PAYMENT>
                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/FCY_TOTAL_PAYMENT/text()))))then(
                		if($FCY_TOTAL_PAYMENT >= 0)then(
                			<ns2:FCY_TOTAL_PAYMENT>{ $FCY_TOTAL_PAYMENT }</ns2:FCY_TOTAL_PAYMENT>
                		)else(
                			<ns2:FCY_TOTAL_PAYMENT>0</ns2:FCY_TOTAL_PAYMENT>
                		)
                	)else(
                		<ns2:FCY_TOTAL_PAYMENT>{ string($row/ns0:Column[@name = 'TOTAL_PAYMENT']/text()) }</ns2:FCY_TOTAL_PAYMENT>
                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT/text()))))then(
                		<ns2:CREDIT_LIMIT>{ data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT/text()) }</ns2:CREDIT_LIMIT>
                	)else(
                		<ns2:CREDIT_LIMIT>{ string($row/ns0:Column[@name = 'CREDIT_LIMIT']/text()) }</ns2:CREDIT_LIMIT>
                	),
                	if(not(empty(data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY/text()))))then(
                		<ns2:CREDIT_LIMIT_CCY>{ data($sjConsultaSaldosTarjetaCreditoResponse/CREDIT_LIMIT_CCY/text()) }</ns2:CREDIT_LIMIT_CCY>
                	)else(
                		<ns2:CREDIT_LIMIT_CCY>USD</ns2:CREDIT_LIMIT_CCY>
                	),
                	if($valSaldoActual != '') then (
        				<ns2:POINTS_EARNED>{ $valSaldoActual }</ns2:POINTS_EARNED>
        			) else (),
                	<ns2:MAX_PAYMENT_DATE>{ string($row/ns0:Column[@name = 'MAX_PAYMENT_DATE']/text()) }</ns2:MAX_PAYMENT_DATE>,
		       		<ns2:LAST_CUTOFF_DATE>{ string($row/ns0:Column[@name = 'LAST_CUTOFF_DATE']/text()) }</ns2:LAST_CUTOFF_DATE>,
		       		if($row/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text() = 'BASE')then(
		       			<ns2:ORG_TYPE>{ string($row/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text()) }</ns2:ORG_TYPE>,
		       			<ns2:ORG>{ string($row/ns0:Column[upper-case(@name) = 'ORG']/text()) }</ns2:ORG>,
		       			<ns2:CURRENCY>{ string($row/ns0:Column[@name = 'CURRENCY']/text()) }</ns2:CURRENCY>,
		       			if(not(empty(data($saldosTCItemBase/OVERDUE_BALANCE))))then(
		       				<ns2:OVERDUE_BALANCE>{ data($saldosTCItemBase/OVERDUE_BALANCE) }</ns2:OVERDUE_BALANCE>
		       			)else(
		       				<ns2:OVERDUE_BALANCE>{ string($row/ns0:Column[@name = 'OVERDUE_BALANCE']/text()) }</ns2:OVERDUE_BALANCE>
		       			),
		       			if(not(empty(data($saldosTCItemBase/FLOATING_BALANCE))))then(
		       				<ns2:FLOATING_BALANCE>{ data($saldosTCItemBase/FLOATING_BALANCE) }</ns2:FLOATING_BALANCE>
		       			)else(
		       				<ns2:FLOATING_BALANCE>{ string($row/ns0:Column[@name = 'FLOATING_BALANCE']/text()) }</ns2:FLOATING_BALANCE>
		       			),
		       			<ns2:CURRENT_BALANCE>{ string($row/ns0:Column[@name = 'CURRENT_BALANCE']/text()) }</ns2:CURRENT_BALANCE>,
		       			if(not(empty(data($saldosTCItemBase/PURCHASES_LIMIT))))then(
		       				<ns2:PURCHASES_LIMIT>{ data($saldosTCItemBase/PURCHASES_LIMIT) }</ns2:PURCHASES_LIMIT>
		       			)else(
		       				<ns2:PURCHASES_LIMIT>{ string($row/ns0:Column[@name = 'PURCHASES_LIMIT']/text()) }</ns2:PURCHASES_LIMIT>
		       			),
		       			if(not(empty(data($saldosTCItemBase/WITHDRAWAL_LIMIT))))then(
		       				<ns2:WITHDRAWAL_LIMIT>{ data($saldosTCItemBase/WITHDRAWAL_LIMIT) }</ns2:WITHDRAWAL_LIMIT>
		       			)else(
		       				<ns2:WITHDRAWAL_LIMIT>{ string($row/ns0:Column[@name = 'WITHDRAWAL_LIMIT']/text()) }</ns2:WITHDRAWAL_LIMIT>
		       			),
		       			if(not(empty(data($saldosTCItemBase/PAYMENTS_TODAY))))then(
		       				<ns2:PAYMENTS_TODAY>{ data($saldosTCItemBase/PAYMENTS_TODAY) }</ns2:PAYMENTS_TODAY>
		       			)else(
		       				<ns2:PAYMENTS_TODAY>{ string($row/ns0:Column[@name = 'PAYMENTS_TODAY']/text()) }</ns2:PAYMENTS_TODAY>
		       			),
		       			if(string($row/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) ='0.0')then(
                            	 <ns2:AVAILABLE_EXTRA>0</ns2:AVAILABLE_EXTRA>	
                            )else(
                            	<ns2:AVAILABLE_EXTRA>{ string($row/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) }</ns2:AVAILABLE_EXTRA>
                        ),
                        <ns2:CURRENT_BALANCE_EXTRA>0</ns2:CURRENT_BALANCE_EXTRA>,
	                	if(string($row/ns0:Column[@name = 'INTRA_AMOUNT']/text()) ='0.0')then(
                        	 <ns2:AVAILABLE_INTRA>0</ns2:AVAILABLE_INTRA>	
                        )else(
                        	<ns2:AVAILABLE_INTRA>{ string($row/ns0:Column[@name = 'INTRA_AMOUNT']/text())}</ns2:AVAILABLE_INTRA>
                        ),
		               <ns2:CURRENT_BALANCE_INTRA>0</ns2:CURRENT_BALANCE_INTRA>
		       		)else(
		       			<ns2:ORG_TYPE>{ string($row/ns0:Column[upper-case(@name) = 'TYPE_ORG']/text()) }</ns2:ORG_TYPE>,
		       			<ns2:ORG>{ string($row/ns0:Column[upper-case(@name) = 'ORG']/text()) }</ns2:ORG>,
		       			<ns2:CURRENCY>{ string($row/ns0:Column[@name = 'CURRENCY']/text()) }</ns2:CURRENCY>,
		       			if(not(empty(data($saldosTCItemBase/OVERDUE_BALANCE))))then(
		       				<ns2:OVERDUE_BALANCE>{ data($saldosTCItemBase/OVERDUE_BALANCE) }</ns2:OVERDUE_BALANCE>
		       			)else(
		       				<ns2:OVERDUE_BALANCE>{ string($row/ns0:Column[@name = 'OVERDUE_BALANCE']/text()) }</ns2:OVERDUE_BALANCE>
		       			),
		       			if(not(empty(data($saldosTCItemBase/FLOATING_BALANCE))))then(
		       				<ns2:FLOATING_BALANCE>{ data($saldosTCItemBase/FLOATING_BALANCE) }</ns2:FLOATING_BALANCE>
		       			)else(
		       				<ns2:FLOATING_BALANCE>{ string($row/ns0:Column[@name = 'FLOATING_BALANCE']/text()) }</ns2:FLOATING_BALANCE>
		       			),
		       			<ns2:CURRENT_BALANCE>{ string($row/ns0:Column[@name = 'CURRENT_BALANCE']/text()) }</ns2:CURRENT_BALANCE>,
		       			if(not(empty(data($saldosTCItemBase/PURCHASES_LIMIT))))then(
		       				<ns2:PURCHASES_LIMIT>{ data($saldosTCItemBase/PURCHASES_LIMIT) }</ns2:PURCHASES_LIMIT>
		       			)else(
		       				<ns2:PURCHASES_LIMIT>{ string($row/ns0:Column[@name = 'PURCHASES_LIMIT']/text()) }</ns2:PURCHASES_LIMIT>
		       			),
		       			if(not(empty(data($saldosTCItemBase/WITHDRAWAL_LIMIT))))then(
		       				<ns2:WITHDRAWAL_LIMIT>{ data($saldosTCItemBase/WITHDRAWAL_LIMIT) }</ns2:WITHDRAWAL_LIMIT>
		       			)else(
		       				<ns2:WITHDRAWAL_LIMIT>{ string($row/ns0:Column[@name = 'WITHDRAWAL_LIMIT']/text()) }</ns2:WITHDRAWAL_LIMIT>
		       			),
		       			if(not(empty(data($saldosTCItemBase/PAYMENTS_TODAY))))then(
		       				<ns2:PAYMENTS_TODAY>{ data($saldosTCItemBase/PAYMENTS_TODAY) }</ns2:PAYMENTS_TODAY>
		       			)else(
		       				<ns2:PAYMENTS_TODAY>{ string($row/ns0:Column[@name = 'PAYMENTS_TODAY']/text()) }</ns2:PAYMENTS_TODAY>
		       			),
		       			if(string($row/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) ='0.0')then(
                            	 <ns2:AVAILABLE_EXTRA>0</ns2:AVAILABLE_EXTRA>	
                            )else(
                            	<ns2:AVAILABLE_EXTRA>{ string($row/ns0:Column[@name = 'EXTRA_AMOUNT']/text()) }</ns2:AVAILABLE_EXTRA>
                        ),
                        <ns2:CURRENT_BALANCE_EXTRA>0</ns2:CURRENT_BALANCE_EXTRA>,
	                	if(string($row/ns0:Column[@name = 'INTRA_AMOUNT']/text()) ='0.0')then(
                        	 <ns2:AVAILABLE_INTRA>0</ns2:AVAILABLE_INTRA>	
                        )else(
                        	<ns2:AVAILABLE_INTRA>{ string($row/ns0:Column[@name = 'INTRA_AMOUNT']/text())}</ns2:AVAILABLE_INTRA>
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

xf:registraSaldosPATCIn($sjConsultaSaldosTarjetaCreditoResponse,
    $outputParameters, $valSaldoActual, $countryCode)