xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace card="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistorica";
(:: import schema at "../Schemas/conTransaccionesHistorica_sp.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
(:: import schema at "../Schemas/conInfoHistoricaTC_sp.xsd" ::)

declare namespace ns3 = "http://alcance.local/wsinfotarjetas/";
(:: import schema at "../Schemas/wsinfotarjetas.xsd" ::)

declare variable $conInfoHistoricaTCResponse as element(ns2:OutputParameters) ? external;
declare variable $conTransaccionesHistoricasResponse as element(ns1:OutputParameters)? external;
declare variable $consultarEstadosCuentaUltimoCorteResponse1 as element(ns3:ConsultarEstadosCuentaUltimoCorteResponse)? external;


declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "320") then "GTQ"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};
 
declare variable $globalId as xs:string external;

declare function local:consultaEstCuentaTCGTOut($conInfoHistoricaTCResponse as element(ns2:OutputParameters)?,
    $conTransaccionesHistoricasResponse as element(ns1:OutputParameters)?,
    $consultarEstadosCuentaUltimoCorteResponse1 as element(ns3:ConsultarEstadosCuentaUltimoCorteResponse)?,$globalId  as xs:string)
    as element() (:: schema-element(card:getCreditCardStatementResponse) ::)  {
       if(not(empty($consultarEstadosCuentaUltimoCorteResponse1/*))) then(
       	for $result in $consultarEstadosCuentaUltimoCorteResponse1/ns3:ConsultarEstadosCuentaUltimoCorteResult
       	return
       	<card:getCreditCardStatementResponse>
        <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
          </StatusInfo>
            <CustomerName>{ data($result/ns3:nombreTitular) }</CustomerName>
            <MainCardNumber>{ data($result/ns3:noTarjetaCreditoTitular) }</MainCardNumber>
            <AccountNumber>{ data($result/ns3:numeroCuenta) }</AccountNumber>
            <CutoffDate>{ data($result/ns3:fechaCorte) }</CutoffDate>
            <PaymentLimitDate>{ data($result/ns3:maxFechaPago) }</PaymentLimitDate>
            {
            	for $limites in $result/ns3:saldos/ns3:ArrayOfStrucSaldosEstado
            	return
            	if($limites/ns3:limiteCredito != 0)then(
            		<CreditLimit>{ data($limites/ns3:limiteCredito) }</CreditLimit>,
            		<CreditLimitCcy>{ local:getMoneda($limites/ns3:moneda) }</CreditLimitCcy>
            		)else()
            }
            <PointsAvailable>{ data($result/ns3:puntosAcumulados) }</PointsAvailable>
            {
            	for $limites in $result/ns3:saldos/ns3:ArrayOfStrucSaldosEstado
            	return
            		if ( local:getMoneda($limites/ns3:moneda) = "GTQ") then 
            		(
            			<LcyPreviousBalance>{ data($limites/ns3:saldoAnterior) }</LcyPreviousBalance>,
            			<LcyPeriodBalance>{ data($limites/ns3:saldoCorte) }</LcyPeriodBalance>,
            			<LcyTotalPayment>{ data($limites/ns3:pagoContado) }</LcyTotalPayment>,
            			<LcyMinPayment>{ data($limites/ns3:pagoMinimo) }</LcyMinPayment>
					) else if ( local:getMoneda($limites/ns3:moneda) = "USD" ) then
            		(
            			<FcyPreviousBalance>{ data($limites/ns3:saldoAnterior) }</FcyPreviousBalance>,
            			<FcyPeriodBalance>{ data($limites/ns3:saldoCorte) }</FcyPeriodBalance>,
            			<FcyTotalPayment>{ data($limites/ns3:pagoContado) }</FcyTotalPayment>,
            			<FcyMinPayment>{ data($limites/ns3:pagoMinimo) }</FcyMinPayment>
					) else ()
            }
            {
                for $ArrayOfItemTarjeta in $result/ns3:tarjetas/ns3:ArrayOfItemTarjeta
                return
                    <AdditionalCreditCardStatementDetails>
                    	<CardNumber>{ data($ArrayOfItemTarjeta/ns3:noTarjetaCredito) }</CardNumber>
                        <CardHolderName>{ data($ArrayOfItemTarjeta/ns3:nombreTarjetaHabiente) }</CardHolderName>
                        <AdditionalCreditCardTransactions>
                            {
                                for $ArrayOfItemMovimiento in $ArrayOfItemTarjeta/ns3:movimientos/ns3:ArrayOfItemMovimiento
                                return
                                    <AdditionalCreditCardTransactionsRecordType>
                                    	<TransactionDate>{ data($ArrayOfItemMovimiento/ns3:fechaTrx) }</TransactionDate>
                                        <Description>{ data($ArrayOfItemMovimiento/ns3:descripcion) }</Description>
                                        <Amount>{ data($ArrayOfItemMovimiento/ns3:montoTrx) }</Amount>
                                        <Currency>{ local:getMoneda(data($ArrayOfItemMovimiento/ns3:monedaTrx)) }</Currency>
                                        <TypeOfTransaction>{ data($ArrayOfItemMovimiento/ns3:tipoMov) }</TypeOfTransaction>
                                        <OriginalAmount>{ data($ArrayOfItemMovimiento/ns3:montoOrgnlTrx) }</OriginalAmount>
                                        <OriginalCurrency>{ data($ArrayOfItemMovimiento/ns3:monedaOrgnlTrx) }</OriginalCurrency>
                                    </AdditionalCreditCardTransactionsRecordType>
                            }
                        </AdditionalCreditCardTransactions>
                    </AdditionalCreditCardStatementDetails>
            }
        </card:getCreditCardStatementResponse>
	    )else(
	    	for $conInfoHistoricaTC in $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]
	    	return
        <card:getCreditCardStatementResponse>
                <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
                </StatusInfo>
	    	<CustomerName>{data($conInfoHistoricaTC/ns2:Column[@name = 'account_name'])}</CustomerName>
	            <MainCardNumber>{data($conInfoHistoricaTC/ns2:Column[@name = 'numtarjeta'])}</MainCardNumber>
	            <AccountNumber>{data($conInfoHistoricaTC/ns2:Column[@name = 'Account_nbr'])}</AccountNumber>
	            <CutoffDate>{data($conInfoHistoricaTC/ns2:Column[@name = 'fecproxecta'])}</CutoffDate>
	            <PaymentLimitDate>{string($conInfoHistoricaTC/ns2:Column[@name = 'fechamaximapago']/text())}</PaymentLimitDate>
	            {
	            	let $rowInfoHistoricaUsd := $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[ns2:Column[@name = 'CodMoneda']/text() = 'USD'][1]
	            	let $controlRowUsd := count($rowInfoHistoricaUsd/*)
	            	let $rowInfoHistoricaLocal := $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[ns2:Column[@name = 'CodMoneda']/text() = 'GTQ'][1]
	            	let $controlRowLocal := count($rowInfoHistoricaLocal/*)
	            	let $PointAvailable := data($rowInfoHistoricaUsd/ns2:Column[@name= 'PuntosAcumulados'])  
	            	let $LCYPreviousBalance := data($rowInfoHistoricaLocal/ns2:Column[@name = 'totbalini'])
	            	let $LCYMinPayment := data($rowInfoHistoricaLocal/ns2:Column[@name = 'pagominimo'])  
	            	let $LCYTotalPayment := data($rowInfoHistoricaLocal/ns2:Column[@name = 'actualdue'])   
	            	let $LCYPeriodBalance := data($rowInfoHistoricaLocal/ns2:Column[@name = 'SaldoAlCorte'])   
	            	let $FCYPreviousBalance := data($rowInfoHistoricaUsd/ns2:Column[@name = 'totbalini'])  
	            	let $FCYMinPayment := data($rowInfoHistoricaUsd/ns2:Column[@name = 'pagominimo'])   
	            	let $FCYTotalPayment := data($rowInfoHistoricaUsd/ns2:Column[@name = 'actualdue'])  
	            	let $FCYPeriodBalance := data($rowInfoHistoricaUsd/ns2:Column[@name = 'SaldoAlCorte'])
	            	return
	            	(
	            		if($controlRowUsd > 0 and $controlRowLocal > 0) then (
	            		<CreditLimit>{data($rowInfoHistoricaUsd/ns2:Column[@name = 'CRLIM'])}</CreditLimit>,
	            		<CreditLimitCcy>USD</CreditLimitCcy>,
	            		if($PointAvailable != '')then (
                                  let $PointAvailableD :=  xs:double($PointAvailable) 
                                  return
	            			<PointsAvailable>{xs:int(fn:floor($PointAvailableD))}</PointsAvailable>
	            		)else(),
	            		<LcyPreviousBalance>{$LCYPreviousBalance}</LcyPreviousBalance>,
	            		<LcyPeriodBalance>{$LCYPeriodBalance}</LcyPeriodBalance>,
	            		<LcyTotalPayment>{$LCYTotalPayment}</LcyTotalPayment>,
	            		<LcyMinPayment>{$LCYMinPayment}</LcyMinPayment>,
	            		<FcyPreviousBalance>{$FCYPreviousBalance}</FcyPreviousBalance>,
	            		<FcyPeriodBalance>{$FCYPeriodBalance}</FcyPeriodBalance>,
	            		<FcyTotalPayment>{$FCYTotalPayment}</FcyTotalPayment>,
	            		<FcyMinPayment>{$FCYMinPayment}</FcyMinPayment>
	            	)else if($controlRowLocal > 0) then (
	            		<CreditLimit>{$rowInfoHistoricaLocal/ns2:Column[@name = 'CRLIM']}</CreditLimit>,
	            		<CreditLimitCcy>GTQ</CreditLimitCcy>,
	            		<LcyPreviousBalance>{$LCYPreviousBalance}</LcyPreviousBalance>,
	            		<LcyPeriodBalance>{$LCYPeriodBalance}</LcyPeriodBalance>,
	            		<LcyTotalPayment>{$LCYTotalPayment}</LcyTotalPayment>,
	            		<LcyMinPayment>{$LCYMinPayment}</LcyMinPayment>
	            	)else if($controlRowUsd > 0 )then(
	            		<CreditLimit>{$rowInfoHistoricaUsd/ns2:Column[@name = 'CRLIM']}</CreditLimit>,
	            		<CreditLimitCcy>USD</CreditLimitCcy>,
	            		if($PointAvailable != '')then (
                                let $PointAvailableD :=  xs:double($PointAvailable) 
                                return
	            			<PointsAvailable>{xs:int(fn:floor($PointAvailableD))}</PointsAvailable>
	            		)else(),
	            		<FcyPreviousBalance>{$FCYPreviousBalance}</FcyPreviousBalance>,
	            		<FcyPeriodBalance>{$FCYPeriodBalance}</FcyPeriodBalance>,
	            		<FcyTotalPayment>{$FCYTotalPayment}</FcyTotalPayment>,
	            		<FcyMinPayment>{$FCYMinPayment}</FcyMinPayment>
	            	)else()   
             )
        }
	    		
		{
   		for $numeroTarjeta in fn:distinct-values($conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row/ns1:Column[@name = 'numtarjeta']/text())
       		
       		let $rowNumeroTarjeta := $conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row[ns1:Column[@name = 'numtarjeta']/text() = string($numeroTarjeta)][1]
        	let $cardHolderName := string($rowNumeroTarjeta/ns1:Column[@name = 'nombreTarjetahabiente']/text())
       		return (
       		<AdditionalCreditCardStatementDetails>
       			<CardNumber>{string($numeroTarjeta)}</CardNumber>
       			<CardHolderName>{$cardHolderName}</CardHolderName>
       			<AdditionalCreditCardTransactions>
       			{
       				for $rowTransaccionesHistoricas in $conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row[ns1:Column[@name = 'numtarjeta']/text() = string($numeroTarjeta)]
		            return
		            (
		              <AdditionalCreditCardTransactionsRecordType>
		              <TransactionDate>{fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($rowTransaccionesHistoricas/ns1:Column[@name = 'fecefectiva']))}</TransactionDate>
		              <Description>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'descripcion']))}</Description>
		              <Amount>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'monto']))}</Amount>
		              <Currency>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'CodMoneda']))}</Currency>
		              <TypeOfTransaction>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'TipoMovimiento']))}</TypeOfTransaction>
		              <OriginalAmount>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'MontoOriginal']))}</OriginalAmount>
		              <OriginalCurrency>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'MonedaOriginal']))}</OriginalCurrency>
		              </AdditionalCreditCardTransactionsRecordType>
		             )
       			}
       			</AdditionalCreditCardTransactions>
       		</AdditionalCreditCardStatementDetails>
       		)
       	}
       	</card:getCreditCardStatementResponse>
	    )		
};



local:consultaEstCuentaTCGTOut($conInfoHistoricaTCResponse,
    $conTransaccionesHistoricasResponse, $consultarEstadosCuentaUltimoCorteResponse1,$globalId )