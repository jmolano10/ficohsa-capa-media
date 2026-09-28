(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaSaldoPromedioCuenta/xsd/consultaSaldoPromedioCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldoPromedioCuentaResponse" location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldoPromedioCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoPromedioCuenta/xq/consultaSaldoPromedioGTOut/";

declare function xf:consultaSaldoPromedioGTOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaSaldoPromedioCuentaResponse) {
        <ns0:consultaSaldoPromedioCuentaResponse>
            <ns0:consultaSaldoPromedioCuentaResponseType>
                <ns0:consultaSaldoPromedioCuentaResponseRecordType>
                    {
                        for $ACCOUNT_NUMBER_OUT in $outputParameters1/ns1:ACCOUNT_NUMBER_OUT
                        return
                            <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER_OUT) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $AVERAGE_BALANCE in $outputParameters1/ns1:AVERAGE_BALANCE
                        return
                            <AVERAGE_BALANCE>{ data($AVERAGE_BALANCE) }</AVERAGE_BALANCE>
                    }
                </ns0:consultaSaldoPromedioCuentaResponseRecordType>
            </ns0:consultaSaldoPromedioCuentaResponseType>
        </ns0:consultaSaldoPromedioCuentaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consultaSaldoPromedioGTOut($outputParameters1)