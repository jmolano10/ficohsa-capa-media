xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$desembolsaPrestamo" element="ns0:desembolsaPrestamo" location="../../OperacionesPrestamo/xsd/operacionesPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/desembolsaPrestamo/xsd/desembolsaPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/desembolsaPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/DesembolsaPrestamo/xq/desembolsaPrestamo/";

declare function xf:desembolsaPrestamo($desembolsaPrestamo as element(ns0:desembolsaPrestamo),
    $userName as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CODIGO_CLIENTE>{ data($desembolsaPrestamo/CUSTOMER_ID) }</ns1:PV_CODIGO_CLIENTE>
            <ns1:PV_NUMERO_PRESTAMO>{ data($desembolsaPrestamo/LOAN_NUMBER) }</ns1:PV_NUMERO_PRESTAMO>
            <ns1:PT_TIPO_GASTO>
                {
                    for $EXPENSE_ITEM in $desembolsaPrestamo/EXPENSES_DETAILS/EXPENSE_ITEM
                    return
                        <ns1:PT_TIPO_GASTO_ITEM>
                            <ns1:TIPO>{ data($EXPENSE_ITEM/TYPE) }</ns1:TIPO>
                            <ns1:MONTO>{ data($EXPENSE_ITEM/AMOUNT) }</ns1:MONTO>
                        </ns1:PT_TIPO_GASTO_ITEM>
                }
            </ns1:PT_TIPO_GASTO>
            <ns1:PV_CODIGO_AGENCIA>{ data($desembolsaPrestamo/DISBURSEMENT_DETAILS/AGENCY_CODE) }</ns1:PV_CODIGO_AGENCIA>
            {
                for $DESCRIPTION in $desembolsaPrestamo/DISBURSEMENT_DETAILS/DESCRIPTION
                return
                    <ns1:PV_DESCRIPCION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPCION>
            }
            <ns1:PT_DETALLE_DESEMBOLSO>
                {
                    for $DISBURSEMENT_ITEM in $desembolsaPrestamo/DISBURSEMENT_DETAILS/DISBURSEMENT_ITEM
                    return
                        <ns1:PT_DETALLE_DESEMBOLSO_ITEM>
                            <ns1:TIPO_PRODUCTO>{ data($DISBURSEMENT_ITEM/PRODUCT_TYPE) }</ns1:TIPO_PRODUCTO>
                            <ns1:NUMERO_PRODUCTO>{ data($DISBURSEMENT_ITEM/PRODUCT_NUMBER) }</ns1:NUMERO_PRODUCTO>
                            <ns1:TIPO_MONEDA>{ data($DISBURSEMENT_ITEM/PRODUCT_CURRENCY) }</ns1:TIPO_MONEDA>
                            <ns1:MONTO>{ data($DISBURSEMENT_ITEM/AMOUNT) }</ns1:MONTO>
                            <ns1:DATOS_ADICIONALES>
                                {
                                    for $KV_PAIR in $DISBURSEMENT_ITEM/ADDITIONAL_DATA/KV_PAIR
                                    return
                                        <ns1:DATOS_ADICIONALES_ITEM>
                                            {
                                                for $KEY_VALUE in $KV_PAIR/KEY
                                                return
                                                    <ns1:KEY>{ data($KEY_VALUE) }</ns1:KEY>
                                            }
                                            {
                                                for $VALUE in $KV_PAIR/VALUE
                                                return
                                                    <ns1:VALOR>{ data($VALUE) }</ns1:VALOR>
                                            }
                                        </ns1:DATOS_ADICIONALES_ITEM>
                                }
                            </ns1:DATOS_ADICIONALES>
                        </ns1:PT_DETALLE_DESEMBOLSO_ITEM>
                }
            </ns1:PT_DETALLE_DESEMBOLSO>
            <ns1:PV_USUARIO_INTERFAZ>{ $userName }</ns1:PV_USUARIO_INTERFAZ>
            <ns1:PV_USUARIO_SISTEMA>{ data($desembolsaPrestamo/INPUTTER) }</ns1:PV_USUARIO_SISTEMA>
        </ns1:InputParameters>
};

declare variable $desembolsaPrestamo as element(ns0:desembolsaPrestamo) external;
declare variable $userName as xs:string external;

xf:desembolsaPrestamo($desembolsaPrestamo,
    $userName)