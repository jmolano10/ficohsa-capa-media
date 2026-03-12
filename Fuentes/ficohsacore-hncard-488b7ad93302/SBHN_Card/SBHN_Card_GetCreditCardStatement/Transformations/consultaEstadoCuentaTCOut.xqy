xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
(:: import schema at "../Schemas/wsinfotarjetas.xsd" ::)



declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)


declare function local:getMoneda($codigoMoneda as xs:string?) as xs:string
{
	if ($codigoMoneda = "340") then "HNL"
	else if ($codigoMoneda = "840") then "USD" 
	else( "" )

};

declare variable $consultarUltimoECResponse1 as element() (:: schema-element(ns1:ConsultarEstadosCuentaUltimoCorteResponse) ::)? external;
declare variable $globalId as element() external;

declare function local:consultaEstadoCuentaTCOut($consultarUltimoECResponse1 as element() (:: schema-element(ns1:ConsultarEstadosCuentaUltimoCorteResponse) ::)?,
$globalId as element())
    as element(ns0:getCreditCardStatementResponse) {
        <ns0:getCreditCardStatementResponse>
         <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
          </StatusInfo>
            <CustomerName>{ data($consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:nombreTitular) }</CustomerName>
            <MainCardNumber>{ data($consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:noTarjetaCreditoTitular) }</MainCardNumber>
            <AccountNumber>{ data($consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:numeroCuenta) }</AccountNumber>
            <CutoffDate>{ data($consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:fechaCorte) }</CutoffDate>
            <PaymentLimitDate>{ data($consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:maxFechaPago) }</PaymentLimitDate>
            {
            	for $limites in $consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado
            	return
            		if (data($limites/ns1:limiteCredito) != 0) then (
            			<CreditLimit>{ data($limites/ns1:limiteCredito) }</CreditLimit>,
						<CreditLimitCcy>{ local:getMoneda($limites/ns1:moneda) }</CreditLimitCcy>
					) else ()
            }
            <PointsAvailable>{ data($consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:puntosAcumulados) }</PointsAvailable>
            {
            	for $limites in $consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:saldos/ns1:ArrayOfStrucSaldosEstado
            	return
            	
            		if ( local:getMoneda($limites/ns1:moneda) = "HNL") then 
            		(
            			<LcyPreviousBalance>{ data($limites/ns1:saldoAnterior) }</LcyPreviousBalance>,
            			<LcyPeriodBalance>{ data($limites/ns1:saldoCorte) }</LcyPeriodBalance>,
            			<LcyTotalPayment>{ data($limites/ns1:pagoContado) }</LcyTotalPayment>,
            			<LcyMinPayment>{ data($limites/ns1:pagoMinimo) }</LcyMinPayment>
					) else if ( local:getMoneda($limites/ns1:moneda) = "USD" ) then
            		(
            			<FcyPreviousBalance>{ data($limites/ns1:saldoAnterior) }</FcyPreviousBalance>,
            			<FcyPeriodBalance>{ data($limites/ns1:saldoCorte) }</FcyPeriodBalance>,
            			<FcyTotalPayment>{ data($limites/ns1:pagoContado) }</FcyTotalPayment>,
            			<FcyMinPayment>{ data($limites/ns1:pagoMinimo) }</FcyMinPayment>
					) else ()
            }
            {
                for $ArrayOfItemTarjeta in $consultarUltimoECResponse1/ns1:ConsultarEstadosCuentaUltimoCorteResult/ns1:tarjetas/ns1:ArrayOfItemTarjeta
                return
                    <AdditionalCreditCardStatementDetails>
                    	<CardNumber>{ data($ArrayOfItemTarjeta/ns1:noTarjetaCredito) }</CardNumber>
                        <CardHolderName>{ data($ArrayOfItemTarjeta/ns1:nombreTarjetaHabiente) }</CardHolderName>
                        <AdditionalCreditCardTransactions>
                            {
                                for $ArrayOfItemMovimiento in $ArrayOfItemTarjeta/ns1:movimientos/ns1:ArrayOfItemMovimiento
                                return
                                    <AdditionalCreditCardTransactionsRecordType>
                                    	<TransactionDate>{ data($ArrayOfItemMovimiento/ns1:fechaTrx) }</TransactionDate>
                                        <Description>{ data($ArrayOfItemMovimiento/ns1:descripcion) }</Description>
                                        <Amount>{ data($ArrayOfItemMovimiento/ns1:montoTrx) }</Amount>
                                        <Currency>{ local:getMoneda(data($ArrayOfItemMovimiento/ns1:monedaTrx)) }</Currency>
                                        <TypeOfTransaction>{ data($ArrayOfItemMovimiento/ns1:tipoMov) }</TypeOfTransaction>
                                        <OriginalAmount>{ data($ArrayOfItemMovimiento/ns1:montoOrgnlTrx) }</OriginalAmount>
                                        <OriginalCurrency>{ data($ArrayOfItemMovimiento/ns1:monedaOrgnlTrx) }</OriginalCurrency>
                                    </AdditionalCreditCardTransactionsRecordType>
                            }
                        </AdditionalCreditCardTransactions>
                    </AdditionalCreditCardStatementDetails>
            }
        </ns0:getCreditCardStatementResponse>
};



local:consultaEstadoCuentaTCOut($consultarUltimoECResponse1,$globalId)