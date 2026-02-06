xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadecertifdepositoResponse1" element="ns0:ConsultadecertifdepositoResponse" location="../Resources/XMLSchema_1178015080.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCertificadoDepositoResponse" location="consultaCertificadoDepositoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCertificadoDepositoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCertificadoDeposito/consultaCertificadoDeposito/consultaCertificadoDepositoOut/";

declare function xf:consultaCertificadoDepositoOut($consultadecertifdepositoResponse1 as element(ns0:ConsultadecertifdepositoResponse))
    as element(ns1:consultaCertificadoDepositoResponse) {
        <ns1:consultaCertificadoDepositoResponse>
            <ns1:consultaCertificadoDepositoResponseType>
                <ns1:consultaCertificadoDepositoResponseRecordType>
                    {
                        for $DEPOSITNAME in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/DEPOSITNAME
                        return
                            <DEPOSIT_NAME>{ data($DEPOSITNAME) }</DEPOSIT_NAME>
                    }
                    {
                        for $PRODUCT in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/PRODUCT
                        return
                            <DEPOSIT_TYPE>{ data($PRODUCT) }</DEPOSIT_TYPE>
                    }
                    {
                        for $VALUEDATE in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/VALUEDATE
                        return
                            <EFFECTIVE_DATE>{ data($VALUEDATE) }</EFFECTIVE_DATE>
                    }
                    {
                        for $MATURITYDATE in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/MATURITYDATE
                        return
                            <MATURITY_DATE>{ data($MATURITYDATE) }</MATURITY_DATE>
                    }
                    {
                        for $DEPOSITTERM in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/DEPOSITTERM
                        return
                            <DEPOSIT_TERM>{ data($DEPOSITTERM) }</DEPOSIT_TERM>
                    }
                    {
                        for $INTERESTRATE in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/INTERESTRATE
                        return
                            <INTEREST_RATE>{ data($INTERESTRATE) }</INTEREST_RATE>
                    }
                    {
                        for $PRINCIPAL in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/PRINCIPAL
                        return
                            <PRINCIPAL_AMOUNT>{ data($PRINCIPAL) }</PRINCIPAL_AMOUNT>
                    }
                    {
                        for $INTERESTEARNED in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/INTERESTEARNED
                        return
                            <INTEREST_AMOUNT>{ data($INTERESTEARNED) }</INTEREST_AMOUNT>
                    }
                    {
                        for $LOCKEDYN in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/LOCKEDYN
                        return
                            <LOCKED_YES_NO>{ data($LOCKEDYN) }</LOCKED_YES_NO>
                    }
                    {
                        for $CURRENCY in $consultadecertifdepositoResponse1/WSAZACCOUNTDEPType[1]/gWSAZACCOUNTDEPDetailType/mWSAZACCOUNTDEPDetailType[1]/CURRENCY
                        return
                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
                    }
                </ns1:consultaCertificadoDepositoResponseRecordType>
            </ns1:consultaCertificadoDepositoResponseType>
        </ns1:consultaCertificadoDepositoResponse>
};

declare variable $consultadecertifdepositoResponse1 as element(ns0:ConsultadecertifdepositoResponse) external;

xf:consultaCertificadoDepositoOut($consultadecertifdepositoResponse1)