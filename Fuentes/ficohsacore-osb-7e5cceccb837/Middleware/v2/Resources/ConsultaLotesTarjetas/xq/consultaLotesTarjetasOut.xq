(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEBITCARD/consultaLotes/xsd/consultaLotes_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLotesTarjetasResponse" location="../../OperacionesTarjetaDebito/xsd/operacionesTarjetaDebitoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesTarjetaDebitoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLotes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLotesTarjetas/xq/consultaLotesTarjetasOut/";

declare function xf:consultaLotesTarjetasOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaLotesTarjetasResponse) {
        <ns0:consultaLotesTarjetasResponse>
            <BATCH_DETAILS>
                {
                    for $PT_BATCH_DETAILS_ITEM in $outputParameters/ns1:PT_BATCH_DETAILS/ns1:PT_BATCH_DETAILS_ITEM
                    return
                    	if(fn:string($PT_BATCH_DETAILS_ITEM/ns1:BATCH_REFERENCE/text()) != '') then(
	                        <BATCH_ITEM>
	                        	<BATCH_BRANCH_CODE>{ data($PT_BATCH_DETAILS_ITEM/ns1:BATCH_BRANCH_CODE) }</BATCH_BRANCH_CODE>
	                            <BATCH_REFERENCE>{ data($PT_BATCH_DETAILS_ITEM/ns1:BATCH_REFERENCE) }</BATCH_REFERENCE>
	                            <BATCH_DATE>{ data($PT_BATCH_DETAILS_ITEM/ns1:BATCH_DATE) }</BATCH_DATE>
	                            <BATCH_STATUS>{ data($PT_BATCH_DETAILS_ITEM/ns1:BATCH_STATUS) }</BATCH_STATUS>
	                            <CARD_DETAILS>
	                                {
	                                    for $CARD_DETAILS_ITEM in $PT_BATCH_DETAILS_ITEM/ns1:CARD_DETAILS/ns1:CARD_DETAILS_ITEM
	                                    return
	                                    	if(fn:string($CARD_DETAILS_ITEM/ns1:BIN/text()) != '') then(
		                                        <CARD_ITEM>
		                                            <BIN>{ data($CARD_DETAILS_ITEM/ns1:BIN) }</BIN>
		                                            <CARD_NUMBER>{ data($CARD_DETAILS_ITEM/ns1:CARD_NUMBER) }</CARD_NUMBER>
		                                            <CARD_LIFESPAN>{ data($CARD_DETAILS_ITEM/ns1:CARD_LIFESPAN) }</CARD_LIFESPAN>
		                                            <CARD_STATUS>{ data($CARD_DETAILS_ITEM/ns1:CARD_STATUS) }</CARD_STATUS>
		                                        </CARD_ITEM>
	                                        )else()
	                                }
	                            </CARD_DETAILS>
	                        </BATCH_ITEM>
                       	)else()
                }
            </BATCH_DETAILS>
        </ns0:consultaLotesTarjetasResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaLotesTarjetasOut($outputParameters)