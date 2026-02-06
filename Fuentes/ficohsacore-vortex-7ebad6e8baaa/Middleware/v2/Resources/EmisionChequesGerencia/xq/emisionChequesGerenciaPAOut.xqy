xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/emisionChequesGerencia/xsd/emisionChequesGerencia_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:emisionChequesGerenciaResponse" location="../../../../Business_Resources/emisionChequesGerencia/emisionChequesGerenciaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/emisionChequesGerencia";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EmisionChequesGerencia/xq/emisionChequesGerenciaPAOut/";

declare function xf:emisionChequesGerenciaPAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:emisionChequesGerenciaResponse) {
        <ns1:emisionChequesGerenciaResponse>
            {
                for $DEBIT_ACCOUNT in $outputParameters/ns0:DEBIT_ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $CHEQUE_AMOUNT in $outputParameters/ns0:CHEQUE_AMOUNT
                return
                    <CHEQUE_AMOUNT>{ data($CHEQUE_AMOUNT) }</CHEQUE_AMOUNT>
            }
            {
                for $BENEFICIARY_NAME in $outputParameters/ns0:BENEFICIARY_NAME
                return
                    <BENEFICIARY_NAME>{ data($BENEFICIARY_NAME) }</BENEFICIARY_NAME>
            }
            {
                for $CHEQUE_NUMBER in $outputParameters/ns0:CHEQUE_NUMBER
                return
                    <CHEQUE_NUMBER>{ data($CHEQUE_NUMBER) }</CHEQUE_NUMBER>
            }
        </ns1:emisionChequesGerenciaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:emisionChequesGerenciaPAOut($outputParameters)