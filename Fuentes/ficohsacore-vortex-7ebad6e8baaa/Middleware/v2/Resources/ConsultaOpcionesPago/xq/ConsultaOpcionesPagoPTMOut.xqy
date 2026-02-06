xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ProcesosHN/conOpcionesPagoPTM/xsd/ConsultaOpcionesPagoPTM_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaOpcionesPagoResponse" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaOpcionesPagoPTM";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOpcionesPago/xq/ConsultaOpcionesPagoPTMOut/";

declare function xf:ConsultaOpcionesPagoPTMOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaOpcionesPagoResponse) {
        <ns0:consultaOpcionesPagoResponse>
        {
            if (upper-case(data($outputParameters1/ns1:P_DESCUENTO_INTERES)) = "APLICA") then
		            <DISCOUNTS>
		                <DISCOUNT>
		                	<CURRENCY>{ data($outputParameters1/ns1:P_MONEDA) }</CURRENCY>
		                    <PERCENT>{ data($outputParameters1/ns1:P_PORCENTAJE_DESCUENTO_INTERES) }</PERCENT>
		                    <AMOUNT> { data($outputParameters1/ns1:P_MONTO_DESCUENTO_INTERES) }</AMOUNT>
		                    <MAX_PAYMENT_DATE>{
		                    fn:concat(
		                    	fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_INTERES)), '00'), 
	            			  	'-',
			            		fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_INTERES)), '00'),
	            			  	'-',
			            		fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_INTERES)), '00')
			            		)
			            			}
			            	</MAX_PAYMENT_DATE>
		                </DISCOUNT>
		            </DISCOUNTS>
	           else()
            }
            {
            if (upper-case(data($outputParameters1/ns1:P_LIQUIDACION_DEUDA)) = "APLICA") then
	            <LIQUIDATIONS>
	                <LIQUIDATION>
	                	<CURRENCY>{ data($outputParameters1/ns1:P_MONEDA) }</CURRENCY>
	                    <PERCENT>{ data($outputParameters1/ns1:P_PORCENTAJE_LDD) }</PERCENT>
	                    <AMOUNT>{ data($outputParameters1/ns1:P_MONTO_DESCUENTO_LDD) }</AMOUNT>
	                    <MAX_PAYMENT_DATE>{
	                    fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_LDD)), '00'), 
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_LDD)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_LDD)), '00'))
			            			}
			            </MAX_PAYMENT_DATE>
	                </LIQUIDATION>
	            </LIQUIDATIONS>
	            else()
            }
            {
	            if (upper-case(data($outputParameters1/ns1:P_REFINANCIAMIENTO)) = "APLICA") then
		            <REFINANCING>
		                <RATE>{ data($outputParameters1/ns1:P_TASA_REFINANCIAR) }</RATE>
		                <PERIOD>{ data($outputParameters1/ns1:P_PLAZO_REFINANCIAR) }</PERIOD>
		                <INSTALLMENT>{ data($outputParameters1/ns1:P_CUOTA_CALCULADA_SEGURO) }</INSTALLMENT>
		                <PREMIUM>{ data($outputParameters1/ns1:P_SALDO_REFINANCIAR) }</PREMIUM>
		                <TOTAL_AMOUNT>{ data($outputParameters1/ns1:P_MONTO_PRIMA) }</TOTAL_AMOUNT>
		                <MAX_PAYMENT_DATE>{
		                fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_REF)), '00'), 
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_REF)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns1:P_FECHA_LIMITE_PAGO_REF)), '00'))
			            			}
			            </MAX_PAYMENT_DATE>
		            </REFINANCING>
	            else()
            }
        </ns0:consultaOpcionesPagoResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ConsultaOpcionesPagoPTMOut($outputParameters1)