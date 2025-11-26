(:: pragma bea:global-element-parameter parameter="$reimpresionRecibo1" element="ns1:reimpresionRecibo" location="../xsd/reimpresionReciboTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/reimpresionRecibo/xsd/reimpresionRecibo_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reimpresionRecibo";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reimpresionReciboTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReimpresionRecibo/xq/ReimpresionReciboIn/";

declare function xf:ReimpresionReciboIn($reimpresionRecibo1 as element(ns1:reimpresionRecibo))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_IDTRANSACCION>{ data($reimpresionRecibo1/TRANSACTION_ID) }</ns0:PV_IDTRANSACCION>
            {
                for $ALTERNATE_TXN_ID in $reimpresionRecibo1/ALTERNATE_TXN_ID
                return
                    <ns0:PV_IDTXNALTERNA>{ data($ALTERNATE_TXN_ID) }</ns0:PV_IDTXNALTERNA>
            }
        </ns0:InputParameters>
};

declare variable $reimpresionRecibo1 as element(ns1:reimpresionRecibo) external;

xf:ReimpresionReciboIn($reimpresionRecibo1)