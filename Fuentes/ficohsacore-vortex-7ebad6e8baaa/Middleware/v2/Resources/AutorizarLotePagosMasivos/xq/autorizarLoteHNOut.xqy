xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/autorizaLote/xsd/autorizarLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:autorizarLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteHNOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarLote";

declare function xf:autorizarLoteHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:autorizarLoteResponse) {
        <ns0:autorizarLoteResponse>
            <BATCHES>
                {                
                let $bank_batch_id := $outputParameters/ns1:PT_DETALLELOTE/ns1:ITEM/ns1:NUMERO_LOTE
                let $estado := $outputParameters/ns1:PT_DETALLELOTE/ns1:ITEM/ns1:ESTADO
                let $descripcion_estado := $outputParameters/ns1:PT_DETALLELOTE/ns1:ITEM/ns1:DESCRIPCION_ESTADO
                let $detalleError := $outputParameters/ns1:PT_DETALLELOTE/ns1:ITEM
            	for $i in 1 to count($bank_batch_id)
            	return
                    <BATCH>
                        <BANK_BATCH_ID>{ data($bank_batch_id[$i]) }</BANK_BATCH_ID>
                        <STATUS>{ data($estado[$i]) }</STATUS>
                        <STATUS_DESC>{ data($descripcion_estado[$i]) }</STATUS_DESC>
                        {
                        	let $account_number := $detalleError[$i]/ns1:NUMERO_CUENTA/ns1:ITEM
			                let $batch_amount := $detalleError[$i]/ns1:MONTO_LOTE/ns1:ITEM
			                let $tsp_amount := $detalleError[$i]/ns1:MONTO_TSP/ns1:ITEM			      
				            return
				            	if(count($account_number) > 0) then (
			                        <DETAIL_ERRORS>
			                        {
										for $j in 1 to count($account_number)
										return
					                    	<DETAIL_ERROR>
					                        	<ACCOUNT_NUMBER>{ data($account_number[$j]) }</ACCOUNT_NUMBER>
					                            <BATCH_AMOUNT>{ data($batch_amount[$j]) }</BATCH_AMOUNT>
					                            <TAX_AMOUNT>{ data($tsp_amount[$j]) }</TAX_AMOUNT>
					                        </DETAIL_ERROR>
			                        }
			                        </DETAIL_ERRORS>
			                    ) else ()
                    	}
                    </BATCH>
                }
            </BATCHES>
        </ns0:autorizarLoteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:autorizarLoteHNOut($outputParameters)