xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaLotesCliente" element="ns0:consultaLotesCliente" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$customerBatchQueryResponse" element="ns1:customerBatchQueryResponse" location="../../../BusinessServices/MTR/consultorLotesCliente/wsdl/customerBatchQuery.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:consultaLotesClienteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/pms/customerBatchQuery";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaLotesCliente/xq/consultaLotesClienteNIOut/";

declare function xf:consultaLotesClienteNIOut($consultaLotesCliente as element(ns0:consultaLotesCliente),
    $customerBatchQueryResponse as element(ns1:customerBatchQueryResponse))
    as element(ns0:consultaLotesClienteResponse) {
        <ns0:consultaLotesClienteResponse>
            <CUSTOMER_ID>{ data($consultaLotesCliente/CUSTOMER_ID) }</CUSTOMER_ID>
            <BEGIN_DATE>{ data($consultaLotesCliente/BEGIN_DATE) }</BEGIN_DATE>
            <END_DATE>{ data($consultaLotesCliente/END_DATE) }</END_DATE>
            <BATCHES>
            {
            	for $i in (1 to count($customerBatchQueryResponse/batches/batch/bankBatchId))
                return
	                <BATCH>
	                    <BANK_BATCH_ID>{ data($customerBatchQueryResponse/batches/batch[$i]/bankBatchId) }</BANK_BATCH_ID>
	                    <CUSTOMER_BATCH_ID>{ data($customerBatchQueryResponse/batches/batch[$i]/customerBatchId) }</CUSTOMER_BATCH_ID>
	                    <TYPE>{ data($customerBatchQueryResponse/batches/batch[$i]/type) }</TYPE>
	                    <TYPE_DESC>{ data($customerBatchQueryResponse/batches/batch[$i]/typeDescription) }</TYPE_DESC>
	                    <UPLOAD_DATE>{ fn:adjust-date-to-timezone(data($customerBatchQueryResponse/batches/batch[$i]/uploadDate), ()) }</UPLOAD_DATE>
	                    {
	                    	for $applicationDate in $customerBatchQueryResponse/batches/batch[$i]/applicationDate
	                    	return
	                    	if(string($applicationDate/text()) != "") then (
	                    		<APPLICATION_DATE>{ fn:adjust-dateTime-to-timezone(data($applicationDate), ()) }</APPLICATION_DATE>
	                    	) else()
	                    }
	                    <NUMBER_OF_TRANSACTIONS>{ data($customerBatchQueryResponse/batches/batch[$i]/transactionsNumber) }</NUMBER_OF_TRANSACTIONS>
	                    <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($customerBatchQueryResponse/batches/batch[$i]/successTransactionsNumber) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
	                    <NUMBER_OF_TRANSACTIONS_ERROR>{ data($customerBatchQueryResponse/batches/batch[$i]/errorTransactionsNumber) }</NUMBER_OF_TRANSACTIONS_ERROR>
	                    <TOTAL_AMOUNT>{ data($customerBatchQueryResponse/batches/batch[$i]/totalAmount) }</TOTAL_AMOUNT>
	                    {
	                    	for $TOTAL_AMOUNT_ERROR in $customerBatchQueryResponse/batches/batch[$i]/errorTotalAmount
	                    	return
	                    	if(string($TOTAL_AMOUNT_ERROR/text()) != "") then (
	                    		<TOTAL_AMOUNT_ERROR>{ data($TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
	                    	) else ()
	                    }
	                    <STATUS>{ data($customerBatchQueryResponse/batches/batch[$i]/status) }</STATUS>
	                    <STATUS_DESC>{ data($customerBatchQueryResponse/batches/batch[$i]/statusDescription) }</STATUS_DESC>
	                </BATCH>
            }
            </BATCHES>
        </ns0:consultaLotesClienteResponse>
};

declare variable $consultaLotesCliente as element(ns0:consultaLotesCliente) external;
declare variable $customerBatchQueryResponse as element(ns1:customerBatchQueryResponse) external;

xf:consultaLotesClienteNIOut($consultaLotesCliente,
    $customerBatchQueryResponse)