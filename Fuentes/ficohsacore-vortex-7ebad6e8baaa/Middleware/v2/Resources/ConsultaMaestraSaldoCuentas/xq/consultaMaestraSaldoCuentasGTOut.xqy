xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMaestraSaldoCuentaResponse" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/consultaMaestraSaldoCuentasGTOut/";

declare function xf:consultaMaestraSaldoCuentasGTOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaMaestraSaldoCuentaResponse) {
	    <ns1:consultaMaestraSaldoCuentaResponse>
            {
                for $PV_BALANCE_DATE in $outputParameters1/ns0:PV_BALANCE_DATE
                return
                    <BALANCE_DATE>{ data($PV_BALANCE_DATE) }</BALANCE_DATE>
            }
            {
                for $PV_ACCOUNT_NAME in $outputParameters1/ns0:PV_ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($PV_ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $PV_CURRENCY in $outputParameters1/ns0:PV_CURRENCY
                return
                    <CURRENCY>{ data($PV_CURRENCY) }</CURRENCY>
            }
            {
                for $PV_AVAILABLE_BALANCE in $outputParameters1/ns0:PV_AVAILABLE_BALANCE
                return
                    <AVAILABLE_BALANCE>{ data($PV_AVAILABLE_BALANCE) }</AVAILABLE_BALANCE>
            }
            {
                for $PV_CLEARING_BALANCE in $outputParameters1/ns0:PV_CLEARING_BALANCE
                return
                    <CLEARING_BALANCE>{ data($PV_CLEARING_BALANCE) }</CLEARING_BALANCE>
            }
            {
                for $PV_LOCKED_BALANCE in $outputParameters1/ns0:PV_LOCKED_BALANCE
                return
                    <LOCKED_BALANCE>{ data($PV_LOCKED_BALANCE) }</LOCKED_BALANCE>
            }
            {
                for $PV_VISA_FLOATING_BALANCE in $outputParameters1/ns0:PV_VISA_FLOATING_BALANCE
                return
                    <VISA_FLOATING_BALANCE>{ data($PV_VISA_FLOATING_BALANCE) }</VISA_FLOATING_BALANCE>
            }
            {
                for $PV_OVRDF_CLRNG_CA_BALANCE in $outputParameters1/ns0:PV_OVRDF_CLRNG_CA_BALANCE
                return
                    <OVRDF_CLRNG_CA_BALANCE>{ data($PV_OVRDF_CLRNG_CA_BALANCE) }</OVRDF_CLRNG_CA_BALANCE>
            }
            {
                for $PV_TOTAL_AVAILABLE_BALANCE in $outputParameters1/ns0:PV_TOTAL_AVAILABLE_BALANCE
                return
                    <TOTAL_AVAILABLE_BALANCE>{ data($PV_TOTAL_AVAILABLE_BALANCE) }</TOTAL_AVAILABLE_BALANCE>
            }
            {
                for $PV_TOTAL_BALANCE in $outputParameters1/ns0:PV_TOTAL_BALANCE
                return
                    <TOTAL_BALANCE>{ data($PV_TOTAL_BALANCE) }</TOTAL_BALANCE>
            }
            <CASH_ADVANCE>
                {
                    for $PV_CASH_ADVANCE_LIMIT_AMOUNT in $outputParameters1/ns0:PV_CASH_ADVANCE_LIMIT_AMOUNT
                    return
                        <LIMIT_AMOUNT>{ data($PV_CASH_ADVANCE_LIMIT_AMOUNT) }</LIMIT_AMOUNT>
                }
                {
                    for $PV_CASH_ADVANCE_USED_AMOUNT in $outputParameters1/ns0:PV_CASH_ADVANCE_USED_AMOUNT
                    return
                        <USED_AMOUNT>{ data($PV_CASH_ADVANCE_USED_AMOUNT) }</USED_AMOUNT>
                }
                {
                    for $PV_CASH_ADVANCE_AMOUNT in $outputParameters1/ns0:PV_CASH_ADVANCE_AMOUNT
                    return
                        <AVAILABLE_AMOUNT>{ data($PV_CASH_ADVANCE_AMOUNT) }</AVAILABLE_AMOUNT>
                }
            </CASH_ADVANCE>
            <AUTHORIZED_OVERDRAFT>
                {
                    for $PV_AUTHORIZED_OVERDRAFT in $outputParameters1/ns0:PV_AUTHORIZED_OVERDRAFT
                    return
                        <LIMIT_AMOUNT>{ data($PV_AUTHORIZED_OVERDRAFT) }</LIMIT_AMOUNT>
                }
                {
                    for $PV_AUTHORIZED_OD_USED in $outputParameters1/ns0:PV_AUTHORIZED_OD_USED
                    return
                        <USED_AMOUNT>{ data($PV_AUTHORIZED_OD_USED) }</USED_AMOUNT>
                }
                {
                    for $PV_AUTHORIZED_OD_AVAILABLE in $outputParameters1/ns0:PV_AUTHORIZED_OD_AVAILABLE
                    return
                        <AVAILABLE_AMOUNT>{ data($PV_AUTHORIZED_OD_AVAILABLE) }</AVAILABLE_AMOUNT>
                }
                {
                    for $PV_AUTHORIZED_OD_EXP_DATE in $outputParameters1/ns0:PV_AUTHORIZED_OD_EXP_DATE
                    return
                        <EXPIRATION_DATE>{ data($PV_AUTHORIZED_OD_EXP_DATE) }</EXPIRATION_DATE>
                }
            </AUTHORIZED_OVERDRAFT>
            <UNAUTHORIZED_OVERDRAFT>
                {
                    for $PV_UNAUTHORIZED_OVERDRAFT in $outputParameters1/ns0:PV_UNAUTHORIZED_OVERDRAFT
                    return
                        <USED_AMOUNT>{ data($PV_UNAUTHORIZED_OVERDRAFT) }</USED_AMOUNT>
                }
            </UNAUTHORIZED_OVERDRAFT>
            <CLEARING_FUNDS>
                {
                    for $PV_CLEARING_FUNDS_LIMIT in $outputParameters1/ns0:PV_CLEARING_FUNDS_LIMIT
                    return
                        <LIMIT_AMOUNT>{ data($PV_CLEARING_FUNDS_LIMIT) }</LIMIT_AMOUNT>
                }
                {
                    for $PV_CLEARING_FUNDS_USED in $outputParameters1/ns0:PV_CLEARING_FUNDS_USED
                    return
                        <USED_AMOUNT>{ data($PV_CLEARING_FUNDS_USED) }</USED_AMOUNT>
                }
                {
                    for $PV_CLEARING_FUNDS_AVAILABLE in $outputParameters1/ns0:PV_CLEARING_FUNDS_AVAILABLE
                    return
                        <AVAILABLE_AMOUNT>{ data($PV_CLEARING_FUNDS_AVAILABLE) }</AVAILABLE_AMOUNT>
                }
                <EXPIRATION_DATE></EXPIRATION_DATE>
            </CLEARING_FUNDS>
        </ns1:consultaMaestraSaldoCuentaResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaMaestraSaldoCuentasGTOut($outputParameters1)