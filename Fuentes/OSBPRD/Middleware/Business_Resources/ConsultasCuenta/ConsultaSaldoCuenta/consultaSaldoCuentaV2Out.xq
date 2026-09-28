(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentaResponse1" element="ns0:ConsultaSaldoCuentaResponse" location="../Resources/ConsultaSaldoCuenta/xsd/services_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldoCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoCuenta/consultaSaldoCuentaOut/";

declare function xf:consultaSaldoCuentaOut($consultaSaldoCuentaResponse1 as element(ns0:ConsultaSaldoCuentaResponse))
    as element(ns1:consultaSaldoCuentaResponse) {
        <ns1:consultaSaldoCuentaResponse>
              {
                for $gFICOCONSULSALDOACCTDetailType in $consultaSaldoCuentaResponse1/FICOCONSULSALDOACCTType[1]/gFICOCONSULSALDOACCTDetailType
                return
            <ns1:consultaSaldoCuentaResponseType>
                  {
                   for $mFICOCONSULSALDOACCTDetailType in $gFICOCONSULSALDOACCTDetailType/mFICOCONSULSALDOACCTDetailType
                   return
                <ns1:consultaSaldoCuentaResponseRecordType>
                    <BALANCE_DATE>{ data($mFICOCONSULSALDOACCTDetailType/BALANCESDATE) }</BALANCE_DATE>
                    <ACCOUNT_NAME>{ data($mFICOCONSULSALDOACCTDetailType/ACCOUNTTITLE) }</ACCOUNT_NAME>
                    <AVAILABLE_BALANCE>{ data($mFICOCONSULSALDOACCTDetailType/AVAILBALANCE) }</AVAILABLE_BALANCE>
                    <CLEARING_BALANCE>{ data($mFICOCONSULSALDOACCTDetailType/CLEARINGBAL) }</CLEARING_BALANCE>
                    <LOCKED_BALANCE>{ data($mFICOCONSULSALDOACCTDetailType/LOCKEDBALANCE) }</LOCKED_BALANCE>
                    <VISA_FLOATING_BALANCE>{ data($mFICOCONSULSALDOACCTDetailType/LOCKEDVISABAL) }</VISA_FLOATING_BALANCE>
                    <TOTAL_BALANCE>{ data($mFICOCONSULSALDOACCTDetailType/TOTALAVAILBAL) }</TOTAL_BALANCE>
                    <AUTH_OVERDRAFT>{ data($mFICOCONSULSALDOACCTDetailType/AUTHOVRDFVAL) }</AUTH_OVERDRAFT>
                    <RSRV_FUNDS_LIMIT>{ data($mFICOCONSULSALDOACCTDetailType/USEDRESVLIMVAL) }</RSRV_FUNDS_LIMIT>
                </ns1:consultaSaldoCuentaResponseRecordType>
                  }
            </ns1:consultaSaldoCuentaResponseType>
              }
        </ns1:consultaSaldoCuentaResponse>
};

declare variable $consultaSaldoCuentaResponse1 as element(ns0:ConsultaSaldoCuentaResponse) external;

xf:consultaSaldoCuentaOut($consultaSaldoCuentaResponse1)