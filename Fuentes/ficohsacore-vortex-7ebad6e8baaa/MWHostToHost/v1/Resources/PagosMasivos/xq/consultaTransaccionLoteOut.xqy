xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTransaccionLoteResponse" element="ns0:consultaTransaccionLoteResponse" location="../../../../../Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTransaccionLoteResponse" location="../xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/PagosMasivos/xq/consultaTransaccionLoteOut/";

declare function xf:consultaTransaccionLoteOut($consultaTransaccionLoteResponse as element(ns0:consultaTransaccionLoteResponse))
    as element(ns0:consultaTransaccionLoteResponse) {
        <ns0:consultaTransaccionLoteResponse>
            {
                for $CUSTOMER_ID in $consultaTransaccionLoteResponse/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            {
                for $TRANSACTION in $consultaTransaccionLoteResponse/TRANSACTION
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
                            for $BANK_BATCH_ID in $TRANSACTION/BANK_BATCH_ID
                            return
                                <BANK_BATCH_ID>{ data($BANK_BATCH_ID) }</BANK_BATCH_ID>
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
                    </TRANSACTION>
            }
        </ns0:consultaTransaccionLoteResponse>
};

declare variable $consultaTransaccionLoteResponse as element(ns0:consultaTransaccionLoteResponse) external;

xf:consultaTransaccionLoteOut($consultaTransaccionLoteResponse)