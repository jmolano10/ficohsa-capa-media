xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaLotesClienteResponse" element="ns0:consultaLotesClienteResponse" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaLotesClienteResponse" location="../xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaLotesClienteOut/";

declare function xf:consultaLotesClienteOut($consultaLotesClienteResponse as element(ns0:consultaLotesClienteResponse))
    as element(ns0:consultaLotesClienteResponse) {
        <ns0:consultaLotesClienteResponse>
            {
                for $CUSTOMER_ID in $consultaLotesClienteResponse/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            {
                for $BEGIN_DATE in $consultaLotesClienteResponse/BEGIN_DATE
                return
                    <BEGIN_DATE>{ data($BEGIN_DATE) }</BEGIN_DATE>
            }
            {
                for $END_DATE in $consultaLotesClienteResponse/END_DATE
                return
                    <END_DATE>{ data($END_DATE) }</END_DATE>
            }
            {
                for $BATCHES in $consultaLotesClienteResponse/BATCHES
                return
                    <BATCHES>
                        {
                            for $BATCH in $BATCHES/BATCH
                            return
                                <BATCH>
                                    {
                                        for $BANK_BATCH_ID in $BATCH/BANK_BATCH_ID
                                        return
                                            <BANK_BATCH_ID>{ data($BANK_BATCH_ID) }</BANK_BATCH_ID>
                                    }
                                    {
                                        for $CUSTOMER_BATCH_ID in $BATCH/CUSTOMER_BATCH_ID
                                        return
                                            <CUSTOMER_BATCH_ID>{ data($CUSTOMER_BATCH_ID) }</CUSTOMER_BATCH_ID>
                                    }
                                    {
                                        for $TYPE in $BATCH/TYPE
                                        return
                                            <TYPE>{ data($TYPE) }</TYPE>
                                    }
                                    {
                                        for $TYPE_DESC in $BATCH/TYPE_DESC
                                        return
                                            <TYPE_DESC>{ data($TYPE_DESC) }</TYPE_DESC>
                                    }
                                    {
                                        for $UPLOAD_DATE in $BATCH/UPLOAD_DATE
                                        return
                                            <UPLOAD_DATE>{ data($UPLOAD_DATE) }</UPLOAD_DATE>
                                    }
                                    {
                                    	for $APPLICATION_DATE in $BATCH/APPLICATION_DATE
                                    	return
                                    		<APLICATION_DATE>{ xs:dateTime($APPLICATION_DATE) cast as xs:date }</APLICATION_DATE>
                                    }                                    
                                    {
                                        for $NUMBER_OF_TRANSACTIONS in $BATCH/NUMBER_OF_TRANSACTIONS
                                        return
                                            <NUMBER_OF_TRANSACTIONS>{ data($NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
                                    }
                                    {
                                        for $NUMBER_OF_TRANSACTIONS_SUCCESS in $BATCH/NUMBER_OF_TRANSACTIONS_SUCCESS
                                        return
                                            <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($NUMBER_OF_TRANSACTIONS_SUCCESS) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
                                    }
                                    {
                                        for $NUMBER_OF_TRANSACTIONS_ERROR in $BATCH/NUMBER_OF_TRANSACTIONS_ERROR
                                        return
                                            <NUMBER_OF_TRANSACTIONS_ERROR>{ data($NUMBER_OF_TRANSACTIONS_ERROR) }</NUMBER_OF_TRANSACTIONS_ERROR>
                                    }
                                    {
                                        for $TOTAL_AMOUNT in $BATCH/TOTAL_AMOUNT
                                        return
                                            <TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</TOTAL_AMOUNT>
                                    }
                                    {
                                        for $TOTAL_AMOUNT_ERROR in $BATCH/TOTAL_AMOUNT_ERROR
                                        return
                                            <TOTAL_AMOUNT_ERROR>{ data($TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
                                    }
                                    {
                                        for $STATUS_DESC in $BATCH/STATUS_DESC
                                        return
                                            <STATUS>{ data($STATUS_DESC) }</STATUS>
                                    }
                                </BATCH>
                        }
                    </BATCHES>
            }
        </ns0:consultaLotesClienteResponse>
};

declare variable $consultaLotesClienteResponse as element(ns0:consultaLotesClienteResponse) external;

xf:consultaLotesClienteOut($consultaLotesClienteResponse)