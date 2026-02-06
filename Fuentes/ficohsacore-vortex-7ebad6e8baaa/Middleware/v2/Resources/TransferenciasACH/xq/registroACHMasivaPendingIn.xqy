xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TransferenciasACH/svcRegistroACHMasivasPending/xsd/registarACHMasivasPending_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registarACHMasivasPending";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/registroACHMasivaPendingIn/";

declare function xf:registroACHMasivaPendingIn($transferenciasACHRequest as element(ns0:transferenciasACHRequest),
    $transactionId as xs:string,
    $mensajeRechazo as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_TRANSACTION_ID>{ $transactionId }</ns1:PV_TRANSACTION_ID>
            <ns1:PV_DEBIT_ACCOUNT>{ data($transferenciasACHRequest/DEBIT_ACCOUNT) }</ns1:PV_DEBIT_ACCOUNT>
            <ns1:PV_DESTINATION_BANK>{ data($transferenciasACHRequest/DESTINATION_BANK) }</ns1:PV_DESTINATION_BANK>
            <ns1:PV_CREDIT_ACCOUNT>{ data($transferenciasACHRequest/CREDIT_ACCOUNT) }</ns1:PV_CREDIT_ACCOUNT>
            <ns1:PV_CREDIT_CURRENCY>{ data($transferenciasACHRequest/CREDIT_CURRENCY) }</ns1:PV_CREDIT_CURRENCY>
            <ns1:PV_BENEFICIARY_NAME>{ data($transferenciasACHRequest/BENEFICIARY_NAME) }</ns1:PV_BENEFICIARY_NAME>
            <ns1:PV_TRANSFER_AMOUNT>{ data($transferenciasACHRequest/TRANSFER_AMOUNT) }</ns1:PV_TRANSFER_AMOUNT>
            <ns1:PV_TRANSACTION_DESCRIPTION>{ data($transferenciasACHRequest/TRANSACTION_DESCRIPTION) }</ns1:PV_TRANSACTION_DESCRIPTION>
            <ns1:PV_LOCAL_ACCOUNT_TYPE>{ data($transferenciasACHRequest/LOCAL_ACCOUNT_TYPE) }</ns1:PV_LOCAL_ACCOUNT_TYPE>
            <ns1:PV_LOCAL_ORIGINAL_ACCOUNT>{ data($transferenciasACHRequest/LOCAL_ORIGINAL_ACCOUNT) }</ns1:PV_LOCAL_ORIGINAL_ACCOUNT>
            <ns1:PV_MENSAJE_RECHAZO>{ $mensajeRechazo }</ns1:PV_MENSAJE_RECHAZO>
            <ns1:PV_REF_SECUENCIA_PROG>{ data($transferenciasACHRequest/INTERFACE_REFERENCE_NO) }</ns1:PV_REF_SECUENCIA_PROG>
        </ns1:InputParameters>
};

declare variable $transferenciasACHRequest as element(ns0:transferenciasACHRequest) external;
declare variable $transactionId as xs:string external;
declare variable $mensajeRechazo as xs:string external;

xf:registroACHMasivaPendingIn($transferenciasACHRequest,
    $transactionId,
    $mensajeRechazo)