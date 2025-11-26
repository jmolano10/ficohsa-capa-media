(:: pragma bea:global-element-parameter parameter="$consultasaldopromcuentaResponse1" element="ns0:ConsultasaldopromcuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldoPromedioCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaSaldoPromedioCuenta/consultaPromedioOut/";

declare function xf:consultaPromedioOut($consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse))
    as element(ns1:consultaSaldoPromedioCuentaResponse) {
        let $WSACCTAVERAGEBALType := $consultasaldopromcuentaResponse1/WSACCTAVERAGEBALType[1]
        return
            <ns1:consultaSaldoPromedioCuentaResponse>
                {
                    for $gWSACCTAVERAGEBALDetailType in $WSACCTAVERAGEBALType/gWSACCTAVERAGEBALDetailType
                    return
                        <ns1:consultaSaldoPromedioCuentaResponseType>
                            {
                                for $mWSACCTAVERAGEBALDetailType in $gWSACCTAVERAGEBALDetailType/mWSACCTAVERAGEBALDetailType
                                return
                                    <ns1:consultaSaldoPromedioCuentaResponseRecordType>
                                        {
                                            for $ACCOUNTNUMBER in $mWSACCTAVERAGEBALDetailType/ACCOUNTNUMBER
                                            return
                                                <ACCOUNT_NUMBER>{ data($ACCOUNTNUMBER) }</ACCOUNT_NUMBER>
                                        }
                                        {
                                            for $CRAVBAL in $mWSACCTAVERAGEBALDetailType/CRAVBAL
                                            return
                                                <AVERAGE_BALANCE>{ data($CRAVBAL) }</AVERAGE_BALANCE>
                                        }
                                    </ns1:consultaSaldoPromedioCuentaResponseRecordType>
                            }
                        </ns1:consultaSaldoPromedioCuentaResponseType>
                }
            </ns1:consultaSaldoPromedioCuentaResponse>
};

declare variable $consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse) external;

xf:consultaPromedioOut($consultasaldopromcuentaResponse1)
