xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagosMasivos" element="ns1:pagosMasivos" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns2:sjPagosMasivosInterno" location="../../../BusinessServices/SJS/pagosMasivosInterno/xsd/sjPagosMasivosInterno.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/sjPagosMasivosInterno";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagosMasivosInterno/xq/sjPagosMasivosInternoIn/";

declare function xf:sjPagosMasivosInternoIn($pagosMasivos as element(ns1:pagosMasivos),
    $requestHeader as element(ns0:RequestHeader))
    as element(ns2:sjPagosMasivosInterno) {
        <ns2:sjPagosMasivosInterno>
            <USERNAME_HEADER>{ data($requestHeader/Authentication/UserName) }</USERNAME_HEADER>
            <PASSWORD_HEADER>{ data($requestHeader/Authentication/Password) }</PASSWORD_HEADER>
            <GLOBAL_ID>{ data($pagosMasivos/GLOBAL_ID) }</GLOBAL_ID>
            <CUSTOMER_ID>{ data($pagosMasivos/CUSTOMER_ID) }</CUSTOMER_ID>
            <USERNAME>{ data($pagosMasivos/USERNAME) }</USERNAME>
            <BATCHES>
                {
                    for $BATCH in $pagosMasivos/BATCHES/BATCH
                    return
                        <BATCH>
                            <CUSTOMER_BATCH_ID>{ data($BATCH/CUSTOMER_BATCH_ID) }</CUSTOMER_BATCH_ID>
                            <TYPE>{ data($BATCH/TYPE) }</TYPE>
                            <APPLICATION_DATE>{ data($BATCH/APPLICATION_DATE) }</APPLICATION_DATE>
                            <DATA_STRUCTURE>
                                <VALIDATIONS>
                                    <DEBIT_ACCT_BALANCE>{ data($BATCH/DATA_STRUCTURE/VALIDATIONS/DEBIT_ACCT_BALANCE) }</DEBIT_ACCT_BALANCE>
                                    <DEBIT_ACCT_STATUS>{ data($BATCH/DATA_STRUCTURE/VALIDATIONS/DEBIT_ACCT_STATUS) }</DEBIT_ACCT_STATUS>
                                    <NUMBER_OF_TRANSACTIONS>{ data($BATCH/DATA_STRUCTURE/VALIDATIONS/NUMBER_OF_TRANSACTIONS) }</NUMBER_OF_TRANSACTIONS>
                                    <TOTAL_AMOUNT>{ data($BATCH/DATA_STRUCTURE/VALIDATIONS/TOTAL_AMOUNT) }</TOTAL_AMOUNT>
                                </VALIDATIONS>
                                <FIELDS>
                                    {
                                        for $FIELD in $BATCH/DATA_STRUCTURE/FIELDS/FIELD
                                        return
                                            <FIELD>{ data($FIELD) }</FIELD>
                                    }
                                </FIELDS>
                                <DELIMITER>{ data($BATCH/DATA_STRUCTURE/DELIMITER) }</DELIMITER>
                            </DATA_STRUCTURE>
                            <TRANSACTIONS>
                                {
                                    for $TRANSACTION in $BATCH/TRANSACTIONS/TRANSACTION
                                    return
                                        <TRANSACTION>{ data($TRANSACTION) }</TRANSACTION>
                                }
                            </TRANSACTIONS>
                        </BATCH>
                }
            </BATCHES>
        </ns2:sjPagosMasivosInterno>
};

declare variable $pagosMasivos as element(ns1:pagosMasivos) external;
declare variable $requestHeader as element(ns0:RequestHeader) external;

xf:sjPagosMasivosInternoIn($pagosMasivos,
    $requestHeader)