xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../../v3/BusinessServices/ABKGT/PagoRecaudo/xsd/PagoRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompraRecarga/xq/compraRecargaGTHeaderOut/";

declare function xf:compraRecargaGTHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_TRANSACTION_ID in $outputParameters/ns1:PV_TRANSACTION_ID
                return
                    <transactionId>{ data($PV_TRANSACTION_ID) }</transactionId>
            }
            {
                for $PV_SUCCESSINDICATOR in $outputParameters/ns1:PV_SUCCESSINDICATOR
                return
                    <successIndicator>{ data($PV_SUCCESSINDICATOR) }</successIndicator>
            }
            {
                for $PV_MESSAGES in $outputParameters/ns1:PV_MESSAGES
                return
                    <messages>{ data($PV_MESSAGES) }</messages>
            }
            {
                for $PV_VALUE_DATE in $outputParameters/ns1:PV_VALUE_DATE
                return
                    <valueDate>{ data($PV_VALUE_DATE) }</valueDate>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:compraRecargaGTHeaderOut($outputParameters)