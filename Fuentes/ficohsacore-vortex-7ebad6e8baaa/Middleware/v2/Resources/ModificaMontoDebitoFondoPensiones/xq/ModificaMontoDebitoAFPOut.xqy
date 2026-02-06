xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKHN/FondoPensiones/ModificaMontoDebitoAFP/xsd/ModificaMontoDebitoAFP_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../../../Business_Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ModificaMontoDebitoAFP";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ModificaMontoDebitoFondoPensiones/xq/ModificaMontoDebitoAFPOut/";

declare function xf:ModificaMontoDebitoAFPOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_SUCCESSINDICATOR in $outputParameters/ns0:PV_SUCCESSINDICATOR
                return
                    <successIndicator>{ data($PV_SUCCESSINDICATOR) }</successIndicator>
            }
            {
                for $PV_MESSAGES in $outputParameters/ns0:PV_MESSAGES
                return
                    <messages>{ data($PV_MESSAGES) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ModificaMontoDebitoAFPOut($outputParameters)