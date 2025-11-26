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
    $region)