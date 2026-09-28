(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ProcesosHN/conOpcionesPagoTC/xsd/ConsultaOpcionesPagoTC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaOpcionesPagoResponse" location="../../ConsultasCarteraCrediticia/xsd/consultasCarteraCrediticiaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaOpcionesPagoTC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultasCarteraCrediticia";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOpcionesPago/xq/ConsultaOpcionesPagoTCOut/";

declare function xf:ConsultaOpcionesPagoTCOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaOpcionesPagoResponse) {
        <ns1:consultaOpcionesPagoResponse>
        {
        	if(upper-case(data($outputParameters1/ns0:P_DESCUENTO_PAGO_MINIMO)) = "APLICA") then 
            <DISCOUNTS>
            	{
            		if (data($outputParameters1/ns0:P_DESCUENTO_DPM_LOCAL)) then
	            		<DISCOUNT>
	            			<CURRENCY>{ data($outputParameters1/ns0:P_MONEDA_LOCAL_DPM) }</CURRENCY>
	            			<PERCENT>{ data($outputParameters1/ns0:P_PORCENTAJE_DESC_DPM_LOCAL) }</PERCENT>
	            			<AMOUNT>{ data($outputParameters1/ns0:P_DESCUENTO_DPM_LOCAL) }</AMOUNT>
	            			<MAX_PAYMENT_DATE>{
	            			  fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_DPM)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_DPM)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_DPM)), '00'))
			            			}
			            	</MAX_PAYMENT_DATE>
	            		</DISCOUNT>
	            	else()	            		
            	}
            	{
            		if (data($outputParameters1/ns0:P_DESCUENTO_DPM_EXTRANJERO)) then
            		<DISCOUNT>
	            			<CURRENCY>{ data($outputParameters1/ns0:P_MONEDA_EXTRANJERA_DPM) }</CURRENCY>
	            			<PERCENT>{ data($outputParameters1/ns0:P_PORCENTAJE_DESC_DPM_EXTRANJERO) }</PERCENT>
	            			<AMOUNT>{ data($outputParameters1/ns0:P_DESCUENTO_DPM_EXTRANJERO) }</AMOUNT>
	            			<MAX_PAYMENT_DATE>{
	            			fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_DPM)), '00'), 
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_DPM)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_DPM)), '00'))
			            			}
			            	</MAX_PAYMENT_DATE>
	            		</DISCOUNT>
	            	else()	       
            	}
            </DISCOUNTS>
            else()
            }
            {
	            if(upper-case(data($outputParameters1/ns0:P_LIQUIDACION_DEUDA)) = "APLICA" ) then 
		            <LIQUIDATIONS>
		            	{
		            		if (data($outputParameters1/ns0:P_MONTO_DESC_LDD_LOCAL)) then
			            		<LIQUIDATION>
			            			<CURRENCY>{ data($outputParameters1/ns0:P_MONEDA_LOCAL_LDD) }</CURRENCY>
			            			<PERCENT>{ data($outputParameters1/ns0:P_PORCENTAJE_DESC_LDD_LOCAL) }</PERCENT>
			            			<AMOUNT>{ data($outputParameters1/ns0:P_MONTO_DESC_LDD_LOCAL) }</AMOUNT>
			            			<MAX_PAYMENT_DATE>{
			            			fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_LDD)), '00'), 
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_LDD)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_LDD)), '00'))
			            			}
			            			</MAX_PAYMENT_DATE>
			            		</LIQUIDATION>
			            	else()	            		
		            	}
		            	{
		            		if (data($outputParameters1/ns0:P_MONTO_DESCUENTO_LDD_USD)) then
		            		<LIQUIDATION>
			            			<CURRENCY>{ data($outputParameters1/ns0:P_MONEDA_EXTRANJERA_LDD) }</CURRENCY>
			            			<PERCENT>{ data($outputParameters1/ns0:P_PORCENTAJE_DESC_LDD_EXTRANJERO) }</PERCENT>
			            			<AMOUNT>{ data($outputParameters1/ns0:P_MONTO_DESC_LDD_EXTRANJERO) }</AMOUNT>
			            			<MAX_PAYMENT_DATE>{
			            			fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_LDD)), '00'), 
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_LDD)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_LDD)), '00'))
			            			}
			            			</MAX_PAYMENT_DATE>
			            		</LIQUIDATION>
			            	else()	       
		            	}
		            </LIQUIDATIONS>
	            else()
            }
            {
	            if(upper-case(data($outputParameters1/ns0:P_REFINANCIAMIENTO )) = "APLICA") then 
		            <REFINANCING>
		                <RATE>{ data($outputParameters1/ns0:P_TASA_REFINANCIAR) }</RATE>
		                <PERIOD>{ data($outputParameters1/ns0:P_PLAZO_REFINANCIAR) }</PERIOD>
		                <INSTALLMENT>{ data($outputParameters1/ns0:P_CUOTA_CALCULADA_SEGURO) }</INSTALLMENT>
		                <PREMIUM>{ data($outputParameters1/ns0:P_MONTO_PRIMA) }</PREMIUM>
		                <TOTAL_AMOUNT>{ data($outputParameters1/ns0:P_SALDO_REFINANCIAR) }</TOTAL_AMOUNT>
		                <MAX_PAYMENT_DATE>{
		                fn:concat(fn-bea:format-number(fn:year-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_REF)), '00'), 
	            			  			'-',
			            				fn-bea:format-number(fn:month-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_REF)), '00'),
	            			  			'-',
			            				fn-bea:format-number(fn:day-from-dateTime(data($outputParameters1/ns0:P_FECHA_LIMITE_PAGO_REF)), '00'))
			            			}
			            </MAX_PAYMENT_DATE>
		            </REFINANCING>
	            else()
            }
        </ns1:consultaOpcionesPagoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $monedaLocal as xs:string external;

xf:ConsultaOpcionesPagoTCOut($outputParameters1)