xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$conInfoHistoricaTCResponse" element="ns2:OutputParameters" location="../../../BusinessServices/MasterData/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conTransaccionesHistoricasResponse" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoCuentaTCResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTC/consultaEstadoCuentaTCTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCTypes";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistoricas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoCuentaTC/xq/consultaEstCuentaTCNIOut/";

declare function xf:consultaEstCuentaTCNIOut($conInfoHistoricaTCResponse as element(ns2:OutputParameters),
    $conTransaccionesHistoricasResponse as element(ns1:OutputParameters))
    as element(ns0:consultaEstadoCuentaTCResponse) {
        <ns0:consultaEstadoCuentaTCResponse>
        {
        	<CUSTOMER_NAME>{data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'account_name'])}</CUSTOMER_NAME>,
            <MAIN_CARD_NUMBER>{data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'numtarjeta'])}</MAIN_CARD_NUMBER>,
            <ACCOUNT_NUMBER>{data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'Account_nbr'])}</ACCOUNT_NUMBER>,
            <CUTOFF_DATE>{data($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'fecproxecta'])}</CUTOFF_DATE>,
            <PAYMENT_LIMIT_DATE>{string($conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[1]/ns2:Column[@name = 'fechamaximapago']/text())}</PAYMENT_LIMIT_DATE>,
            let $rowInfoHistoricaUsd := $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[ns2:Column[@name = 'CodMoneda']/text() = 'USD']
            let $controlRowUsd := count($rowInfoHistoricaUsd/*)
            let $rowInfoHistoricaLocal := $conInfoHistoricaTCResponse/ns2:RowSet/ns2:Row[ns2:Column[@name = 'CodMoneda']/text() = 'NIO']
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
             		<CREDIT_LIMIT>{data($rowInfoHistoricaUsd/ns2:Column[@name = 'CRLIM'])}</CREDIT_LIMIT>,
             		<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
             		if($PointAvailable != '')then (
		            	<POINTS_AVAILABLE>{xs:int(fn:floor($PointAvailable))}</POINTS_AVAILABLE>
		       		)else(),
             		<LCY_PREVIOUS_BALANCE>{$LCYPreviousBalance}</LCY_PREVIOUS_BALANCE>,
             		<LCY_PERIOD_BALANCE>{$LCYPeriodBalance}</LCY_PERIOD_BALANCE>,
             		<LCY_TOTAL_PAYMENT>{$LCYTotalPayment}</LCY_TOTAL_PAYMENT>,
             		<LCY_MIN_PAYMENT>{$LCYMinPayment}</LCY_MIN_PAYMENT>,
             		<FCY_PREVIOUS_BALANCE>{$FCYPreviousBalance}</FCY_PREVIOUS_BALANCE>,
             		<FCY_PERIOD_BALANCE>{$FCYPeriodBalance}</FCY_PERIOD_BALANCE>,
               		<FCY_TOTAL_PAYMENT>{$FCYTotalPayment}</FCY_TOTAL_PAYMENT>,
               		<FCY_MIN_PAYMENT>{$FCYMinPayment}</FCY_MIN_PAYMENT>
             	)else
             		if($controlRowLocal > 0) then (
             		<CREDIT_LIMIT>{$rowInfoHistoricaLocal/ns2:Column[@name = 'CRLIM']}</CREDIT_LIMIT>,
             		<CREDIT_LIMIT_CCY>NIO</CREDIT_LIMIT_CCY>,
             		<LCY_PREVIOUS_BALANCE>{$LCYPreviousBalance}</LCY_PREVIOUS_BALANCE>,
             		<LCY_PERIOD_BALANCE>{$LCYPeriodBalance}</LCY_PERIOD_BALANCE>,
             		<LCY_TOTAL_PAYMENT>{$LCYTotalPayment}</LCY_TOTAL_PAYMENT>,
             		<LCY_MIN_PAYMENT>{$LCYMinPayment}</LCY_MIN_PAYMENT>
             	
             	)else
             		if($controlRowUsd > 0 )then(
             		<CREDIT_LIMIT>{$rowInfoHistoricaUsd/ns2:Column[@name = 'CRLIM']}</CREDIT_LIMIT>,
             		<CREDIT_LIMIT_CCY>USD</CREDIT_LIMIT_CCY>,
             		if($PointAvailable != '')then (
		            	<POINTS_AVAILABLE>{xs:int(fn:floor($PointAvailable))}</POINTS_AVAILABLE>
		       		)else(),
		       		<FCY_PREVIOUS_BALANCE>{$FCYPreviousBalance}</FCY_PREVIOUS_BALANCE>,
             		<FCY_PERIOD_BALANCE>{$FCYPeriodBalance}</FCY_PERIOD_BALANCE>,
               		<FCY_TOTAL_PAYMENT>{$FCYTotalPayment}</FCY_TOTAL_PAYMENT>,
               		<FCY_MIN_PAYMENT>{$FCYMinPayment}</FCY_MIN_PAYMENT>
             	
             	)else()   

             )
        }  
        {
            for $numeroTarjeta in fn:distinct-values($conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row/ns1:Column[@name = 'numtarjeta']/text())
            let $rowNumeroTarjeta := $conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row[ns1:Column[@name = 'numtarjeta']/text() = string($numeroTarjeta)][1]
            let $cardHolderName := string($rowNumeroTarjeta/ns1:Column[@name = 'nombreTarjetahabiente']/text())
            return
            (
                <ns0:consultaEstadoCuentaTCTarjetasAdicionales>
                <CARD_NUMBER>{string($numeroTarjeta)}</CARD_NUMBER>
                <CARD_HOLDER_NAME>{ $cardHolderName}</CARD_HOLDER_NAME>
                <ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
                {
                    for $rowTransaccionesHistoricas in $conTransaccionesHistoricasResponse/ns1:RowSet/ns1:Row[ns1:Column[@name = 'numtarjeta']/text() = string($numeroTarjeta)]
                    return
                        (
                            <ns0:consultaEstadoCuentaTCDetalleTarjeta>
                                <TRANSACTION_DATE>{fn-bea:dateTime-to-string-with-format('yyyyMMdd', data($rowTransaccionesHistoricas/ns1:Column[@name = 'fecefectiva']))}</TRANSACTION_DATE>
                                <DESCRIPTION>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'descripcion']))}</DESCRIPTION>
                                <AMOUNT>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'monto']))}</AMOUNT>
                                <CURRENCY>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'CodMoneda']))}</CURRENCY>
                                <TYPE_OF_TRANSACTION>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'TipoMovimiento']))}</TYPE_OF_TRANSACTION>
                                <ORIGINAL_AMOUNT>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'MontoOriginal']))}</ORIGINAL_AMOUNT>
                                <ORIGINAL_CURRENCY>{ string(data($rowTransaccionesHistoricas/ns1:Column[@name = 'MonedaOriginal']))}</ORIGINAL_CURRENCY>
                            </ns0:consultaEstadoCuentaTCDetalleTarjeta>
                        )
                }
                </ns0:consultaEstadoCuentaTCRegistroTarjetasAdicionales>
                </ns0:consultaEstadoCuentaTCTarjetasAdicionales>
            )
        }
        </ns0:consultaEstadoCuentaTCResponse>
};

declare variable $conInfoHistoricaTCResponse as element(ns2:OutputParameters) external;
declare variable $conTransaccionesHistoricasResponse as element(ns1:OutputParameters) external;

xf:consultaEstCuentaTCNIOut($conInfoHistoricaTCResponse,
    $conTransaccionesHistoricasResponse)