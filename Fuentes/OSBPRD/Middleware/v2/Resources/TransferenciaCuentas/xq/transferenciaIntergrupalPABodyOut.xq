(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/transferenciaIntergrupal/xsd/transferenciaIntergrupal_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:transferenciaCuentasResponse" location="../xsd/transferenciaCuentasType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/transferenciasType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transferenciaIntergrupal";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentas/xq/transferenciaIntergrupalPABodyOut/";

declare function xf:transferenciaIntergrupalPABodyOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:transferenciaCuentasResponse) {
        <ns1:transferenciaCuentasResponse>
            {
                for $PV_DEBITACCOUNT in $outputParameters/ns0:PV_DEBITACCOUNT
                return
                    <DEBIT_ACCOUNT>{ data($PV_DEBITACCOUNT) }</DEBIT_ACCOUNT>
            }
            {
                for $PV_CREDITACCOUNT in $outputParameters/ns0:PV_CREDITACCOUNT
                return
                    <CREDIT_ACCOUNT>{ data($PV_CREDITACCOUNT) }</CREDIT_ACCOUNT>
            }
            {
                for $PV_DEBITCUSTOMER in $outputParameters/ns0:PV_DEBITCUSTOMER
                return
                    <DEBIT_CUSTOMER>{ data($PV_DEBITCUSTOMER) }</DEBIT_CUSTOMER>
            }
            {
                for $PV_CREDITCUSTOMER in $outputParameters/ns0:PV_CREDITCUSTOMER
                return
                    <CREDIT_CUSTOMER>{ data($PV_CREDITCUSTOMER) }</CREDIT_CUSTOMER>
            }
            {
                for $PV_DEBITCURRENCY in $outputParameters/ns0:PV_DEBITCURRENCY
                return
                    <DEBIT_CURRENCY>{ data($PV_DEBITCURRENCY) }</DEBIT_CURRENCY>
            }
            {
                for $PV_CREDITCURRENCY in $outputParameters/ns0:PV_CREDITCURRENCY
                return
                    <CREDIT_CURRENCY>{ data($PV_CREDITCURRENCY) }</CREDIT_CURRENCY>
            }
            {
                for $PV_DEBITAMOUNT in $outputParameters/ns0:PV_DEBITAMOUNT
                return
                    <DEBIT_AMOUNT>{ data($PV_DEBITAMOUNT) }</DEBIT_AMOUNT>
            }
            {
                for $PV_CREDITAMOUNT in $outputParameters/ns0:PV_CREDITAMOUNT
                return
                    <CREDIT_AMOUNT>{ data($PV_CREDITAMOUNT) }</CREDIT_AMOUNT>
            }
            {
                for $PV_TRANSFERDETAILS in $outputParameters/ns0:PV_TRANSFERDETAILS
                return
                    <TRANSFER_DETAILS>{ data($PV_TRANSFERDETAILS) }</TRANSFER_DETAILS>
            }
            {
                for $PV_EXCHANGERATE in $outputParameters/ns0:PV_EXCHANGERATE
                return
                    <EXCHANGE_RATE>{ data($PV_EXCHANGERATE) }</EXCHANGE_RATE>
            }
            {
                for $PV_VALUEDATE in $outputParameters/ns0:PV_VALUEDATE
                return
                    <DATE_TIME>{ data($PV_VALUEDATE) }</DATE_TIME>
            }
            {
                for $PV_COMISION in $outputParameters/ns0:PV_COMISION
                return
                    <COMMISSION>{ data($PV_COMISION) }</COMMISSION>
            }
        </ns1:transferenciaCuentasResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:transferenciaIntergrupalPABodyOut($outputParameters)