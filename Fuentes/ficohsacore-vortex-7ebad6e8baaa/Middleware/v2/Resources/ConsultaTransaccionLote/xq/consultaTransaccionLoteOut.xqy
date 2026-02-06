xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PMSV/consultaTransaccionLote/xsd/consultaTransaccionLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaTransaccionLoteResponse" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTransaccionLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTransaccionLote/xq/consultaTransaccionLoteOut/";

declare function xf:consultaTransaccionLoteOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaTransaccionLoteResponse) {
        <ns1:consultaTransaccionLoteResponse>
            <CUSTOMER_ID>{ data($outputParameters/ns0:CUSTOMER_ID) }</CUSTOMER_ID>
            <TRANSACTION>
                <ID>{ data($outputParameters/ns0:TXN_ID) }</ID>
                {
                    for $TXN_REFERENCE in $outputParameters/ns0:TXN_REFERENCE
                    return
                        <TXN_REFERENCE>{ data($TXN_REFERENCE) }</TXN_REFERENCE>
                }
                <BANK_BATCH_ID>{ data($outputParameters/ns0:BANK_BATCH_ID) }</BANK_BATCH_ID>
                <DEBIT_ACCOUNT>{ data($outputParameters/ns0:DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
                <CREDIT_ACCOUNT>{ data($outputParameters/ns0:CREDIT_ACCOUNT) }</CREDIT_ACCOUNT>
                <AMOUNT>{ data($outputParameters/ns0:AMOUNT) }</AMOUNT>
            </TRANSACTION>
        </ns1:consultaTransaccionLoteResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaTransaccionLoteOut($outputParameters)