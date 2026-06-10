<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns1:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaComisiones" location="../../ConsultaComisiones/xsd/consultaComisionesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/consultaComisionesPAIn/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionesTypes";

declare function xf:consultaComisionesPAIn($retiroTarjetaCredito as element(ns1:retiroTarjetaCredito),
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

xf:consultaComisionesPAIn($retiroTarjetaCredito,
    $TransactionType,
    $nameAdditionalInfo)]]></con:xquery>
    <con:dependency location="../xsd/retiroTarjetaCreditoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/RetiroTarjetaCredito/xsd/retiroTarjetaCreditoTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaComisiones/xsd/consultaComisionesTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaComisiones/xsd/consultaComisionesTypes"/>
    </con:dependency>
</con:xqueryEntry>