xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://tempuri.org/";
(:: import schema at "../Resources/VMX.wsdl" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBConInfoHistoricaTCBS";
(:: import schema at "../Schemas/DBConInfoHistoricaTCBS_sp.xsd" ::)
declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBConTransaccioneshistoricasBS";
(:: import schema at "../Schemas/DBConTransaccioneshistoricasBS_sp.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare variable $consultaECHistResponse as element() (:: schema-element(ns3:ConsultaECHistResponse) ::) external;
declare variable $conInfoHistoricaOut as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $conTransaccionesHistoricasOut as element() (:: schema-element(ns0:OutputParameters) ::) external;
declare variable $globalId as xs:string external;

declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare function local:func($consultaECHistResponse as element() (:: schema-element(ns3:ConsultaECHistResponse) ::), 
                            $conInfoHistoricaOut as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $conTransaccionesHistoricasOut as element() (:: schema-element(ns0:OutputParameters) ::),
                            $globalId as xs:string) 
                            as element() (:: schema-element(ns2:getHistoricalCreditCardStatementReponse) ::) {
    <ns2:getHistoricalCreditCardStatementReponse>
             <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
              </StatusInfo>
    
       {
	        if(not(empty($consultaECHistResponse/*)))then(
                for $nombreTitular in $consultaECHistResponse/ns3:ConsultaECHistResult/ns3:nombreTitular
                return
                    <CustomerName>{ data($nombreTitular) }</CustomerName>,
                for $noTarjetaCreditoTitular in $consultaECHistResponse/ns3:ConsultaECHistResult/ns3:noTarjetaCreditoTitular
                return
                    <MainCardNumber>{ data($noTarjetaCreditoTitular) }</MainCardNumber>,
                for $numeroCuenta in $consultaECHistResponse/ns3:ConsultaECHistResult/ns3:numeroCuenta
                return
                    <AccountNumber>{ data($numeroCuenta) }</AccountNumber>,
                for $fechaCorte in $consultaECHistResponse/ns3:ConsultaECHistResult/ns3:fechaCorte
                return
                    <CutOffDate>{ data($fechaCorte) }</CutOffDate>,
                for $maxFechaPago in $consultaECHistResponse/ns3:ConsultaECHistResult/ns3:maxFechaPago
                return
                    <PaymentLimitDate>{ data($maxFechaPago) }</PaymentLimitDate>,
             if(data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:limiteCredito)!=0)then(
	          <CreditLimit>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:limiteCredito) }</CreditLimit>,
		   <CreditLimitCCY>{ local:getMoneda(data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:moneda)) }</CreditLimitCCY>
		)else(
		   <CreditLimit>{	data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:limiteCredito) }</CreditLimit>,
		  <CreditLimitCCY>{ local:getMoneda(data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[2]/ns3:moneda)) }</CreditLimitCCY>
					),
             <PointsAvailable>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:puntosAcumulados) }</PointsAvailable>,
            <LCYPreviousBalance>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoAnterior) }</LCYPreviousBalance>,
            <LCYPeriodBalance>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoCorte) }</LCYPeriodBalance>,
            <LCYTotalPayment>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoContado) }</LCYTotalPayment>,
            <LCYMinPayment>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoMinimo) }</LCYMinPayment>,
            <FCYPreviousBalance>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoAnterior) }</FCYPreviousBalance>,
            <FCYPeriodBalance>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:saldoCorte) }</FCYPeriodBalance>,
            <FCYTotalPayment>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoContado) }</FCYTotalPayment>,
            <FCYMinPayment>{ data($consultaECHistResponse/ns3:ConsultaECHistResult/ns3:saldos/ns3:ArrayOfStrucSaldosEstado[1]/ns3:pagoMinimo) }</FCYMinPayment>,                
            
            for $ArrayOfItemTarjeta in $consultaECHistResponse/ns3:ConsultaECHistResult/ns3:tarjetas/ns3:ArrayOfItemTarjeta
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
							<TransactionDate>{ data($ArrayOfItemMovimiento/ns3:fechaTrx) }</TransactionDate>
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
	        )else()
        }
        {
       		if(not(empty($conInfoHistoricaOut/*)))then(
        		for $conInfoHistorica in $conInfoHistoricaOut/ns1:RowSet/ns1:Row[1]
      	  		return(
	        		<CustomerName> { data($conInfoHistorica/ns1:Column[lower-case(@name) = 'account_name']) } </CustomerName>,
					<MainCardNumber> { data($conInfoHistorica/ns1:Column[lower-case(@name) = 'numtarjeta'])} </MainCardNumber>,
					<AccountNumber> { data($conInfoHistorica/ns1:Column[lower-case(@name) = 'account_nbr']) } </AccountNumber>,
					<CutOffDate>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'fecproxecta']) }</CutOffDate>,
					<PaymentLimitDate>{ data($conInfoHistorica/ns1:Column[lower-case(@name) = 'fechamaximapago']) }</PaymentLimitDate>,
					
					let $rowInfoHistoricaUsd := $conInfoHistoricaOut/ns1:RowSet/ns1:Row[ns1:Column[@name = 'CodMoneda']/text() = 'USD'][1]
	           		let $rowInfoHistoricaLocal := $conInfoHistoricaOut/ns1:RowSet/ns1:Row[ns1:Column[@name = 'CodMoneda']/text() = 'HNL'][1]
	                return(
	                     if(count($rowInfoHistoricaUsd/*)  > 0 and  count($rowInfoHistoricaLocal/*) > 0)then(
							<CreditLimit>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'crlim'])}</CreditLimit>,
							<CreditLimitCCY>USD</CreditLimitCCY>,
							<PointsAvailable>{ data(xs:int(fn:floor($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'puntosacumulados']/text()))) }</PointsAvailable>,
							<LCYPreviousBalance>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'totbalini']) }</LCYPreviousBalance>,
							<LCYPeriodBalance>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'saldoalcorte']) }</LCYPeriodBalance>,
							<LCYTotalPayment>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'actualdue']) }</LCYTotalPayment>,
							<LCYMinPayment>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'pagominimo']) }</LCYMinPayment>,
							<FCYPreviousBalance>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'totbalini']) }</FCYPreviousBalance>,
							<FCYPeriodBalance>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'saldoalcorte']) }</FCYPeriodBalance>,
							<FCYTotalPayment>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'actualdue']) }</FCYTotalPayment>,
							<FCYMinPayment>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'pagominimo']) }</FCYMinPayment>
						)else(
							if(count($rowInfoHistoricaUsd/*) > 0)then(
								<CreditLimit>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'crlim']) }</CreditLimit>,
								<CreditLimitCCY>USD</CreditLimitCCY>,
								<PointsAvailable>{ data(xs:int(fn:floor($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'puntosacumulados']/text()))) }</PointsAvailable>,
								<LCYPreviousBalance>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'totbalini']) }</LCYPreviousBalance>,
								<LCYPeriodBalance>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'saldoalcorte']) }</LCYPeriodBalance>,
								<LCYTotalPayment>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'actualdue']) }</LCYTotalPayment>,
								<FCYMinPayment>{ data($rowInfoHistoricaUsd/ns1:Column[lower-case(@name) = 'pagominimo']) }</FCYMinPayment>
							)else(
								if(count($rowInfoHistoricaLocal/*) > 0)then(
									<CreditLimit>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'crlim'])}</CreditLimit>,
									<CreditLimitCCY>HNL</CreditLimitCCY>,
									<PointsAvailable>{ data(xs:int(fn:floor($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'puntosacumulados']/text()))) }</PointsAvailable>,
									<LCYPreviousBalance>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'totbalini']) }</LCYPreviousBalance>,
									<LCYPeriodBalance>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'saldoalcorte']) }</LCYPeriodBalance>,
									<LCYTotalPayment>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'actualdue']) }</LCYTotalPayment>,
									<LCYMinPayment>{ data($rowInfoHistoricaLocal/ns1:Column[lower-case(@name) = 'pagominimo']) }</LCYMinPayment>
								)else()
							)
						)
						        	
	            	),	        		
			        for $card_number in distinct-values($conTransaccionesHistoricasOut/ns0:RowSet/ns0:Row/ns0:Column[@name = 'numtarjeta']/text())
					let $rowNumeroTarjeta := $conTransaccionesHistoricasOut/ns0:RowSet/ns0:Row[ns0:Column[@name = 'numtarjeta']/text() = string($card_number)][1]
					let $cardHolderName := string($rowNumeroTarjeta/ns0:Column[lower-case(@name) = 'nombretarjetahabiente']/text())
					return(
						<AditionalCreditCards>
		        			<CardNumber>{ $card_number }</CardNumber>
					        <CardHolderName>{ $cardHolderName }</CardHolderName>
					        <Transactions>
					        {
								for $mov in $conTransaccionesHistoricasOut/ns0:RowSet/ns0:Row[ns0:Column[@name = 'numtarjeta']/text() = $card_number]
					     		return(
					     			<TransactionsRecordType>
					        			<TransactionDate>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',data($mov/ns0:Column[lower-case(@name) = 'fecefectiva']/text())) }</TransactionDate>
					        			<Description>{ data($mov/ns0:Column[lower-case(@name) = 'descripcion']) }</Description>
					        			<Amount>{ data($mov/ns0:Column[lower-case(@name) = 'monto']) }</Amount>
					        			<Currency>{ data($mov/ns0:Column[lower-case(@name) = 'codmoneda']) }</Currency>
					        			<TypeOfTransaction>{ data($mov/ns0:Column[lower-case(@name) = 'tipomovimiento']) }</TypeOfTransaction>
					        			<OriginalAmount>{ data($mov/ns0:Column[lower-case(@name) = 'montooriginal']) }</OriginalAmount>
					        			<OriginalCurrency>{ data($mov/ns0:Column[lower-case(@name) = 'monedaoriginal']) }</OriginalCurrency>
					        			<TransPstDate>{ fn-bea:dateTime-to-string-with-format('yyyyMMdd',data($mov/ns0:Column[lower-case(@name) = 'fecposteo']/text())) }</TransPstDate>
					        			<TransCode>{ data($mov/ns0:Column[lower-case(@name) = 'codtxn']) }</TransCode>
					        			<PlanNumber>{ data($mov/ns0:Column[lower-case(@name) = 'plann']) }</PlanNumber>	        			
					        		</TransactionsRecordType>
					        	)
					        }
					        </Transactions> 
	        			</AditionalCreditCards>
					  )
        		)
        	)else()
        }
    
    
    
    </ns2:getHistoricalCreditCardStatementReponse>
};

local:func($consultaECHistResponse, $conInfoHistoricaOut, $conTransaccionesHistoricasOut,$globalId)