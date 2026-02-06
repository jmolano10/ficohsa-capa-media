xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagosMasivos" element="ns0:pagosMasivos" location="../xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:pagosMasivos" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/pagosMasivosInternoIn/";

declare function xf:pagosMasivosInternoIn($pagosMasivos as element(ns0:pagosMasivos))
    as element(ns0:pagosMasivos) {
        <ns0:pagosMasivos>
            <GLOBAL_ID>{ data($pagosMasivos/GLOBAL_ID) }</GLOBAL_ID>
            <CUSTOMER_ID>{ data($pagosMasivos/CUSTOMER_ID) }</CUSTOMER_ID>
            <USERNAME>{ data($pagosMasivos/USERNAME) }</USERNAME>
            {
                for $BATCHES in $pagosMasivos/BATCHES
                return
                    <BATCHES>
                        {
                            for $BATCH in $BATCHES/BATCH
                            return
                                <BATCH>
                                    <CUSTOMER_BATCH_ID>{ data($BATCH/CUSTOMER_BATCH_ID) }</CUSTOMER_BATCH_ID>
                                    <TYPE>{ data($BATCH/TYPE) }</TYPE>
                                    {
                                    	for $APPLICATION_DATE in $BATCH/APPLICATION_DATE
                                    	return
                                    		<APPLICATION_DATE>{ xs:date($APPLICATION_DATE) cast as xs:dateTime }</APPLICATION_DATE>
                                    }                                    
                                    {
                                        for $DATA_STRUCTURE in $BATCH/DATA_STRUCTURE
                                        return
                                            <DATA_STRUCTURE>
                                                {
                                                    for $VALIDATIONS in $DATA_STRUCTURE/VALIDATIONS
                                                    return
                                                        <VALIDATIONS>
                                                            <DEBIT_ACCT_BALANCE>{ data($VALIDATIONS/DEBIT_ACCT_BALANCE) }</DEBIT_ACCT_BALANCE>
                                                            <DEBIT_ACCT_STATUS>{ data($VALIDATIONS/DEBIT_ACCT_STATUS) }</DEBIT_ACCT_STATUS>
                                                            <NUMBER_OF_TRANSACTIONS>{ data($VALIDATIONS/NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
                                                            <TOTAL_AMOUNT>{ data($VALIDATIONS/TOTAL_AMOUNT) }</TOTAL_AMOUNT>
                                                        </VALIDATIONS>
                                                }
                                                {
                                                    for $FIELDS in $DATA_STRUCTURE/FIELDS
                                                    return
                                                        <FIELDS>
                                                            {
                                                                for $FIELD in $FIELDS/FIELD
                                                                return
                                                                    <FIELD>{ data($FIELD) }</FIELD>
                                                            }
                                                        </FIELDS>
                                                }
                                                <DELIMITER>{ data($DATA_STRUCTURE/DELIMITER) }</DELIMITER>
                                            </DATA_STRUCTURE>
                                    }
                                    {
                                        for $TRANSACTIONS in $BATCH/TRANSACTIONS
                                        return
                                            <TRANSACTIONS>
                                                {
                                                    for $TRANSACTION in $TRANSACTIONS/TRANSACTION
                                                    return
                                                        <TRANSACTION>{ data($TRANSACTION) }</TRANSACTION>
                                                }
                                            </TRANSACTIONS>
                                    }
                                </BATCH>
                        }
                    </BATCHES>
            }
        </ns0:pagosMasivos>
};

declare variable $pagosMasivos as element(ns0:pagosMasivos) external;

xf:pagosMasivosInternoIn($pagosMasivos)