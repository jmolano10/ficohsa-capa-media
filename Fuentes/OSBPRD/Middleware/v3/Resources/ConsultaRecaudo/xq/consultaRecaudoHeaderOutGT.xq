(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/ConsultaRecaudo/xsd/ConsultaRecaudo_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudo";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/ConsultaRecaudo/xq/consultaRecaudoHeaderOutGT/";

declare function xf:consultaRecaudoHeaderOutGT($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_SUCCESSINDICATOR in $outputParameters1/ns0:PV_SUCCESSINDICATOR
                return
                    <successIndicator>{ data($PV_SUCCESSINDICATOR) }</successIndicator>
            }
            {
                for $PV_MESSAGES in $outputParameters1/ns0:PV_MESSAGES
                return
                    <messages>{ data($PV_MESSAGES) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaRecaudoHeaderOutGT($outputParameters1)