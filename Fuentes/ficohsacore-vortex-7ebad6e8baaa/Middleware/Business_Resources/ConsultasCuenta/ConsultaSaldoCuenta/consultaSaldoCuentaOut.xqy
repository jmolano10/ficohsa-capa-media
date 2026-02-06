xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultadesaldodecuentaResponse1" element="ns0:ConsultadesaldodecuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldoCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuenta/consultaSaldoCuentaOut/";

declare function xf:consultaSaldoCuentaOut($consultadesaldodecuentaResponse1 as element(ns0:ConsultadesaldodecuentaResponse))
    as element(ns1:consultaSaldoCuentaResponse) {
        <ns1:consultaSaldoCuentaResponse>
            {
                for $gWSFICOACCTBASICDETAILSDetailType in $consultadesaldodecuentaResponse1/WSFICOACCTBASICDETAILSType[1]/gWSFICOACCTBASICDETAILSDetailType
                return
                    <ns1:consultaSaldoCuentaResponseType>
                        {
                            for $mWSFICOACCTBASICDETAILSDetailType in $gWSFICOACCTBASICDETAILSDetailType/mWSFICOACCTBASICDETAILSDetailType
                            return
                                <ns1:consultaSaldoCuentaResponseRecordType>
                                    <BALANCE_DATE>{ data($mWSFICOACCTBASICDETAILSDetailType/BALANCESDATE) }</BALANCE_DATE>
                                    <ACCOUNT_NAME>{ data($mWSFICOACCTBASICDETAILSDetailType/ACCOUNTTITLE) }</ACCOUNT_NAME>
                                    <AVAILABLE_BALANCE>{ data($mWSFICOACCTBASICDETAILSDetailType/AVAILBALANCE) }</AVAILABLE_BALANCE>
                                    <CLEARING_BALANCE>{ data($mWSFICOACCTBASICDETAILSDetailType/CLEARINGBAL) }</CLEARING_BALANCE>
                                    <LOCKED_BALANCE>{ data($mWSFICOACCTBASICDETAILSDetailType/LOCKEDBALANCE) }</LOCKED_BALANCE>
                                    <VISA_FLOATING_BALANCE>{ data($mWSFICOACCTBASICDETAILSDetailType/LOCKEDVISABAL) }</VISA_FLOATING_BALANCE>
                                    <TOTAL_BALANCE>{ data($mWSFICOACCTBASICDETAILSDetailType/TOTALAVAILBAL) }</TOTAL_BALANCE>
                                    <AUTH_OVERDRAFT>{ data($mWSFICOACCTBASICDETAILSDetailType/AUTHOVRDFVAL) }</AUTH_OVERDRAFT>
                                    <RSRV_FUNDS_LIMIT>{ data($mWSFICOACCTBASICDETAILSDetailType/USEDRESVLIMVAL) }</RSRV_FUNDS_LIMIT>
                                </ns1:consultaSaldoCuentaResponseRecordType>
                        }
                    </ns1:consultaSaldoCuentaResponseType>
            }
        </ns1:consultaSaldoCuentaResponse>
};

declare variable $consultadesaldodecuentaResponse1 as element(ns0:ConsultadesaldodecuentaResponse) external;

xf:consultaSaldoCuentaOut($consultadesaldodecuentaResponse1)