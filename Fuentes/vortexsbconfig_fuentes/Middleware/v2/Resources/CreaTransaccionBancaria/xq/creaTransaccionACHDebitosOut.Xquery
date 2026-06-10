<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$transferenciasACHDebitosResponse1" element="ns0:transferenciasACHDebitosResponse" location="../../TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaTransaccionBancariaResponse" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHDebitosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionACHDebitosOut/";

declare function xf:creaTransaccionACHDebitosOut($transferenciasACHDebitosResponse1 as element(ns0:transferenciasACHDebitosResponse))
    as element(ns1:creaTransaccionBancariaResponse) {
        <ns1:creaTransaccionBancariaResponse>
            {
                for $ACCOUNT in $transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/ORIGINATOR_INFO/ACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($ACCOUNT) }</DEBIT_ACCOUNT>
            }
            <CREDIT_ACCOUNT>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/DESTINATION) }</CREDIT_ACCOUNT>
            <DEBIT_CURRENCY>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</DEBIT_CURRENCY>
            <CREDIT_CURRENCY>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/CURRENCY) }</CREDIT_CURRENCY>
            <DEBIT_AMOUNT>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</DEBIT_AMOUNT>
            <CREDIT_AMOUNT>{ data($transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/AMOUNT) }</CREDIT_AMOUNT>
            {
                for $TRANSACTION_ID in $transferenciasACHDebitosResponse1/TRANSACTION_DETAILS/TRANSACTION_DETAIL[1]/TRANSACTION_RESULT/TRANSACTION_ID
                return
                    <TRANSACTION_ID>{ data($TRANSACTION_ID) }</TRANSACTION_ID>
            }
        </ns1:creaTransaccionBancariaResponse>
};

declare variable $transferenciasACHDebitosResponse1 as element(ns0:transferenciasACHDebitosResponse) external;

xf:creaTransaccionACHDebitosOut($transferenciasACHDebitosResponse1)]]></con:xquery>
    <con:dependency location="../../TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/TransferenciasACHDebitos/xsd/transferenciasACHDebitosTypes"/>
    </con:dependency>
    <con:dependency location="../../OperacionesACH/xsd/operacionesACHTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/OperacionesACH/xsd/operacionesACHTypes"/>
    </con:dependency>
</con:xqueryEntry>