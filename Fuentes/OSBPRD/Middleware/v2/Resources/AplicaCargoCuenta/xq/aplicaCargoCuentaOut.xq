(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/aplicaCargoCuenta/xsd/AplicaCargoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:aplicaCargoCuentaResponse" location="../xsd/aplicaCargoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/AplicaCargoCuenta";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aplicaCargoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AplicaCargoCuenta/xq/aplicaCargoCuentaOut/";

declare function xf:aplicaCargoCuentaOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:aplicaCargoCuentaResponse) {
        <ns1:aplicaCargoCuentaResponse>
            <DEBITED_ACCOUNT>{ data($outputParameters/ns0:PN_NUMERO_CUENTA_TRX) }</DEBITED_ACCOUNT>
            {
                for $PN_MONEDA_TRX in $outputParameters/ns0:PN_MONEDA_TRX
                return
                    <CURENCY>{ data($PN_MONEDA_TRX) }</CURENCY>
            }
            {
                for $PN_MONTO_TRX in $outputParameters/ns0:PN_MONTO_TRX
                return
                    <CHARGED_AMOUNT>{ data($PN_MONTO_TRX) }</CHARGED_AMOUNT>
            }
            <TRANSACTION_REFERENCE>{ data($outputParameters/ns0:PN_SECUENCIA) }</TRANSACTION_REFERENCE>
            <VALUE_DATE>{  fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($outputParameters/ns0:PN_FECHA_VALIDA_TRX)),()) }</VALUE_DATE>
        </ns1:aplicaCargoCuentaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:aplicaCargoCuentaOut($outputParameters)