(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns0:consultaMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaUltimosNMovimientosCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaUltimosNMovimientos/ConsultaUltimosNMovimientosCuentaOut/";

declare function xf:ConsultaUltimosNMovimientosCuentaOut($consultaMovimientosCuentaResponse1 as element(ns0:consultaMovimientosCuentaResponse), $cantidad as xs:string, $tipo as xs:string)
    as element(ns0:consultaUltimosNMovimientosCuentaResponse) {
        <ns0:consultaUltimosNMovimientosCuentaResponse>
            {
                for $ACCOUNT_NUMBER in $consultaMovimientosCuentaResponse1/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNT_NAME in $consultaMovimientosCuentaResponse1/ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultaMovimientosCuentaResponse1/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $STARTING_BALANCE in $consultaMovimientosCuentaResponse1/STARTING_BALANCE
                return
                    <STARTING_BALANCE>{ data($STARTING_BALANCE) }</STARTING_BALANCE>
            }
            {
                for $ENDING_BALANCE in $consultaMovimientosCuentaResponse1/ENDING_BALANCE
                return
                    <ENDING_BALANCE>{ data($ENDING_BALANCE) }</ENDING_BALANCE>
            }
            {
                for $START_DATE in $consultaMovimientosCuentaResponse1/START_DATE
                return
                    <START_DATE>{ data($START_DATE) }</START_DATE>
            }
            {
                for $END_DATE in $consultaMovimientosCuentaResponse1/END_DATE
                return
                    <END_DATE>{ data($END_DATE) }</END_DATE>
            }
            <ns0:consultaMovimientosCuentaResponseType>
                {
                	for $superItem at $i in
	                	for $item in $consultaMovimientosCuentaResponse1/ns0:consultaMovimientosCuentaResponseType/ns0:consultaMovimientosCuentaResponseRecordType
						where ( ( $item/AMOUNT >= 0 and $tipo = "CREDIT") or 
								($item/AMOUNT <= 0 and $tipo = "DEBIT") or 
								$tipo = "")
		            	order by $item/VALUE_DATE descending
		            	return
	            			$item
	            	where $i <= $cantidad cast as xs:integer
	            	return
	            		<ns0:consultaMovimientosCuentaResponseRecordType>
		            		<VALUE_DATE>{ data($superItem/VALUE_DATE) }</VALUE_DATE>
	                        <DESCRIPTION>{ data($superItem/DESCRIPTION) }</DESCRIPTION>
	                        <REF_NO>{ data($superItem/REF_NO) }</REF_NO>
	                        <DOCUMENT_NUMBER>{ data($superItem/DOCUMENT_NUMBER) }</DOCUMENT_NUMBER>
	                        <AMOUNT>{ data($superItem/AMOUNT) }</AMOUNT>
	                	</ns0:consultaMovimientosCuentaResponseRecordType>
                }
            </ns0:consultaMovimientosCuentaResponseType>
        </ns0:consultaUltimosNMovimientosCuentaResponse>
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns0:consultaMovimientosCuentaResponse) external;
declare variable $cantidad as xs:string external;
declare variable $tipo as xs:string external;

xf:ConsultaUltimosNMovimientosCuentaOut($consultaMovimientosCuentaResponse1, $cantidad, $tipo)