xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaLotesCliente" element="ns0:consultaLotesCliente" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PMSV/consultaLotesCliente/xsd/consultaLotesCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLotesClienteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaLotesCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLotesCliente/xq/consultaLotesClienteOut/";

declare function xf:consultaLotesClienteOut($consultaLotesCliente as element(ns0:consultaLotesCliente),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaLotesClienteResponse) {
        <ns2:consultaLotesClienteResponse>
            <CUSTOMER_ID>{ data($consultaLotesCliente/CUSTOMER_ID) }</CUSTOMER_ID>
            <BEGIN_DATE>{ data($consultaLotesCliente/BEGIN_DATE) }</BEGIN_DATE>
            <END_DATE>{ data($consultaLotesCliente/END_DATE) }</END_DATE>
            <BATCHES>
                {
                let $BANK_BATCH_ID := $outputParameters/ns1:BANK_BATCH_ID/ns1:ITEM
				let $UPLOAD_DATE := $outputParameters/ns1:UPLOAD_DATE/ns1:ITEM
				let $CUSTOMER_BATCH_ID := $outputParameters/ns1:CUSTOMER_BATCH_ID/ns1:ITEM
				let $APLICATION_DATE := $outputParameters/ns1:APLICATION_DATE/ns1:ITEM
				let $NUMBER_OF_TRANSACTIONS := $outputParameters/ns1:NUMBER_OF_TRANSACTIONS/ns1:ITEM
				let $NUMBER_OF_TRANSACTION_SUCCESS := $outputParameters/ns1:NUMBER_OF_TRANSACTION_SUCCESS/ns1:ITEM
				let $NUMBER_OF_TRANSACTION_ERROR := $outputParameters/ns1:NUMBER_OF_TRANSACTION_ERROR/ns1:ITEM
				let $TOTAL_AMOUNT := $outputParameters/ns1:TOTAL_AMOUNT/ns1:ITEM
				let $TOTAL_AMOUNT_ERROR := $outputParameters/ns1:TOTAL_AMOUNT_ERROR/ns1:ITEM
				let $STATUS := $outputParameters/ns1:STATUS/ns1:ITEM
                let $STATUS_DESC := $outputParameters/ns1:STATUS_DESC/ns1:ITEM
				let $TYPE := $outputParameters/ns1:BATCH_TYPE/ns1:ITEM
				let $TYPE_DESC := $outputParameters/ns1:TYPE_DESC/ns1:ITEM
				
                    for $i in (1 to count($BANK_BATCH_ID))
                    return
                        <BATCH>
                        	<BANK_BATCH_ID>{data($BANK_BATCH_ID[$i])}</BANK_BATCH_ID>
                        	<CUSTOMER_BATCH_ID>{data($CUSTOMER_BATCH_ID[$i])}</CUSTOMER_BATCH_ID>
                        	<TYPE>{data($TYPE[$i])}</TYPE>
                        	<TYPE_DESC>{data($TYPE_DESC[$i])}</TYPE_DESC>
                        	<UPLOAD_DATE>{fn:adjust-date-to-timezone(fn-bea:date-from-dateTime($UPLOAD_DATE[$i]),())}</UPLOAD_DATE>
                        	<APPLICATION_DATE>{fn:adjust-dateTime-to-timezone($APLICATION_DATE[$i],())}</APPLICATION_DATE>
                        	<NUMBER_OF_TRANSACTIONS>{data($NUMBER_OF_TRANSACTIONS[$i])}</NUMBER_OF_TRANSACTIONS>
                        	<NUMBER_OF_TRANSACTIONS_SUCCESS>{data($NUMBER_OF_TRANSACTION_SUCCESS[$i])}</NUMBER_OF_TRANSACTIONS_SUCCESS>
                        	<NUMBER_OF_TRANSACTIONS_ERROR>{data($NUMBER_OF_TRANSACTION_ERROR[$i])}</NUMBER_OF_TRANSACTIONS_ERROR>
                        	<TOTAL_AMOUNT>{data($TOTAL_AMOUNT[$i])}</TOTAL_AMOUNT>
                        	<TOTAL_AMOUNT_ERROR>{data($TOTAL_AMOUNT_ERROR[$i])}</TOTAL_AMOUNT_ERROR>
                        	<STATUS>{data($STATUS[$i])}</STATUS>
                            <STATUS_DESC>{data($STATUS_DESC[$i])} </STATUS_DESC>
                        	
                        </BATCH>
                }
            </BATCHES>
        </ns2:consultaLotesClienteResponse>
};

declare variable $consultaLotesCliente as element(ns0:consultaLotesCliente) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaLotesClienteOut($consultaLotesCliente,
    $outputParameters)