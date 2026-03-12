xquery version "1.0" encoding "Cp1252";
(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://alcance.local/wsinfotarjetas/";
(:: import schema at "../Resources/WSInfoTarjetas.asmx.wsdl" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBConTransaccionesHistoricasDBBS";
(:: import schema at "../Schemas/DBConTransaccionesHistoricasDBBS_sp.xsd" ::)
declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBconInfoHistoricaTCDBBS";
(:: import schema at "../Schemas/DBconInfoHistoricaTCDBBS_sp.xsd" ::)
declare namespace card="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBGT_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $estadosCuentaHistoricoResponse as element() (:: schema-element(ns3:EstadosCuentaHistoricoResponse) ::) external;
declare variable $conInfoHistoricaOut as element() (:: schema-element(ns0:OutputParameters) ::) external;
declare variable $conTransaccionesHistoricasOut as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $globalId as xs:string external;

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "320") then "GTQ"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function local:func($estadosCuentaHistoricoResponse as element() (:: schema-element(ns3:EstadosCuentaHistoricoResponse) ::), 
                            $conInfoHistoricaOut as element() (:: schema-element(ns0:OutputParameters) ::), 
                            $conTransaccionesHistoricasOut as element() (:: schema-element(ns2:OutputParameters) ::),
                            $globalId as xs:string) 
                            as element() (:: schema-element(card:getHistoricalCreditCardStatementReponse) ::) {
    <card:getHistoricalCreditCardStatementReponse>
             <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
              </StatusInfo>
            
         {
        	if(not(empty($estadosCuentaHistoricoResponse/*)))then(
        		for $estadoCuentaTCHist in $estadosCuentaHistoricoResponse/ns3:EstadosCuentaHistoricoResult
        		return(
	        		<CustomeName> { data($estadoCuentaTCHist/ns3:nombreTitular) } </CustomeName>,
					<MainCardNumber> { data($estadoCuentaTCHist/ns3:noTarjetaCreditoTitular)} </MainCardNumber>,
					<AccountNumber> { data($estadoCuentaTCHist/ns3:numeroCuenta) } </AccountNumber>,
					<CutoffDate>{ data($estadoCuentaTCHist/ns3:fechaCorte) }</CutoffDate>,
					<PaymentLimitDate>{ data($estadoCuentaTCHist/ns3:maxFechaPago) }</PaymentLimitDate>,
					if(data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:limiteCredito) != 0)then(
						<CreditLimit>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:limiteCredito) }</CreditLimit>,
						<CreditLimitCcy>{ local:getMoneda(data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:moneda)) }</CreditLimitCcy>
					)else(
						<CreditLimit>{	data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:limiteCredito) }</CreditLimit>,
						<CreditLimitCcy>{ local:getMoneda(data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:moneda)) }</CreditLimitCcy>
					),
					<PointsAvailable>{ data($estadoCuentaTCHist/ns3:puntosAcumulados) }</PointsAvailable>,
					<LcyPreviousBalance>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoAnterior) }</LcyPreviousBalance>,
					<LcyPeriodBalance>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoCorte) }</LcyPeriodBalance>,
					<LcyTotalPayment>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoContado) }</LcyTotalPayment>,
					<LcyMinPayment>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoMinimo) }</LcyMinPayment>,
					<FcyPreviousBalance>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:saldoAnterior) }</FcyPreviousBalance>,
					<FcyPeriodBalance>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:saldoCorte) }</FcyPeriodBalance>,
					<FcyTotalPayment>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:pagoContado) }</FcyTotalPayment>,
					<FcyMinPayment>{ data($estadoCuentaTCHist/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:pagoMinimo) }</FcyMinPayment>,
			    	for $ArrayOfItemTarjeta in $estadoCuentaTCHist/ns3:tarjetas/ns3:ArrayOfItemTarjeta
	                return
	                    <AditionalCreditCards>
	                        {
	                            for $noTarjetaCredito in $ArrayOfItemTarjeta/ns3:noTarjetaCredito
	                            return
	                                <CardNumber>{ data($noTarjetaCredito) }</CardNumber>
	                        }
	                        {
	                            for $nombreTarjetaHabiente in $ArrayOfItemTarjeta/ns3:nombreTarjetaHabiente
	                            return
	                                <CardHolderName>{ data($nombreTarjetaHabiente) }</CardHolderName>
	                        }
	                       {
	                            for $movimientos in $ArrayOfItemTarjeta/ns3:movimientos
	                            return
                                    <Transactions>
	                                 {       
                                           for $ArrayOfItemMovimiento in $movimientos/ns3:ArrayOfItemMovimiento
	                                        return
	                                            <TransactionsRecordType>
							<TransactionDate>{  fn-bea:dateTime-to-string-with-format('yyyyMMdd',xs:dateTime($ArrayOfItemMovimiento/ns3:fechaTrx)) }</TransactionDate>
	                                                <Description>{ data($ArrayOfItemMovimiento/ns3:descripcion) }</Description>
	                                                <Amount>{ data($ArrayOfItemMovimiento/ns3:montoTrx) }</Amount>
	                                                <Currency>{ local:getMoneda($ArrayOfItemMovimiento/ns3:monedaTrx) }</Currency>
	                                           	<TypeOfTransaction>{ data($ArrayOfItemMovimiento/ns3:tipoMov) }</TypeOfTransaction>
	                                               	<OriginalAmount>{ data($ArrayOfItemMovimiento/ns3:montoOrgnlTrx) }</OriginalAmount>
	                                              	<OriginalCurrency>{ data($ArrayOfItemMovimiento/ns3:monedaOrgnlTrx) }</OriginalCurrency>                                                                                              
						  </TransactionsRecordType>
                                                  }
                                           </Transactions>
	                        	}
                                        
	                    </AditionalCreditCards>
        		)
        	)else()
        }
        {
       		if(not(empty($conInfoHistoricaOut/*)))then(
        		for $conInfoHistorica in $conInfoHistoricaOut/ns0:RowSet/ns0:Row[1]
      	  		return(
	        		<CustomerName> { data($conInfoHistorica/ns0:Column[lower-case(@name) = 'account_name']) } </CustomerName>,
					<MainCardNumber> { data($conInfoHistorica/ns0:Column[lower-case(@name) = 'numtarjeta'])} </MainCardNumber>,
					<AccountNumber> { data($conInfoHistorica/ns0:Column[lower-case(@name) = 'account_nbr']) } </AccountNumber>,
					<CutOffDate>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'fecproxecta']) }</CutOffDate>,
					<PaymentLimitDate>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'fechamaximapago']) }</PaymentLimitDate>,
					
					let $rowInfoHistoricaUsd := $conInfoHistoricaOut/ns0:RowSet/ns0:Row[ns0:Column[@name = 'CodMoneda']/text() = 'USD'][1]
	           		let $rowInfoHistoricaLocal := $conInfoHistoricaOut/ns0:RowSet/ns0:Row[ns0:Column[@name = 'CodMoneda']/text() = 'GTQ'][1]
	                return(
	                     if(count($rowInfoHistoricaUsd/*)  > 0 and  count($rowInfoHistoricaLocal/*) > 0)then(
							<CreditLimit>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'crlim'])}</CreditLimit>,
							<CreditLimitCCY> USD </CreditLimitCCY>,
							<PointsAvailable>{ xs:int(fn:floor(xs:decimal($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'puntosacumulados']/text()))) }</PointsAvailable>,
							<LCYPreviousBalance>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'totbalini']) }</LCYPreviousBalance>,
							<LCYPeriodBalance>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'saldoalcorte']) }</LCYPeriodBalance>,
							<LCYTotalPayment>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'actualdue']) }</LCYTotalPayment>,
							<LCYMinPayment>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'pagominimo']) }</LCYMinPayment>,
							<FCYPreviousBalance>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'totbalini']) }</FCYPreviousBalance>,
							<FCYPeriodBalance>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'saldoalcorte']) }</FCYPeriodBalance>,
							<FCYTotalPayment>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'actualdue']) }</FCYTotalPayment>,
							<FCYMinPayment>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'pagominimo']) }</FCYMinPayment>
						)else(
							if(count($rowInfoHistoricaUsd/*) > 0)then(
								<CreditLimit>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'crlim']) }</CreditLimit>,
								<CreditLimitCCY> USD </CreditLimitCCY>,
								<PontsAvailable>{ xs:int(fn:floor(xs:decimal($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'puntosacumulados']/text()))) }</PontsAvailable>,
								<LCYPreviousBalance>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'totbalini']) }</LCYPreviousBalance>,
								<LCYPeriodBalance>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'saldoalcorte']) }</LCYPeriodBalance>,
								<LCYTotalPayment>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'actualdue']) }</LCYTotalPayment>,
								<LCYMinPayment>{ data($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'pagominimo']) }</LCYMinPayment>
							)else(
								if(count($rowInfoHistoricaLocal/*) > 0)then(
									<CreditLimit>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'crlim'])}</CreditLimit>,
									<CreditLimitCCY> GTQ </CreditLimitCCY>,
									<PontsAvailable>{ xs:int(fn:floor(xs:decimal($rowInfoHistoricaUsd/ns0:Column[lower-case(@name) = 'puntosacumulados']/text()))) }</PontsAvailable>,
									<LCYPreviousBalance>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'totbalini']) }</LCYPreviousBalance>,
									<LCYPeriodBalance>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'saldoalcorte']) }</LCYPeriodBalance>,
									<LCYTotalPayment>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'actualdue']) }</LCYTotalPayment>,
									<LCYMinPayment>{ data($rowInfoHistoricaLocal/ns0:Column[lower-case(@name) = 'pagominimo']) }</LCYMinPayment>
								)else()
							)
						)
						        	
	            	),	        		
			        for $card_number in distinct-values($conTransaccionesHistoricasOut/ns2:RowSet/ns2:Row/ns2:Column[@name = 'numtarjeta']/text())
					let $rowNumeroTarjeta := $conTransaccionesHistoricasOut/ns2:RowSet/ns2:Row[ns2:Column[@name = 'numtarjeta']/text() = string($card_number)][1]
					let $cardHolderName := string($rowNumeroTarjeta/ns2:Column[lower-case(@name) = 'nombretarjetahabiente']/text())
					return(
						<AditionalCreditCards>
		        			<CardNumber>{ $card_number }</CardNumber>
					        <CardHolderName>{ $cardHolderName }</CardHolderName>
					        {
                                                  <Transactions>
					      		{	for $mov in $conTransaccionesHistoricasOut/ns2:RowSet/ns2:Row[ns2:Column[@name = 'numtarjeta']/text() = $card_number]
					     		return(
					     			<TransactionsRecordType>
					        			<TransactionDate>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',xs:dateTime($mov/ns2:Column[lower-case(@name) = 'fecefectiva'])) }</TransactionDate>
					        			<Description>{ data($mov/ns2:Column[lower-case(@name) = 'descripcion']) }</Description>
					        			<Amount>{ data($mov/ns2:Column[lower-case(@name) = 'monto']) }</Amount>
					        			<Currency>{ data($mov/ns2:Column[lower-case(@name) = 'codmoneda']) }</Currency>
					        			<TypeOfTransaction>{ data($mov/ns2:Column[lower-case(@name) = 'tipomovimiento']) }</TypeOfTransaction>
					        			<OriginalAmount>{ data($mov/ns2:Column[lower-case(@name) = 'montooriginal']) }</OriginalAmount>
					        			<OriginalCurrency>{ data($mov/ns2:Column[lower-case(@name) = 'monedaoriginal']) }</OriginalCurrency>
					        			<TransPstDate>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',xs:dateTime($mov/ns2:Column[lower-case(@name) = 'fecposteo'])) }</TransPstDate>
					        			<TransCode>{ data($mov/ns2:Column[lower-case(@name) = 'codtxn']) }</TransCode>
					        			<PlanNumber>{ data($mov/ns2:Column[lower-case(@name) = 'plann']) }</PlanNumber>	        			
					        		</TransactionsRecordType>
					        	)}
                                                        </Transactions>
					        }
					     
	        			</AditionalCreditCards>
					  ),
	        		        <BeginningBalance>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'saldoiinicial']) }</BeginningBalance>,
					<DebitQuantity>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'cantdebitos']) }</DebitQuantity>,
					<DebitAmount>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'montodebitos']) }</DebitAmount>,
					<CreditQuantity>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'cantcreditos']) }</CreditQuantity>,
					<CreditAmount>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'montocreditos']) }</CreditAmount>,
					<EndingBalance>{ data($conInfoHistorica/ns0:Column[lower-case(@name) = 'saldofinal']) }</EndingBalance>
        		)
        	)else()
        }
    </card:getHistoricalCreditCardStatementReponse>
};

local:func($estadosCuentaHistoricoResponse, $conInfoHistoricaOut, $conTransaccionesHistoricasOut,$globalId)