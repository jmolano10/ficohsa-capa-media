xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultarSaldosVasaResponse" element="ns1:ConsultarSaldosVasaResponse" location="../../../ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)
(:: pragma bea:local-element-return type="ns0:sjConsultaMultipleProductosGTResponse/ns0:LIABILITIES/ns0:LIABILITY" location="../xsd/sjConsultaMultipleProductosGT.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleProductosGT";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosGT/xq/consultaSaldosTCOut/";

declare function numIsNull($item as item()?) as xs:decimal {
	if (fn:string($item/text()) != '' ) then (
		round-half-to-even( xs:decimal(data($item)), 2 )
	) else (0.0)
};


declare function xf:consultaSaldosTCOut($consultarSaldosVasaResponse as element(ns1:ConsultarSaldosVasaResponse),
    $ID as xs:string,
    $TYPE as xs:string,
    $TASA as xs:string)
    as element() {
        <ns0:LIABILITY>
          <ns0:ID>{ $ID }</ns0:ID>
            {
            	let $successIndicator := fn:string($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:estatusConfirmacion/text())
                return
                	if ($successIndicator = '00' or $successIndicator = 'SUCCESS')then(
                        let $valMoneda := $consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta/ns1:moneda[ text() = '320']
                        return
                        if(data($valMoneda) != '')then(
                            <ns0:PRODUCT_NAME>{ data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:nombreTitular) }</ns0:PRODUCT_NAME>,
                            <ns0:BALANCES>
                            {
                                let $saldosTarjetaCreditoLocal := $consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta[ns1:moneda = '320']
                                for $nodoSaldoLocal in $saldosTarjetaCreditoLocal
                                    return
                                    <ns0:BALANCE>
                                        <ns0:CURRENCY>GTQ</ns0:CURRENCY>
                                        <ns0:PRINCIPAL>{ numIsNull($nodoSaldoLocal/ns1:saldoActual) }</ns0:PRINCIPAL>
                                        <ns0:INT_COMM>0.0</ns0:INT_COMM>
                                        <ns0:TOTAL>{ numIsNull($nodoSaldoLocal/ns1:saldoActual) }</ns0:TOTAL>
                                        <ns0:WITHDRAWAL_LIMIT>{ numIsNull($nodoSaldoLocal/ns1:disponibleRetiros) }</ns0:WITHDRAWAL_LIMIT>
                                    </ns0:BALANCE>                                      
                            }                                        
                            {
                                let $saldosTarjetaCreditoForanea := $consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta[ns1:moneda = '840']
                                for $nodoSaldoForanea in $saldosTarjetaCreditoForanea
                                return
                                    <ns0:BALANCE>
                                        <ns0:CURRENCY>USD</ns0:CURRENCY>
                                        <ns0:PRINCIPAL>{ numIsNull($nodoSaldoForanea/ns1:saldoActual) }</ns0:PRINCIPAL>
                                        <ns0:INT_COMM>0.0</ns0:INT_COMM>
                                        <ns0:TOTAL>{ numIsNull($nodoSaldoForanea/ns1:saldoActual) }</ns0:TOTAL>
                                        <ns0:WITHDRAWAL_LIMIT>{ numIsNull($nodoSaldoForanea/ns1:disponibleRetiros) }</ns0:WITHDRAWAL_LIMIT>
                                    </ns0:BALANCE> 
                            }                                     
                            </ns0:BALANCES>, 
                                                       
                            if(fn:string($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:maxFechaPago/text()) != '') then(
                                <ns0:NEXT_PAYMENT_DATE>
                                    {
                                        fn-bea:date-from-string-with-format('yyyyMMdd', data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:maxFechaPago))  
                                    }
                                </ns0:NEXT_PAYMENT_DATE>
                            ) else(),
                            
                            <ns0:TSTANDING_TOTAL>
                            {
                                let $valSaldosTarjetaCreditoLocal := $consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta[ns1:moneda = '320']/ns1:saldoActual
                                let $valSaldosTarjetaCreditoForanea := $consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:saldos/ns1:ArrayOfStrucSaldosConsulta[ns1:moneda = '840']/ns1:saldoActual
                                return
                                round-half-to-even(numIsNull($valSaldosTarjetaCreditoLocal) + (numIsNull($valSaldosTarjetaCreditoForanea) * xs:decimal($TASA)), 2)
                            }
                            </ns0:TSTANDING_TOTAL>,
                            <ns0:CANCELATION_TOTAL>0.0</ns0:CANCELATION_TOTAL>,
                            <ns0:TOTAL_AMOUNT>0.0</ns0:TOTAL_AMOUNT>,  
                            <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                            <ns0:OPENING_DATE>{ fn:adjust-date-to-timezone(fn:current-date(), ()) }</ns0:OPENING_DATE>,
                            <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                            <ns0:SUCCESS_INDICATOR>SUCCESS</ns0:SUCCESS_INDICATOR>
                        )else(
                            <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
                            <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
                            <ns0:SUCCESS_INDICATOR>NO RECORDS</ns0:SUCCESS_INDICATOR>,
                            <ns0:ERROR_MESSAGE>PRODUCTO NO ENCONTRADO</ns0:ERROR_MESSAGE>
                        )
		            )else(
			            <ns0:TYPE>{ $TYPE }</ns0:TYPE>,
			            <ns0:SOURCE_BANK>GT01</ns0:SOURCE_BANK>,
			            <ns0:SUCCESS_INDICATOR>ERROR</ns0:SUCCESS_INDICATOR>,
	                    <ns0:ERROR_MESSAGE>{ data($consultarSaldosVasaResponse/ns1:ConsultarSaldosVasaResult/ns1:mensajeConfirmacion) }</ns0:ERROR_MESSAGE>
	                )
			}
        </ns0:LIABILITY>
};

declare variable $consultarSaldosVasaResponse as element(ns1:ConsultarSaldosVasaResponse) external;
declare variable $ID as xs:string external;
declare variable $TYPE as xs:string external;
declare variable $TASA as xs:string external;

xf:consultaSaldosTCOut($consultarSaldosVasaResponse,
    $ID,
    $TYPE,
    $TASA)