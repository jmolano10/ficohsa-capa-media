(:: pragma bea:global-element-parameter parameter="$consultaMaestroSaldoCuentaResponse" element="ns0:ConsultaMaestroSaldoCuentaResponse" location="../../../BusinessServices/T24/ConsultaMaestroSaldoCuenta/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMaestraSaldoCuentaResponse" location="../xsd/consultaMaestraSaldoCuentaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentaHNOut/";

declare function xf:consultaMaestraSaldoCuentaOut($consultaMaestroSaldoCuentaResponse as element(ns0:ConsultaMaestroSaldoCuentaResponse))
    as element(ns1:consultaMaestraSaldoCuentaResponse) {
        <ns1:consultaMaestraSaldoCuentaResponse>
            {
                for $BALANCESDATE in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/BALANCESDATE
                return
                    <BALANCE_DATE>{ data($BALANCESDATE) }</BALANCE_DATE>
            }
            {
                for $ACCOUNTTITLE in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/ACCOUNTTITLE
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTTITLE) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $AVAILBALANCE in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/AVAILBALANCE
                return
                    <AVAILABLE_BALANCE>{ data($AVAILBALANCE) }</AVAILABLE_BALANCE>
            }
            {
                for $CLEARINGBAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/CLEARINGBAL
                return
                    <CLEARING_BALANCE>{ data($CLEARINGBAL) }</CLEARING_BALANCE>
            }
            {
                for $LOCKEDBALANCE in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/LOCKEDBALANCE
                return
                    <LOCKED_BALANCE>{ data($LOCKEDBALANCE) }</LOCKED_BALANCE>
            }
            {
                for $LOCKEDVISABAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/LOCKEDVISABAL
                return
                    <VISA_FLOATING_BALANCE>{ data($LOCKEDVISABAL) }</VISA_FLOATING_BALANCE>
            }
            {
                for $PDOUTSTANDING in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/PDOUTSTANDING
                return
                    <OVRDF_CLRNG_CA_BALANCE>{ data($PDOUTSTANDING) }</OVRDF_CLRNG_CA_BALANCE>
            }
            {
                for $TOTALAVAILBAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/TOTALAVAILBAL
                return
                    <TOTAL_AVAILABLE_BALANCE>{ data($TOTALAVAILBAL) }</TOTAL_AVAILABLE_BALANCE>
            }
            {
                for $ACTUALBALANCE in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/ACTUALBALANCE
                return
                    <TOTAL_BALANCE>{ data($ACTUALBALANCE) }</TOTAL_BALANCE>
            }
            <CASH_ADVANCE>
                {
                    for $AUTHLIMITCASHADV in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/AUTHLIMITCASHADV
                    return
                        <LIMIT_AMOUNT>{ data($AUTHLIMITCASHADV) }</LIMIT_AMOUNT>
                }
                {
                    for $UTILCASHADVVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/UTILCASHADVVAL
                    return
                        <USED_AMOUNT>{ data($UTILCASHADVVAL) }</USED_AMOUNT>
                }
                {
                    for $AUTHLIMITCASHADV in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/AUTHLIMITCASHADV,
                        $UTILCASHADVVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/UTILCASHADVVAL
                    return
                        <AVAILABLE_AMOUNT>{ fn-bea:format-number(number($AUTHLIMITCASHADV) - number($UTILCASHADVVAL),"###.00") }</AVAILABLE_AMOUNT>
                }
            </CASH_ADVANCE>
            <AUTHORIZED_OVERDRAFT>
                {
                    for $AUTHOVRDFVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/AUTHOVRDFVAL
                    return
                        <LIMIT_AMOUNT>{ data($AUTHOVRDFVAL) }</LIMIT_AMOUNT>
                }
                {
                    for $USEDOVRDFVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/USEDOVRDFVAL
                    return
                        <USED_AMOUNT>{ data($USEDOVRDFVAL) }</USED_AMOUNT>
                }
                {
                    for $AVLOVRDFVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/AVLOVRDFVAL
                    return
                        <AVAILABLE_AMOUNT>{ data($AVLOVRDFVAL) }</AVAILABLE_AMOUNT>
                }
                {
                	for $EXPOVRDFVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/EXPOVRDFVAL
                	return
                		<EXPIRATION_DATE>{ data($EXPOVRDFVAL) }</EXPIRATION_DATE>
                }
            </AUTHORIZED_OVERDRAFT>
            <UNAUTHORIZED_OVERDRAFT>
                {
                    for $UNAUTHOVRDFVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/UNAUTHOVRDFVAL
                    return
                        <USED_AMOUNT>{ data($UNAUTHOVRDFVAL) }</USED_AMOUNT>
                }
            </UNAUTHORIZED_OVERDRAFT>
            <CLEARING_FUNDS>
                {
                    for $ACCTRESVAMT in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/ACCTRESVAMT
                    return
                        <LIMIT_AMOUNT>{ data($ACCTRESVAMT) }</LIMIT_AMOUNT>
                }
                {
                    for $USEDRESVLIMVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/USEDRESVLIMVAL
                    return
                        <USED_AMOUNT>{ data($USEDRESVLIMVAL) }</USED_AMOUNT>
                }
                {
                    for $RESVLIMVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/RESVLIMVAL
                    return
                        <AVAILABLE_AMOUNT>{ data($RESVLIMVAL) }</AVAILABLE_AMOUNT>
                }
                {
                	for $EXPDRESVAL in $consultaMaestroSaldoCuentaResponse/WSFICOACCTDETAILSMASTERType[1]/gWSFICOACCTDETAILSMASTERDetailType/mWSFICOACCTDETAILSMASTERDetailType[1]/EXPDRESVAL
                	return
                		<EXPIRATION_DATE>{ data($EXPDRESVAL) }</EXPIRATION_DATE>
                }
            </CLEARING_FUNDS>
        </ns1:consultaMaestraSaldoCuentaResponse>
};

declare variable $consultaMaestroSaldoCuentaResponse as element(ns0:ConsultaMaestroSaldoCuentaResponse) external;

xf:consultaMaestraSaldoCuentaOut($consultaMaestroSaldoCuentaResponse)