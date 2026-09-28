(:: pragma bea:global-element-parameter parameter="$consultaSaldoPromedioCuenta" element="ns0:consultaSaldoPromedioCuenta" location="../../ConsultaMovimientosCuenta/xsd/consultasGeneralesCuentasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaSaldoPromedioCuenta/xsd/consultaSaldoPromedioCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldoPromedioCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoPromedioCuenta/xq/consultaSaldoPromedioGTIn/";

declare function xf:consultaSaldoPromedioGTIn($consultaSaldoPromedioCuenta as element(ns0:consultaSaldoPromedioCuenta))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($consultaSaldoPromedioCuenta/ACCOUNT_NUMBER) }</ns1:ACCOUNT_NUMBER>
            <ns1:START_DATE>{ data($consultaSaldoPromedioCuenta/START_DATE) }</ns1:START_DATE>
            <ns1:END_DATE>{ data($consultaSaldoPromedioCuenta/END_DATE) }</ns1:END_DATE>
        </ns1:InputParameters>
};

declare variable $consultaSaldoPromedioCuenta as element(ns0:consultaSaldoPromedioCuenta) external;

xf:consultaSaldoPromedioGTIn($consultaSaldoPromedioCuenta)