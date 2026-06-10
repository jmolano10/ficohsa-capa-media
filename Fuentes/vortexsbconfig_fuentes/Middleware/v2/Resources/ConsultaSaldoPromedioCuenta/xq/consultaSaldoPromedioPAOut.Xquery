<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/consultaSaldoPromedioCuenta/xsd/consultaSaldoPromedioCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldoPromedioCuentaResponse" location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldoPromedioCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoPromedioCuenta/xq/consultaSaldoPromedioPAOut/";

declare function xf:consultaSaldoPromedioPAOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaSaldoPromedioCuentaResponse) {
        <ns0:consultaSaldoPromedioCuentaResponse>
            <ns0:consultaSaldoPromedioCuentaResponseType>
                <ns0:consultaSaldoPromedioCuentaResponseRecordType>
                    {
                        for $ACCOUNT_NUMBER_OUT in $outputParameters/ns1:ACCOUNT_NUMBER_OUT
                        return
                            <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER_OUT) }</ACCOUNT_NUMBER>
                    }
                    {
                        for $AVERAGE_BALANCE in $outputParameters/ns1:AVERAGE_BALANCE
                        return
                            <AVERAGE_BALANCE>{ data($AVERAGE_BALANCE) }</AVERAGE_BALANCE>
                    }
                </ns0:consultaSaldoPromedioCuentaResponseRecordType>
            </ns0:consultaSaldoPromedioCuentaResponseType>
        </ns0:consultaSaldoPromedioCuentaResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaSaldoPromedioPAOut($outputParameters)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaSaldoPromedioCuenta/xsd/consultaSaldoPromedioCuenta_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaSaldoPromedioCuenta/xsd/consultaSaldoPromedioCuenta_sp"/>
    </con:dependency>
    <con:dependency location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes"/>
    </con:dependency>
</con:xqueryEntry>