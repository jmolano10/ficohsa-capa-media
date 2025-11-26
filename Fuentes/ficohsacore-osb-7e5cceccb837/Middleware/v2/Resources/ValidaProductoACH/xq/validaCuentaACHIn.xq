(:: pragma bea:global-element-parameter parameter="$validaProductoACHReq" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:validacionCuenta" location="../../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaCuentaACHIn/";

declare function xf:validaCuentaACHIn($validaProductoACHReq as element(ns0:validaProductoACH))
    as element(ns1:validacionCuenta) {
        <ns1:validacionCuenta>
            <ACCOUNT_NUMBER>{ data($validaProductoACHReq/PRODUCT_NUMBER) }</ACCOUNT_NUMBER>
            {
                for $PRODUCT_NAME in $validaProductoACHReq/PRODUCT_NAME
                return
                    <ACCOUNT_NAME>{ data($PRODUCT_NAME) }</ACCOUNT_NAME>
            }
            <CHECK_CANCELLED_YES_NO>NO</CHECK_CANCELLED_YES_NO>
        </ns1:validacionCuenta>
};

declare variable $validaProductoACHReq as element(ns0:validaProductoACH) external;
declare variable $ProductType as xs:string external;
declare variable $ProductCurrency as xs:string external;

xf:validaCuentaACHIn($validaProductoACHReq)
