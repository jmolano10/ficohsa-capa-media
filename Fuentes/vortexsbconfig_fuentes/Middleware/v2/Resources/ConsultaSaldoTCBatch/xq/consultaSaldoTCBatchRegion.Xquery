<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoTCBatch" element="ns0:consultaSaldoTCBatch" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldoTCBatch" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/alertasProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoTCBatch/xq/consultaSaldoTCBatchRegion/";

declare function xf:consultaSaldoTCBatchRegion($consultaSaldoTCBatch as element(ns0:consultaSaldoTCBatch),
    $region as xs:string)
    as element(ns0:consultaSaldoTCBatch) {
        <ns0:consultaSaldoTCBatch>
            <CARDS>
                {
                    for $CARD in $consultaSaldoTCBatch/CARDS/CARD
                    return
                        <CARD>
                            <ID>{ data($CARD/ID) }</ID>
                            <PRODUCT_REGION>{ $region }</PRODUCT_REGION>
                        </CARD>
                }
            </CARDS>
        </ns0:consultaSaldoTCBatch>
};

declare variable $consultaSaldoTCBatch as element(ns0:consultaSaldoTCBatch) external;
declare variable $region as xs:string external;

xf:consultaSaldoTCBatchRegion($consultaSaldoTCBatch,
    $region)]]></con:xquery>
    <con:dependency location="../../AlertasProductos/xsd/alertasProductosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/AlertasProductos/xsd/alertasProductosTypes"/>
    </con:dependency>
</con:xqueryEntry>