(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaCertificadoDeposito/xsd/ConsultaCertificadoDeposito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCertificadoDepositoResponse" location="../../../../Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaCertificadoDeposito";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaCertificadoDeposito/xq/consultaCertificadoDepositoOut/";

declare function xf:consultaCertificadoDepositoOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaCertificadoDepositoResponse) {
        <ns1:consultaCertificadoDepositoResponse>
            <ns1:consultaCertificadoDepositoResponseType>
                {
                    let $OutputParameters := $outputParameters1
                    return
                        <ns1:consultaCertificadoDepositoResponseRecordType>
                            {
                                for $DEPOSIT_NAME in $OutputParameters/ns0:DEPOSIT_NAME
                                return
                                    <DEPOSIT_NAME>{ data($DEPOSIT_NAME) }</DEPOSIT_NAME>
                            }
                            {
                                for $DEPOSIT_TYPE in $OutputParameters/ns0:DEPOSIT_TYPE
                                return
                                    <DEPOSIT_TYPE>{ data($DEPOSIT_TYPE) }</DEPOSIT_TYPE>
                            }
                            {
                                for $EFFECTIVE_DATE in $OutputParameters/ns0:EFFECTIVE_DATE
                                return
                                    <EFFECTIVE_DATE>{ data($EFFECTIVE_DATE) }</EFFECTIVE_DATE>
                            }
                            {
                                for $MATURITY_DATE in $OutputParameters/ns0:MATURITY_DATE
                                return
                                    <MATURITY_DATE>{ data($MATURITY_DATE) }</MATURITY_DATE>
                            }
                            {
                                for $DEPOSIT_TERM in $OutputParameters/ns0:DEPOSIT_TERM
                                return
                                    <DEPOSIT_TERM>{ data($DEPOSIT_TERM) }</DEPOSIT_TERM>
                            }
                            {
                                for $INTEREST_RATE in $OutputParameters/ns0:INTEREST_RATE
                                return
                                    <INTEREST_RATE>{ data($INTEREST_RATE) }</INTEREST_RATE>
                            }
                            {
                                for $PRINCIPAL_AMOUNT in $OutputParameters/ns0:PRINCIPAL_AMOUNT
                                return
                                    <PRINCIPAL_AMOUNT>{ data($PRINCIPAL_AMOUNT) }</PRINCIPAL_AMOUNT>
                            }
                            {
                                for $INTEREST_AMOUNT in $OutputParameters/ns0:INTEREST_AMOUNT
                                return
                                    <INTEREST_AMOUNT>{ data($INTEREST_AMOUNT) }</INTEREST_AMOUNT>
                            }
                            {
                                for $LOCKED_YES_NO in $OutputParameters/ns0:LOCKED_YES_NO
                                return
                                    <LOCKED_YES_NO>{ data($LOCKED_YES_NO) }</LOCKED_YES_NO>
                            }
                            {
                                for $CURRENCY in $OutputParameters/ns0:CURRENCY
                                return
                                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                            }
                        </ns1:consultaCertificadoDepositoResponseRecordType>
                }
            </ns1:consultaCertificadoDepositoResponseType>
        </ns1:consultaCertificadoDepositoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaCertificadoDepositoOut($outputParameters1)