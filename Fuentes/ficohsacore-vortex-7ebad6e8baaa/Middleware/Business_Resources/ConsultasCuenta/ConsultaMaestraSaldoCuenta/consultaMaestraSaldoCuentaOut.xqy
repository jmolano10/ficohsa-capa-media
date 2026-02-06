xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadesaldodecuentaResponse" element="ns0:ConsultadesaldodecuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaMaestraSaldoCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaMaestraSaldoCuenta/consultaMaestraSaldoCuentaOut/";

declare function xf:consultaMaestraSaldoCuentaOut($consultadesaldodecuentaResponse as element(ns0:ConsultadesaldodecuentaResponse))
    as element(ns1:consultaMaestraSaldoCuentaResponse) {
        <ns1:consultaMaestraSaldoCuentaResponse>
            {
                for $BALANCESDATE in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/BALANCESDATE
                return
                    <BALANCE_DATE>{ data($BALANCESDATE) }</BALANCE_DATE>
            }
            {
                for $ACCOUNTTITLE in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/ACCOUNTTITLE
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTTITLE) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $AVAILBALANCE in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/AVAILBALANCE
                return
                    <AVAILABLE_BALANCE>{ data($AVAILBALANCE) }</AVAILABLE_BALANCE>
            }
            {
                for $CLEARINGBAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/CLEARINGBAL
                return
                    <CLEARING_BALANCE>{ data($CLEARINGBAL) }</CLEARING_BALANCE>
            }
            {
                for $LOCKEDBALANCE in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/LOCKEDBALANCE
                return
                    <LOCKED_BALANCE>{ data($LOCKEDBALANCE) }</LOCKED_BALANCE>
            }
            {
                for $LOCKEDVISABAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/LOCKEDVISABAL
                return
                    <VISA_FLOATING_BALANCE>{ data($LOCKEDVISABAL) }</VISA_FLOATING_BALANCE>
            }
            {
                for $PDOUTSTANDING in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/PDOUTSTANDING
                return
                    <OVRDF_CLRNG_CA_BALANCE>{ data($PDOUTSTANDING) }</OVRDF_CLRNG_CA_BALANCE>
            }
            {
                for $TOTALAVAILBAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/TOTALAVAILBAL
                return
                    <TOTAL_AVAILABLE_BALANCE>{ data($TOTALAVAILBAL) }</TOTAL_AVAILABLE_BALANCE>
            }
            {
                for $ACTUALBALANCE in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/ACTUALBALANCE
                return
                    <TOTAL_BALANCE>{ data($ACTUALBALANCE) }</TOTAL_BALANCE>
            }
            <CASH_ADVANCE>
                {
                    for $AUTHLIMITCASHADV in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/AUTHLIMITCASHADV
                    return
                        <LIMIT_AMOUNT>{ data($AUTHLIMITCASHADV) }</LIMIT_AMOUNT>
                }
                {
                    for $UTILCASHADVVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/UTILCASHADVVAL
                    return
                        <USED_AMOUNT>{ data($UTILCASHADVVAL) }</USED_AMOUNT>
                }
                {
                    for $AUTHLIMITCASHADV in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/AUTHLIMITCASHADV,
                        $UTILCASHADVVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/UTILCASHADVVAL
                    return
                        <AVAILABLE_AMOUNT>{ fn-bea:format-number(number($AUTHLIMITCASHADV) - number($UTILCASHADVVAL),"###.00") }</AVAILABLE_AMOUNT>
                }
            </CASH_ADVANCE>
            <AUTHORIZED_OVERDRAFT>
                {
                    for $AUTHOVRDFVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/AUTHOVRDFVAL
                    return
                        <LIMIT_AMOUNT>{ data($AUTHOVRDFVAL) }</LIMIT_AMOUNT>
                }
                {
                    for $USEDOVRDFVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/USEDOVRDFVAL
                    return
                        <USED_AMOUNT>{ data($USEDOVRDFVAL) }</USED_AMOUNT>
                }
                {
                    for $AVLOVRDFVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/AVLOVRDFVAL
                    return
                        <AVAILABLE_AMOUNT>{ data($AVLOVRDFVAL) }</AVAILABLE_AMOUNT>
                }
            </AUTHORIZED_OVERDRAFT>
            <UNAUTHORIZED_OVERDRAFT>
                {
                    for $UNAUTHOVRDFVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/UNAUTHOVRDFVAL
                    return
                        <USED_AMOUNT>{ data($UNAUTHOVRDFVAL) }</USED_AMOUNT>
                }
            </UNAUTHORIZED_OVERDRAFT>
            <CLEARING_FUNDS>
                {
                    for $ACCTRESVAMT in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/ACCTRESVAMT
                    return
                        <LIMIT_AMOUNT>{ data($ACCTRESVAMT) }</LIMIT_AMOUNT>
                }
                {
                    for $USEDRESVLIMVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/USEDRESVLIMVAL
                    return
                        <USED_AMOUNT>{ data($USEDRESVLIMVAL) }</USED_AMOUNT>
                }
                {
                    for $RESVLIMVAL in $consultadesaldodecuentaResponse/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType[1]/RESVLIMVAL
                    return
                        <AVAILABLE_AMOUNT>{ data($RESVLIMVAL) }</AVAILABLE_AMOUNT>
                }
            </CLEARING_FUNDS>
        </ns1:consultaMaestraSaldoCuentaResponse>
};

declare variable $consultadesaldodecuentaResponse as element(ns0:ConsultadesaldodecuentaResponse) external;

xf:consultaMaestraSaldoCuentaOut($consultadesaldodecuentaResponse)