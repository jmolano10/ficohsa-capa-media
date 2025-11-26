(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/CNV/reimpresionRecibo/xsd/reimpresionRecibo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/reimpresionRecibo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReimpresionRecibo/xq/ReimpresionReciboHeaderOut/";

declare function xf:ReimpresionReciboHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_CODIGOERROR in $outputParameters1/ns1:PV_CODIGOERROR
                return
                    <successIndicator>{ data($PV_CODIGOERROR) }</successIndicator>
            }
            {
                for $PV_MENSAJEERROR in $outputParameters1/ns1:PV_MENSAJEERROR
                return
                    <messages>{ data($PV_MENSAJEERROR) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ReimpresionReciboHeaderOut($outputParameters1)