(:: pragma bea:global-element-parameter parameter="$validacionCuentaResponse1" element="ns0:validacionCuentaResponse" location="../xsd/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validacionCuentaResponse" location="../xsd/validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/External/Incoming/v2/BussinessServices/ValidacionCuenta/xq/ValidacionCuentaOUT/";

declare function xf:ValidacionCuentaOUT($validacionCuentaResponse1 as element(ns0:validacionCuentaResponse))
    as element(ns0:validacionCuentaResponse) {
        <ns0:validacionCuentaResponse>
            {
                for $ACCOUNT_NUMBER in $validacionCuentaResponse1/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNT_NAME in $validacionCuentaResponse1/ACCOUNT_NAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNT_NAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $validacionCuentaResponse1/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $ACCOUNT_STATUS in $validacionCuentaResponse1/ACCOUNT_STATUS
                return
                    <ACCOUNT_STATUS>{ data($ACCOUNT_STATUS) }</ACCOUNT_STATUS>
            }
            {
                for $PRODUCT_TYPE in $validacionCuentaResponse1/PRODUCT_TYPE
                return
                    <PRODUCT_TYPE>{ data($PRODUCT_TYPE) }</PRODUCT_TYPE>
            }
            {
                for $CUSTOMER_ID in $validacionCuentaResponse1/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
        </ns0:validacionCuentaResponse>
};

declare variable $validacionCuentaResponse1 as element(ns0:validacionCuentaResponse) external;

xf:ValidacionCuentaOUT($validacionCuentaResponse1)