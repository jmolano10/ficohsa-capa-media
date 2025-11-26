(:: pragma bea:global-element-parameter parameter="$consultaVisanetPosDwhRequest1" element="ns0:consultaVisanetPosDwhRequest" location="../xsd/consultaVisanetPosDwhTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ConsultaVisanetPosDwh/xsd/consultaVisanetPosDwh_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaVisanetPosDwh";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaVisanetPosDwhTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaVisanetPosDwh/xq/consultaVisanetPosDwhIn/";

declare function xf:consultaVisanetPosDwhIn($consultaVisanetPosDwhRequest1 as element(ns0:consultaVisanetPosDwhRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:RTN>{ data($consultaVisanetPosDwhRequest1/ns0:TAX_ID) }</ns1:RTN>
        </ns1:InputParameters>
};

declare variable $consultaVisanetPosDwhRequest1 as element(ns0:consultaVisanetPosDwhRequest) external;

xf:consultaVisanetPosDwhIn($consultaVisanetPosDwhRequest1)