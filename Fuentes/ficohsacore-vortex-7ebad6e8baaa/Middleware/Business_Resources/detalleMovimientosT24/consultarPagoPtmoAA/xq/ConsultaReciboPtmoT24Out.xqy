xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamoResponse1" element="ns1:sjConsultaPrestamoResponse" location="../xsd/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:local-element-return type="ns0:consultaDetalleCompletoTransaccionResponse/DETAILS" location="../../../consultaTransacciones/ConsultaDetalleCompletoTransaccion/consultaDetalleCompletoTransaccionTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosT24/consultarPagoPtmoAA/xq/ConsultaReciboPtmoT24Out/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleCompletoTransaccionTypes";

declare function xf:ConsultaReciboPtmoT24Out($sjConsultaPrestamoResponse1 as element(ns1:sjConsultaPrestamoResponse),
$loanPreviousBalance as xs:string)
    as element() {
        <DETAILS>
            <DETAIL_RECORD>
               <LABEL>--------------------------------------</LABEL>
               <VALUE>--------------------------------------</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>PAGO DE PRESTAMO</LABEL>
               <VALUE/>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>--------------------------------------</LABEL>
               <VALUE>--------------------------------------</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>NUMERO DE PRESTAMO:</LABEL>
               <VALUE>{ fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/LOAN_NUMBER/text()) }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>NOMBRE DEL PRESTATARIO:</LABEL>
               <VALUE>{ fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaDatosPrestamo/CUSTOMER_NAME/text()) }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>TASA</LABEL>
               <VALUE>{ fn:concat(fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaDatosPrestamo/INTEREST_RATE/text()),"%") }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>FECHA APERTURA</LABEL>
               <VALUE>{ fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaDatosPrestamo/OPENING_DATE/text()) }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>FECHA VENCIMIENTO</LABEL>
               <VALUE>{ fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaDatosPrestamo/MATURITY_DATE/text()) }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>NUMERO DE CUOTA</LABEL>
               <VALUE>{ fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/PAID_INSTALLMENT_NO/text()) }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>--------------------------------------</LABEL>
               <VALUE>--------------------------------------</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>DESGLOSE DE PAGO</LABEL>
               <VALUE/>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>--------------------------------------</LABEL>
               <VALUE>--------------------------------------</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>TIPO DE SALDO</LABEL>
               <VALUE>VALOR PAGO</VALUE>
            </DETAIL_RECORD>
            {
            	for $PAYMENT_DETAIL in $sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/PAYMENT_DETAILS/PAYMENT_DETAIL
            	return
					<DETAIL_RECORD>
		               <LABEL>{ fn:concat(data($PAYMENT_DETAIL/PAYMENT_TYPE),":") }</LABEL>
		               <VALUE>{ fn-bea:format-number(data($PAYMENT_DETAIL/PAYMENT_VALUE),"###.00") }</VALUE>
		            </DETAIL_RECORD>            		
            }
            <DETAIL_RECORD>
               <LABEL>TOTAL ABONO:</LABEL>
               <VALUE>{ fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/TOTAL_PAYMENT/text()) }</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>SALDOS ACTUALES A LA FECHA HOY</LABEL>
               <VALUE/>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>SALDO DE INTERES:</LABEL>
               <VALUE>0.00</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
            	<LABEL>SALDO CAPITAL ANTERIOR:</LABEL>
               	<VALUE>
               		{ 
               			if (fn:substring(fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/TRANSACTION_ID/text()),1,2) = "FI") then (
               				fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/PREVIOUS_PRINCIPAL_BALANCE/text())
               			) else (
               				fn-bea:format-number(fn:number($loanPreviousBalance),"###.00")
               			) 
               		}
               	</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
            	<LABEL>SALDO CAPITAL ACTUAL:</LABEL>
               	<VALUE>
               	{
               		if (fn:substring(fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/TRANSACTION_ID/text()),1,2) = "FI") then (
               				fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/CURRENT_PRINCIPAL_BALANCE/text())
               			) else (               		
		               		let $CURRENT_PRIN_AMOUNT := fn:string($sjConsultaPrestamoResponse1/ns1:sjConsultaPrestamoResponseType/ns1:consultaPagoPrestamo/CURRENT_PRIN_AMOUNT/text())
		               		return
		               			fn-bea:format-number(fn:number($loanPreviousBalance) - fn:number($CURRENT_PRIN_AMOUNT),"###.00")
		               	)
               	}
               	</VALUE>
            </DETAIL_RECORD>
         </DETAILS>
};

declare variable $sjConsultaPrestamoResponse1 as element(ns1:sjConsultaPrestamoResponse) external;
declare variable $loanPreviousBalance as xs:string external; 

xf:ConsultaReciboPtmoT24Out($sjConsultaPrestamoResponse1,
$loanPreviousBalance)