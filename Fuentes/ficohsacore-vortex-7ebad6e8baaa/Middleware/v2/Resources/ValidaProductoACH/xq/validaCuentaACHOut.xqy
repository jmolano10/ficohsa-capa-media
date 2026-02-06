xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$validacionCuentaResponse" element="ns1:validacionCuentaResponse" location="../../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaProductoACHResponse" location="../xsd/validaProductoACHTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/validaCuentaACHOut/";

declare function xf:validaCuentaACHOut($validaProductoACH as element(ns0:validaProductoACH),
    $validacionCuentaResponse as element(ns1:validacionCuentaResponse),
    $OriginalAccount as xs:string)
    as element(ns0:validaProductoACHResponse) {
        <ns0:validaProductoACHResponse>
            <PRODUCT_NUMBER>{ $OriginalAccount }</PRODUCT_NUMBER>
            {
                for $ACCOUNT_NAME in $validacionCuentaResponse/ACCOUNT_NAME
                return
                    <PRODUCT_NAME>
                        {
                            let $First  := (substring(data($ACCOUNT_NAME),1,3))  
                            let $Last  := (substring(data($ACCOUNT_NAME), string-length(data($ACCOUNT_NAME)) - 3 + 1, 3))  
                            return
                                if (data($ACCOUNT_NAME) = '') then
                                    ('')
                                else 
                                    string-join(($First,$Last),'**********')
                        }
</PRODUCT_NAME>
            }
            {
                for $CURRENCY in $validacionCuentaResponse/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $ACCOUNT_STATUS in $validacionCuentaResponse/ACCOUNT_STATUS
                return
                    <PRODUCT_STATUS>true</PRODUCT_STATUS>
            }
            {
                for $PRODUCT_TYPE in $validacionCuentaResponse/PRODUCT_TYPE
                return
                    <PRODUCT_TYPE>{ data($PRODUCT_TYPE) }</PRODUCT_TYPE>
            }
            <UUID>{ data($validaProductoACH/UUID) }</UUID>
            {
                for $KV_PAIRS in $validaProductoACH/KV_PAIRS
                return
                    <KV_PAIRS>{ $KV_PAIRS/@* , $KV_PAIRS/node() }</KV_PAIRS>
            }
        </ns0:validaProductoACHResponse>
};

declare variable $validaProductoACH as element(ns0:validaProductoACH) external;
declare variable $validacionCuentaResponse as element(ns1:validacionCuentaResponse) external;
declare variable $OriginalAccount as xs:string external;

xf:validaCuentaACHOut($validaProductoACH,
    $validacionCuentaResponse,
    $OriginalAccount)