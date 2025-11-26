(:: pragma bea:global-element-parameter parameter="$validacionCuentaResponse1" element="ns0:validacionCuentaResponse" location="../../../../v3/Resources/ValidacionCuenta/xsd/validacionCuentaType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCuentaRetiroEfectivoResponse" location="../xsd/consultaCuentaRetiroEfectivoCBTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validacionCuentaType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentaRetiroEfectivoCBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentaRetiroEfectivoCB/xq/ConsultaCuentaRetEfecCBOut/";

declare function xf:ConsultaCuentaRetEfecCBOut($validacionCuentaResponse1 as element(ns0:validacionCuentaResponse),
    $Identidad as xs:string,
    $Celular as xs:string)
    as element(ns1:consultaCuentaRetiroEfectivoResponse) {
        <ns1:consultaCuentaRetiroEfectivoResponse>
            <LEGAL_ID>{ $Identidad }</LEGAL_ID>
            <MOBILE_NUMBER>{ $Celular }</MOBILE_NUMBER>
            {
                for $ACCOUNT_NUMBER in $validacionCuentaResponse1/ACCOUNT_NUMBER
                return
                    <ACCOUNT_NUMBER>{ data($ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
            }
            {
                for $PRODUCT_TYPE in $validacionCuentaResponse1/PRODUCT_TYPE
                return
                    <ACCOUNT_TYPE>{ data($PRODUCT_TYPE) }</ACCOUNT_TYPE>
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
        </ns1:consultaCuentaRetiroEfectivoResponse>
};

declare variable $validacionCuentaResponse1 as element(ns0:validacionCuentaResponse) external;
declare variable $Identidad as xs:string external;
declare variable $Celular as xs:string external;

xf:ConsultaCuentaRetEfecCBOut($validacionCuentaResponse1,
    $Identidad,
    $Celular)