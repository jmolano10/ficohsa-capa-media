(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisiones" location="../../ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/consultaComisionesHNIn/";

declare function xf:consultaComisionesHNIn($retiroTarjetaCredito as element(ns1:retiroTarjetaCredito),
    $TransactionType as xs:string,
    $nameAdditionalInfo as xs:string)
    as element(ns0:consultaComisiones) {
        <ns0:consultaComisiones>
            <TRANSACTION_TYPE>{ $TransactionType }</TRANSACTION_TYPE>
            {
                for $CUSTOMER_ID in $retiroTarjetaCredito/CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            <SOURCE_CURRENCY>{ data($retiroTarjetaCredito/CURRENCY) }</SOURCE_CURRENCY>
            <ADDITIONAL_INFO>
                <INFO>
                	<NAME>{ $nameAdditionalInfo }</NAME>
                    <VALUE>{ string($retiroTarjetaCredito/AMOUNT/text()) }</VALUE>
                </INFO>
            </ADDITIONAL_INFO>
        </ns0:consultaComisiones>
};

declare variable $retiroTarjetaCredito as element(ns1:retiroTarjetaCredito) external;
declare variable $TransactionType as xs:string external;
declare variable $nameAdditionalInfo as xs:string external;

xf:consultaComisionesHNIn($retiroTarjetaCredito,
    $TransactionType,
    $nameAdditionalInfo)