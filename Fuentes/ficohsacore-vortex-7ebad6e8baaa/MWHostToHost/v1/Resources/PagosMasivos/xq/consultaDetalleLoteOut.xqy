xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleLoteResponse" element="ns0:consultaDetalleLoteResponse" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDetalleLoteResponse" location="../xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaDetalleLoteOut/";

declare function xf:consultaDetalleLoteOut($consultaDetalleLoteResponse as element(ns0:consultaDetalleLoteResponse))
    as element(ns0:consultaDetalleLoteResponse) {
        <ns0:consultaDetalleLoteResponse>
            {
                for $CUSTOMER_ID in $consultaDetalleLoteResponse/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            {
                for $BANK_BATCH_ID in $consultaDetalleLoteResponse/BANK_BATCH_ID
                return
                    <BANK_BATCH_ID>{ data($BANK_BATCH_ID) }</BANK_BATCH_ID>
            }
            {
                for $BATCH_TYPE in $consultaDetalleLoteResponse/BATCH_TYPE
                return
                    <BATCH_TYPE>{ data($BATCH_TYPE) }</BATCH_TYPE>
            }
            {
                for $BATCH_TYPE_DESC in $consultaDetalleLoteResponse/BATCH_TYPE_DESC
                return
                    <BATCH_TYPE_DESC>{ data($BATCH_TYPE_DESC) }</BATCH_TYPE_DESC>
            }
            {
                for $UPLOAD_DATE in $consultaDetalleLoteResponse/UPLOAD_DATE
                return
                    <UPLOAD_DATE>{ data($UPLOAD_DATE) }</UPLOAD_DATE>
            }
            {
            	for $APPLICATION_DATE in $consultaDetalleLoteResponse/APPLICATION_DATE
            	return
            		<APPLICATION_DATE>{ xs:dateTime($APPLICATION_DATE) cast as xs:date }</APPLICATION_DATE>
            }            
            {
                for $NUMBER_OF_TRANSACTIONS in $consultaDetalleLoteResponse/NUMBER_OF_TRANSACTIONS
                return
                    <NUMBER_OF_TRANSACTIONS>{ data($NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
            }
            {
                for $NUMBER_OF_TRANSACTIONS_SUCCESS in $consultaDetalleLoteResponse/NUMBER_OF_TRANSACTIONS_SUCCESS
                return
                    <NUMBER_OF_TRANSACTIONS_SUCCESS>{ data($NUMBER_OF_TRANSACTIONS_SUCCESS) }</NUMBER_OF_TRANSACTIONS_SUCCESS>
            }
            {
                for $NUMBER_OF_TRANSACTIONS_ERROR in $consultaDetalleLoteResponse/NUMBER_OF_TRANSACTIONS_ERROR
                return
                    <NUMBER_OF_TRANSACTIONS_ERROR>{ data($NUMBER_OF_TRANSACTIONS_ERROR) }</NUMBER_OF_TRANSACTIONS_ERROR>
            }
            {
                for $TOTAL_AMOUNT in $consultaDetalleLoteResponse/TOTAL_AMOUNT
                return
                    <TOTAL_AMOUNT>{ data($TOTAL_AMOUNT) }</TOTAL_AMOUNT>
            }
            {
                for $TOTAL_AMOUNT_ERROR in $consultaDetalleLoteResponse/TOTAL_AMOUNT_ERROR
                return
                    <TOTAL_AMOUNT_ERROR>{ data($TOTAL_AMOUNT_ERROR) }</TOTAL_AMOUNT_ERROR>
            }
            {
                for $STATUS_BATCH_DESC in $consultaDetalleLoteResponse/STATUS_DESC
                return
                    <STATUS>{ data($STATUS_BATCH_DESC) }</STATUS>
            }
            {
                for $TRANSACTIONS in $consultaDetalleLoteResponse/TRANSACTIONS
                return
                    <TRANSACTIONS>
                        {
                            for $TRANSACTION in $TRANSACTIONS/TRANSACTION
                            return
                                <TRANSACTION>
                                    {
                                        for $ID in $TRANSACTION/ID
                                        return
                                            <ID>{ data($ID) }</ID>
                                    }
                                    {
                                        for $TXN_REFERENCE in $TRANSACTION/TXN_REFERENCE
                                        return
                                            <TXN_REFERENCE>{ data($TXN_REFERENCE) }</TXN_REFERENCE>
                                    }
                                    {
                                        for $DEBIT_ACCOUNT in $TRANSACTION/DEBIT_ACCOUNT
                                        return
                                            <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                                    }
                                    {
                                        for $CREDIT_ACCOUNT in $TRANSACTION/CREDIT_ACCOUNT
                                        return
                                            <CREDIT_ACCOUNT>{ data($CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
                                    }
                                    {
                                        for $AMOUNT in $TRANSACTION/AMOUNT
                                        return
                                            <AMOUNT>{ data($AMOUNT) }</AMOUNT>
                                    }
                                    {
                                        for $BENEFICIARY in $TRANSACTION/BENEFICIARY
                                        return
                                            <BENEFICIARY>{ data($BENEFICIARY) }</BENEFICIARY>
                                    }
                                    {
                                        for $DOCUMENT_NUMBER in $TRANSACTION/DOCUMENT_NUMBER
                                        return
                                            <DOCUMENT_NUMBER>{ data($DOCUMENT_NUMBER) }</DOCUMENT_NUMBER>
                                    }
                                    {
                                        for $STATUS_DESC in $TRANSACTION/STATUS_DESC
                                        return
                                            <STATUS>{ data($STATUS_DESC) }</STATUS>
                                    }
                                    {
                                        for $ERROR_CODE in $TRANSACTION/ERROR_CODE
                                        return
                                            <ERROR_CODE>{ data($ERROR_CODE) }</ERROR_CODE>
                                    }
                                    {
                                        for $ERROR_MESSAGE in $TRANSACTION/ERROR_MESSAGE
                                        return
                                            <ERROR_MESSAGE>{ data($ERROR_MESSAGE) }</ERROR_MESSAGE>
                                    }
                                </TRANSACTION>
                        }
                    </TRANSACTIONS>
            }
        </ns0:consultaDetalleLoteResponse>
};

declare variable $consultaDetalleLoteResponse as element(ns0:consultaDetalleLoteResponse) external;

xf:consultaDetalleLoteOut($consultaDetalleLoteResponse)