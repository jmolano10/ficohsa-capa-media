xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/availableFinancingDetailTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/availableFinancingDetailTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultOffer_BS";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultOffer/ConsultOffer_BS_sp.xsd" ::)

declare variable $AvailableFinancingDetailRequest as element() (:: schema-element(ns1:availableFinancingDetailRequest) ::) external;

declare function local:func($AvailableFinancingDetailRequest as element() (:: schema-element(ns1:availableFinancingDetailRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:Pv_Identidad>{fn:data($AvailableFinancingDetailRequest/ns1:LegalId)}</ns2:Pv_Identidad>
        <ns2:Pv_Linea>{fn:data($AvailableFinancingDetailRequest/ns1:CreditLine)}</ns2:Pv_Linea>
    </ns2:InputParameters>
};

local:func($AvailableFinancingDetailRequest)