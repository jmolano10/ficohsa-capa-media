xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creatransaccionACHResponse1" element="ns0:CreatransaccionACHResponse" location="../../../BusinessServices/T24/CreaTransaccionBancariaACH/xsd/creaTransaccionBancariaACH.xsd" ::)
(:: pragma bea:global-element-return element="ns1:creaTransaccionBancariaResponse" location="../../OperacionesACH/xsd/operacionesACHTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesACHTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaTransaccionBancaria/xq/creaTransaccionBancariaOut/";

declare function xf:creaTransaccionBancariaOut($creatransaccionACHResponse1 as element(ns0:CreatransaccionACHResponse))
    as element(ns1:creaTransaccionBancariaResponse) {
        <ns1:creaTransaccionBancariaResponse>
            {
                for $DEBITACCTNO in $creatransaccionACHResponse1/FICOHNACHONLINEType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITACCTNO in $creatransaccionACHResponse1/FICOHNACHONLINEType/CREDITACCTNO
                return
                    <CREDIT_ACCOUNT>{ data($CREDITACCTNO) }</CREDIT_ACCOUNT>
            }
            {
                for $CUSTOMERID in $creatransaccionACHResponse1/FICOHNACHONLINEType/CUSTOMERID
                return
                    <DEBIT_CUSTOMER>{ data($CUSTOMERID) }</DEBIT_CUSTOMER>
            }
            {
                for $CREDITCCY in $creatransaccionACHResponse1/FICOHNACHONLINEType/CREDITCCY
                return
                    <CREDIT_CURRENCY>{ data($CREDITCCY) }</CREDIT_CURRENCY>
            }
            {
                for $AMOUNT in $creatransaccionACHResponse1/FICOHNACHONLINEType/AMOUNT
                return
                    <DEBIT_AMOUNT>{ data($AMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $AMOUNT in $creatransaccionACHResponse1/FICOHNACHONLINEType/AMOUNT
                return
                    <CREDIT_AMOUNT>{ data($AMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $IDTXNT24 in $creatransaccionACHResponse1/FICOHNACHONLINEType/IDTXNT24
                return
                    <ID_TRN>{ data($IDTXNT24) }</ID_TRN>
            }
        </ns1:creaTransaccionBancariaResponse>
};

declare variable $creatransaccionACHResponse1 as element(ns0:CreatransaccionACHResponse) external;

xf:creaTransaccionBancariaOut($creatransaccionACHResponse1)