(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../BusinessServices/AbanksGT/ConsPrestamo/xsd/MCConsPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:loanQueryResponse" location="../../xsd/LoanOperationsTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MCConsPrestamo";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/loanTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/loanOperationsTypes";
declare namespace xf = "http://tempuri.org/MWCaja/v1/Resources/LoanOperations/LoanQuery/xq/loanQueryGTOut/";

declare function xf:loanQueryGTOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:loanQueryResponse) {
        <ns1:loanQueryResponse>
            {
                for $PN_CUSTOMER_ID in $outputParameters/ns0:PN_CUSTOMER_ID
                return
                    <ns1:CUSTOMER_ID>{ xs:integer(data($PN_CUSTOMER_ID)) }</ns1:CUSTOMER_ID>
            }
            {
                for $PV_LOAN_NUMBER in $outputParameters/ns0:PV_LOAN_NUMBER
                return
                    <ns1:LOAN_NUMBER>{ data($PV_LOAN_NUMBER) }</ns1:LOAN_NUMBER>
            }
            {
                for $PV_NAME in $outputParameters/ns0:PV_NAME
                return
                    <ns1:NAME>{ data($PV_NAME) }</ns1:NAME>
            }
            {
                for $PV_CURRENCY in $outputParameters/ns0:PV_CURRENCY
                return
                    <ns1:CURRENCY>{ data($PV_CURRENCY) }</ns1:CURRENCY>
            }
            {
                for $PN_REQUIRED_AMOUNT in $outputParameters/ns0:PN_REQUIRED_AMOUNT
                return
                    <ns1:REQUIRED_AMOUNT>{ data($PN_REQUIRED_AMOUNT) }</ns1:REQUIRED_AMOUNT>
            }
            {
                for $PN_DUE_AMOUNT in $outputParameters/ns0:PN_DUE_AMOUNT
                return
                    <ns1:DUE_AMOUNT>{ data($PN_DUE_AMOUNT) }</ns1:DUE_AMOUNT>
            }
            {
                for $PT_INSTALLMENTS in $outputParameters/ns0:PT_INSTALLMENTS
                return
                    <ns1:INSTALLMENTS>
                        {
                            for $PT_INSTALLMENTS_ITEM in $PT_INSTALLMENTS/ns0:PT_INSTALLMENTS_ITEM
                            return
                                <ns2:INSTALLMENT>
                                    {
                                        for $ID in $PT_INSTALLMENTS_ITEM/ns0:ID
                                        return
                                            <ns2:ID>{ xs:integer(data($ID)) }</ns2:ID>
                                    }
                                    <ns2:TOTAL_AMOUNT>{ data($PT_INSTALLMENTS_ITEM/ns0:TOTAL_AMOUNT) }</ns2:TOTAL_AMOUNT>
                                    {
                                        for $MATURITY_DATE in $PT_INSTALLMENTS_ITEM/ns0:MATURITY_DATE
                                        return
                                            <ns2:MATURITY_DATE>{ data($MATURITY_DATE) }</ns2:MATURITY_DATE>
                                    }
                                    <ns2:PAST_DUE>{ data($PT_INSTALLMENTS_ITEM/ns0:PAST_DUE) }</ns2:PAST_DUE>
                                    {
                                        let $BALANCE := $PT_INSTALLMENTS_ITEM/ns0:BALANCE
                                        return
                                            <ns2:BALANCES>
                                                {
                                                    for $BALANCE_ITEM in $BALANCE/ns0:BALANCE_ITEM
                                                    return
                                                        <ns2:BALANCE>
                                                            <ns2:TYPE>{ data($BALANCE_ITEM/ns0:TYPE) }</ns2:TYPE>
                                                            <ns2:AMOUNT>{ data($BALANCE_ITEM/ns0:AMOUNT) }</ns2:AMOUNT>
                                                        </ns2:BALANCE>
                                                }
                                            </ns2:BALANCES>
                                    }
                                </ns2:INSTALLMENT>
                        }
                    </ns1:INSTALLMENTS>
            }
        </ns1:loanQueryResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:loanQueryGTOut($outputParameters)
