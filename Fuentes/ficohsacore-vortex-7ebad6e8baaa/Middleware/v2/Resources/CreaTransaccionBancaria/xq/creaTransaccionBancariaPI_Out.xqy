xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creatransaccionACHPIResponse1" element="ns0:CreatransaccionACHPIResponse" location="../../../BusinessServices/T24/CreaTransaccionBancariaACH/xsd/creaTransaccionBancariaACH.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaTransaccionBancariaResponse" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionBancariaPI_Out/";

declare function xf:creaTransaccionBancariaPI_Out($creatransaccionACHPIResponse1 as element(ns0:CreatransaccionACHPIResponse))
    as element(ns1:creaTransaccionBancariaResponse) {
        <ns1:creaTransaccionBancariaResponse>
            {
                for $DEBITACCTNO in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $CUSTOMERID in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/CUSTOMERID
                return
                    <DEBIT_CUSTOMER>{ data($CUSTOMERID) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCCY in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/CREDITCCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNT in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/AMOUNT
                return
                    <DEBIT_AMOUNT>{ data($AMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $AMOUNT in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/AMOUNT
                return
                    <CREDIT_AMOUNT>{ data($AMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $transactionId in $creatransaccionACHPIResponse1/Status/transactionId
                return
                    <TRANSACTION_ID>{ data($transactionId) }</TRANSACTION_ID>
            }
            {
                for $IDTXNT24 in $creatransaccionACHPIResponse1/FICOHNPIONLINEType/IDTXNT24
                return
                    <ID_TRN>{ data($IDTXNT24) }</ID_TRN>
            }
        </ns1:creaTransaccionBancariaResponse>
};

declare variable $creatransaccionACHPIResponse1 as element(ns0:CreatransaccionACHPIResponse) external;

xf:creaTransaccionBancariaPI_Out($creatransaccionACHPIResponse1)