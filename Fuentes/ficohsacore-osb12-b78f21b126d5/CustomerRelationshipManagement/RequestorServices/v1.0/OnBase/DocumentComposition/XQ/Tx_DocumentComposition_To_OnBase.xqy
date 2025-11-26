xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/Tx_DocumentComposition_To_OnBase";

declare variable $DocumentCompositionReq as element() (:: schema-element(ns2:DocumentCompositionReq) ::) external;

declare function ns1:Tx_DocumentComposition_To_OnBase($DocumentCompositionReq as element() (:: schema-element(ns2:DocumentCompositionReq) ::)) as element() (:: schema-element(ns3:documentCompositionRequestOnBase) ::) {
    <ns3:documentCompositionRequestOnBase>
        <ns3:DocumentTemplate>{fn:data($DocumentCompositionReq/ns2:DocumentCompositionInfo/ns2:DocumentTemplate)}</ns3:DocumentTemplate>
        <ns3:BodyXML>{fn:data($DocumentCompositionReq/ns2:DocumentCompositionInfo/ns2:BodyXML)}</ns3:BodyXML>
        <ns3:WithDocument>{fn:data($DocumentCompositionReq/ns2:DocumentCompositionInfo/ns2:WithDocument)}</ns3:WithDocument>
    </ns3:documentCompositionRequestOnBase>
};

ns1:Tx_DocumentComposition_To_OnBase($DocumentCompositionReq)