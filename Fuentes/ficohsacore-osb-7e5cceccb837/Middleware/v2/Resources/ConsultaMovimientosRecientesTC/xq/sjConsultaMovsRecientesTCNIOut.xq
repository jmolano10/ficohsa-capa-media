(:: pragma bea:global-element-parameter parameter="$sjConsultaMovsRecientesTCNIResponse" element="ns0:sjConsultaMovsRecientesTCNIResponse" location="../../../BusinessServices/SJS/consultaMovsRecientesTCNI/xsd/sjConsultaMovsRecientesTCNI.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMovimientosRecientesTCResponse" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMovsRecientesTCNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMovimientosRecientesTC/xq/sjConsultaMovsRecientesTCNIOut/";

declare function formatoDosDecimales ($input as xs:string?){
	xs:string(fn:round-half-to-even( xs:decimal(data($input)), 2))
};

declare function xf:sjConsultaMovsRecientesTCNIOut($sjConsultaMovsRecientesTCNIResponse as element(ns0:sjConsultaMovsRecientesTCNIResponse))
    as element(ns1:consultaMovimientosRecientesTCResponse) {
        <ns1:consultaMovimientosRecientesTCResponse>
            {
                for $OWNER_NAME in $sjConsultaMovsRecientesTCNIResponse/OWNER_NAME
                return
                    <OWNER_NAME>{ data($OWNER_NAME) }</OWNER_NAME>
            }
            {
                for $CARD_NUMBER in $sjConsultaMovsRecientesTCNIResponse/CARD_NUMBER
                return
                    <CARD_NUMBER>{ data($CARD_NUMBER) }</CARD_NUMBER>
            }
            {
                for $CREDIT_LIMIT in $sjConsultaMovsRecientesTCNIResponse/CREDIT_LIMIT
                return
                    <CREDIT_LIMIT>{ data($CREDIT_LIMIT) }</CREDIT_LIMIT>
            }
            {
                for $CREDIT_LIMIT_CCY in $sjConsultaMovsRecientesTCNIResponse/CREDIT_LIMIT_CCY
                return
                    <CREDIT_LIMIT_CCY>{ data($CREDIT_LIMIT_CCY) }</CREDIT_LIMIT_CCY>
            }
            {
                for $PREVIOUS_BALANCE_LCY in $sjConsultaMovsRecientesTCNIResponse/PREVIOUS_BALANCE_LCY
                return
                    <PREVIOUS_BALANCE_LCY>{ data($PREVIOUS_BALANCE_LCY) }</PREVIOUS_BALANCE_LCY>
            }
            {
                for $PREVIOUS_BALANCE_FCY in $sjConsultaMovsRecientesTCNIResponse/PREVIOUS_BALANCE_FCY
                return
                    <PREVIOUS_BALANCE_FCY>{ data($PREVIOUS_BALANCE_FCY) }</PREVIOUS_BALANCE_FCY>
            }
            {
                for $tarjetas in distinct-values($sjConsultaMovsRecientesTCNIResponse/MOVS/MOV/CARD_NUMBER)
                let $MOVS := $sjConsultaMovsRecientesTCNIResponse/MOVS/MOV[CARD_NUMBER=$tarjetas]
                return 
                	 <ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
                		<CARD_NUMBER>{ data($tarjetas) }</CARD_NUMBER>
                		<CARD_HOLDER_NAME>{ data($MOVS[1]/CARD_HOLDER_NAME) }</CARD_HOLDER_NAME>
                		<ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>
                		{
			                for $MOV in $MOVS
			                return 
			                	<ns1:consultaMovimientosRecientesTCDetalleTarjeta>
			                		<TRANSACTION_DATE>{ data($MOV/TRANSACTION_DATE) }</TRANSACTION_DATE>
			                		<DESCRIPTION>{ data($MOV/DESCRIPTION) }</DESCRIPTION>
				                    <AMOUNT>{ formatoDosDecimales(data($MOV/AMOUNT)) }</AMOUNT>
				                    <CURRENCY>{ data($MOV/CURRENCY) }</CURRENCY>
				                    <ORIGINAL_AMOUNT>{  formatoDosDecimales(data($MOV/ORIGINAL_AMOUNT)) }</ORIGINAL_AMOUNT>
				                    <ORIGINAL_CURRENCY>{ data($MOV/ORIGINAL_CURRENCY) }</ORIGINAL_CURRENCY>
				                    <TYPE_OF_TRANSACTION>{ data($MOV/TYPE_OF_TRANSACTION) }</TYPE_OF_TRANSACTION>
			                   	</ns1:consultaMovimientosRecientesTCDetalleTarjeta>
			            }
		                </ns1:consultaMovimientosRecientesTCRegistroTarjetasAdicionales>    
		             </ns1:consultaMovimientosRecientesTCTarjetasAdicionales>
            }
        </ns1:consultaMovimientosRecientesTCResponse>
};

declare variable $sjConsultaMovsRecientesTCNIResponse as element(ns0:sjConsultaMovsRecientesTCNIResponse) external;

xf:sjConsultaMovsRecientesTCNIOut($sjConsultaMovsRecientesTCNIResponse)