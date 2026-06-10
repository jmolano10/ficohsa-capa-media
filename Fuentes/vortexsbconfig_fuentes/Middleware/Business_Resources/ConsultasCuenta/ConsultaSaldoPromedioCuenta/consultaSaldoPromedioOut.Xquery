<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultasaldopromcuentaResponse1" element="ns0:ConsultasaldopromcuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaSaldoPromedioCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
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
                                            for $ACCOUNTAVREAL in $mWSACCTAVERAGEBALDetailType/ACCOUNTAVREAL
                                            return
                                                <AVERAGE_BALANCE>{ data($ACCOUNTAVREAL) }</AVERAGE_BALANCE>
                                        }
                                    </ns1:consultaSaldoPromedioCuentaResponseRecordType>
                            }
                        </ns1:consultaSaldoPromedioCuentaResponseType>
                }
            </ns1:consultaSaldoPromedioCuentaResponse>
};

declare variable $consultasaldopromcuentaResponse1 as element(ns0:ConsultasaldopromcuentaResponse) external;

xf:consultaPromedioOut($consultasaldopromcuentaResponse1)]]></con:xquery>
    <con:dependency location="../Resources/XMLSchema_378991004.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004"/>
    </con:dependency>
    <con:dependency location="../Resources/consultasGeneralesCuentasTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/ConsultasCuenta/Resources/consultasGeneralesCuentasTypes"/>
    </con:dependency>
</con:xqueryEntry>