(:: pragma bea:global-element-parameter parameter="$loanQuery" element="ns1:loanQuery" location="../../xsd/LoanOperationsTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../../BusinessServices/AbanksGT/ConsPrestamo/xsd/MCConsPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsPrestamo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/loanOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/LoanOperations/LoanQuery/xq/mcConsPrestamoGTIn/";

declare function xf:mcConsPrestamoGTIn($loanQuery as element(ns1:loanQuery))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_LOAN_NUMBER>{ data($loanQuery/ns1:LOAN_NUMBER) }</ns0:PV_LOAN_NUMBER>
        </ns0:InputParameters>
};

declare variable $loanQuery as element(ns1:loanQuery) external;

xf:mcConsPrestamoGTIn($loanQuery)
