(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../../v2/BusinessServices/ABKPA/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuentaResponse" location="../xsd/validacionCuentaType.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ValidacionCuenta/xq/validacionCuentaPABodyOut/";

declare function xf:validacionCuentaPABodyOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:validacionCuentaResponse) {
        <ns1:validacionCuentaResponse>
            {
                for $ACCOUNT_NUMBER in $outputParameters/ns0:ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNT_NAME in $outputParameters/ns0:ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $outputParameters/ns0:CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $INACTIVE_MARKER in $outputParameters/ns0:INACTIVE_MARKER
                return
                    <ACCOUNT_STATUS>
                        {
                            if (data($INACTIVE_MARKER) = '1') then
                                ("INACTIVE")
                            else 
                                "ACTIVE"
                        }
					</ACCOUNT_STATUS>
            }
            {
                for $CATEGORY in $outputParameters/ns0:CATEGORY
                return
                    <PRODUCT_TYPE>{ data($CATEGORY) }</PRODUCT_TYPE>
            }
            {
                for $CUSTOMER_ID in $outputParameters/ns0:CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
        </ns1:validacionCuentaResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:validacionCuentaPABodyOut($outputParameters)