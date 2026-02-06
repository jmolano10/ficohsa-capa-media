xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosCuentaResponse1" element="ns0:consultaMovimientosCuentaResponse" location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUltimosNMovimientosCuentaResponse" location="../xsd/consultasUltimosNMovimientosCuentaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasUltimosNMovimientosTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaUltimosNMovimientosCuenta/xq/ConsultaUltimosNMovimientosCuentaOut/";

declare function xf:ConsultaUltimosNMovimientosCuentaOut($consultaMovimientosCuentaResponse1 as element(ns0:consultaMovimientosCuentaResponse),
    $cantidad as xs:string,
    $tipo as xs:string)
    as element(ns1:consultaUltimosNMovimientosCuentaResponse) {
        <ns1:consultaUltimosNMovimientosCuentaResponse>
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
             <ns1:consultaMovimientosCuentaResponseType>
                {
                	let $superItem := fn:reverse(
	                	for $item in $consultaMovimientosCuentaResponse1/ns0:consultaMovimientosCuentaResponseType/ns0:consultaMovimientosCuentaResponseRecordType
						where ( ( $item/AMOUNT >= 0 and $tipo = "CREDIT") or 
								($item/AMOUNT <= 0 and $tipo = "DEBIT") or 
								$tipo = "")
		            	return
	            			$item )
	            	let $totalRecs := fn:count($superItem)
	            	let $recs := (
	            		if ($totalRecs > xs:int($cantidad)) then (
	            			xs:int($cantidad)
	            		) else (
	            			$totalRecs
	            		)
	            	)
	            	for $i in 1 to $recs		
	            	return
	            		<ns1:consultaMovimientosCuentaResponseRecordType>
		            		<VALUE_DATE>{ data($superItem[$i]/VALUE_DATE) }</VALUE_DATE>
	                        <DESCRIPTION>{ data($superItem[$i]/DESCRIPTION) }</DESCRIPTION>
	                        <REF_NO>{ data($superItem[$i]/REF_NO) }</REF_NO>
	                        <DOCUMENT_NUMBER>{ data($superItem[$i]/DOCUMENT_NUMBER) }</DOCUMENT_NUMBER>
	                        <AMOUNT>{ data($superItem[$i]/AMOUNT) }</AMOUNT>
	                        <EFFECT_ON_BALANCE>{ data($superItem[$i]/EFFECT_ON_BALANCE) }</EFFECT_ON_BALANCE>
	                	    <INPUTTER>{ data($superItem[$i]/INPUTTER) }</INPUTTER>
		                    <TXNCODE>{ data($superItem[$i]/TXNCODE) }</TXNCODE>
							<TXNAGNCODE>{ data($superItem[$i]/TXNAGNCODE) }</TXNAGNCODE>
							<TXNAGNNAME>{ data($superItem[$i]/TXNAGNNAME) }</TXNAGNNAME>
							<TXNDESCRIPTIONALL>{ data($superItem[$i]/TXNDESCRIPTIONALL) }</TXNDESCRIPTIONALL>
							<AUTHORISER>{ data($superItem[$i]/AUTHORISER) }</AUTHORISER>
							<TXNDATETIME>{ data($superItem[$i]/TXNDATETIME) }</TXNDATETIME>
							<RUNNING_BALANCE>{ data($superItem[$i]/RUNNING_BALANCE) }</RUNNING_BALANCE>
	                    </ns1:consultaMovimientosCuentaResponseRecordType>
                }
            </ns1:consultaMovimientosCuentaResponseType>
        </ns1:consultaUltimosNMovimientosCuentaResponse>
};

declare variable $consultaMovimientosCuentaResponse1 as element(ns0:consultaMovimientosCuentaResponse) external;
declare variable $cantidad as xs:string external;
declare variable $tipo as xs:string external;

xf:ConsultaUltimosNMovimientosCuentaOut($consultaMovimientosCuentaResponse1,
    $cantidad,
    $tipo)