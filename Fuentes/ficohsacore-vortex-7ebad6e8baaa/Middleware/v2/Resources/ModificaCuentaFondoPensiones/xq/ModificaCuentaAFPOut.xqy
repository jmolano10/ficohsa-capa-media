xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaCuentaAFP/xsd/ModificaCuentaAFP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaCuentaAFP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaCuentaFondoPensiones/xq/ModificaCuentaAFPOut/";

declare function xf:ModificaCuentaAFPOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
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
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ModificaCuentaAFPOut($outputParameters)