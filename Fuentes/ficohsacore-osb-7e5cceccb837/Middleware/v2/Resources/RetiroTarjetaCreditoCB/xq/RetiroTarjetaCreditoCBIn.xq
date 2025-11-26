(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCreditoCB" element="ns0:retiroTarjetaCredito" location="../xsd/RetiroTarjetaCreditoCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:retiroTarjetaCredito" location="../../RetiroTarjetaCredito/xsd/retiroTarjetaCreditoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCreditoCB/xq/RetiroTarjetaCreditoCBIn/";

declare function xf:RetiroTarjetaCreditoCBIn($retiroTarjetaCreditoCB as element(ns0:retiroTarjetaCredito),
    $cuentaDebito as xs:string)
    as element(ns0:retiroTarjetaCredito) {
        <ns0:retiroTarjetaCredito>
            {
                for $CUSTOMER_ID in $retiroTarjetaCreditoCB/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            <CREDIT_CARD_INFO>
                <TYPE>{ data($retiroTarjetaCreditoCB/CREDIT_CARD_INFO/TYPE) }</TYPE>
                <VALUE>{ data($retiroTarjetaCreditoCB/CREDIT_CARD_INFO/VALUE) }</VALUE>
                {
                    for $EXPIRATION_DATE in $retiroTarjetaCreditoCB/CREDIT_CARD_INFO/EXPIRATION_DATE
                    return
                        <EXPIRATION_DATE>{ data($EXPIRATION_DATE) }</EXPIRATION_DATE>
                }
            </CREDIT_CARD_INFO>
            <DISBURSEMENT>
                <TYPE>ACCOUNT</TYPE>
                <PRODUCT_TYPE>AHO</PRODUCT_TYPE>
                <VALUE>{ $cuentaDebito }</VALUE>
            </DISBURSEMENT>
            <CURRENCY>{ data($retiroTarjetaCreditoCB/CURRENCY) }</CURRENCY>
            <AMOUNT>{ data($retiroTarjetaCreditoCB/AMOUNT) }</AMOUNT>
        </ns0:retiroTarjetaCredito>
};

declare variable $retiroTarjetaCreditoCB as element(ns0:retiroTarjetaCredito) external;
declare variable $cuentaDebito as xs:string external;

xf:RetiroTarjetaCreditoCBIn($retiroTarjetaCreditoCB,
    $cuentaDebito)
