xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/desembolsaPrestamo/xsd/desembolsaPrestamo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:desembolsaPrestamoResponse" location="../../OperacionesPrestamo/xsd/operacionesPrestamoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/desembolsaPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DesembolsaPrestamo/xq/desembolsaPrestamoOut/";

declare function xf:desembolsaPrestamoOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:desembolsaPrestamoResponse) {
        <ns0:desembolsaPrestamoResponse>
            <EXPENSES_DETAILS>
                {
                    for $PT_TIPO_GASTO_ITEM in $outputParameters/ns1:PT_TIPO_GASTO/ns1:PT_TIPO_GASTO_ITEM
                    return
                        <EXPENSE_ITEM>
                            {
                                for $TIPO in $PT_TIPO_GASTO_ITEM/ns1:TIPO
                                return
                                    <TYPE>{ data($TIPO) }</TYPE>
                            }
                            {
                                for $MONTO in $PT_TIPO_GASTO_ITEM/ns1:MONTO
                                return
                                    <AMOUNT>{ data($MONTO) }</AMOUNT>
                            }
                            {
                                for $REFERENCIA_TRANSACCION in $PT_TIPO_GASTO_ITEM/ns1:REFERENCIA_TRANSACCION
                                return
                                    <TRANSACTION_REFERENCE>{ data($REFERENCIA_TRANSACCION) }</TRANSACTION_REFERENCE>
                            }
                        </EXPENSE_ITEM>
                }
            </EXPENSES_DETAILS>
            <DISBURSEMENT_DETAILS>
                {
                    for $PT_DETALLE_DESEMBOLSO_ITEM in $outputParameters/ns1:PT_DETALLE_DESEMBOLSO/ns1:PT_DETALLE_DESEMBOLSO_ITEM
                    return
                        <DISBURSEMENT_ITEM>
                            {
                                for $TIPO_PRODUCTO in $PT_DETALLE_DESEMBOLSO_ITEM/ns1:TIPO_PRODUCTO
                                return
                                    <PRODUCT_TYPE>{ data($TIPO_PRODUCTO) }</PRODUCT_TYPE>
                            }
                            {
                                for $NUMERO_PRODUCTO in $PT_DETALLE_DESEMBOLSO_ITEM/ns1:NUMERO_PRODUCTO
                                return
                                    <PRODUCT_NUMBER>{ data($NUMERO_PRODUCTO) }</PRODUCT_NUMBER>
                            }
                            {
                                for $TIPO_MONEDA in $PT_DETALLE_DESEMBOLSO_ITEM/ns1:TIPO_MONEDA
                                return
                                    <PRODUCT_CURRENCY>{ data($TIPO_MONEDA) }</PRODUCT_CURRENCY>
                            }
                            {
                                for $MONTO in $PT_DETALLE_DESEMBOLSO_ITEM/ns1:MONTO
                                return
                                    <AMOUNT>{ data($MONTO) }</AMOUNT>
                            }
                            {
                                for $REFERENCIA_TRANSACCION in $PT_DETALLE_DESEMBOLSO_ITEM/ns1:REFERENCIA_TRANSACCION
                                return
                                    <TRANSACTION_REFERENCE>{ data($REFERENCIA_TRANSACCION) }</TRANSACTION_REFERENCE>
                            }
                            <ADDITIONAL_DATA>
                                {
                                    let $result :=
                                        for $DATOS_ADICIONALES_ITEM in $PT_DETALLE_DESEMBOLSO_ITEM/ns1:DATOS_ADICIONALES/ns1:DATOS_ADICIONALES_ITEM
                                        return
                                            <KV_PAIR>
                                                {
                                                    for $KEY in $DATOS_ADICIONALES_ITEM/ns1:KEY
                                                    return
                                                        <KEY_VALUE>{ data($KEY) }</KEY_VALUE>
                                                }
                                                {
                                                    for $VALOR in $DATOS_ADICIONALES_ITEM/ns1:VALOR
                                                    return
                                                        <VALUE>{ data($VALOR) }</VALUE>
                                                }
                                            </KV_PAIR>
                                    return
                                        $result[1]
                                }
                            </ADDITIONAL_DATA>
                        </DISBURSEMENT_ITEM>
                }
            </DISBURSEMENT_DETAILS>
        </ns0:desembolsaPrestamoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:desembolsaPrestamoOut($outputParameters)