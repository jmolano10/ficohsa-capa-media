xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/calculateFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/calculateFinancingTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultOffer_BS";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultOffer/ConsultOffer_BS_sp.xsd" ::)

declare variable $calculateFinancingRequest as element() (:: schema-element(ns1:calculateFinancingRequest) ::) external;

declare function local:func($calculateFinancingRequest as element() (:: schema-element(ns1:calculateFinancingRequest) ::)) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
      <ns2:Pv_Identidad>{ data($calculateFinancingRequest/ns1:Base/ns1:CustomerId) }</ns2:Pv_Identidad>
      <ns2:Pv_Linea>{ data($calculateFinancingRequest/ns1:CreditLine) }</ns2:Pv_Linea>
    </ns2:InputParameters>
};

local:func($calculateFinancingRequest)