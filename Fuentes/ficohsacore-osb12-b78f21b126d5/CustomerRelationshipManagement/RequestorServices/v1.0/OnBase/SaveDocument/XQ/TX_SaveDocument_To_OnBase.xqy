xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://onbase.ficohsa.com";
(:: import schema at "../../../../../ProviderServices/v1.0/OnBase/XSD/onbaseTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/tx_SaveDocument_To_OnBase";

declare variable $documentRequest as element() (:: schema-element(ns2:documentRequest) ::) external;

declare function ns1:tx_SaveDocument_To_OnBase($documentRequest as element() (:: schema-element(ns2:documentRequest) ::)) as element() (:: schema-element(ns3:SaveDocumentRequest) ::) {
    <ns3:SaveDocumentRequest>
        <ns3:DocumentTypeName>{fn:data($documentRequest/ns2:DocumentInfo/ns2:DocumentTypeName)}</ns3:DocumentTypeName>
        <ns3:FileFormat>{fn:data($documentRequest/ns2:DocumentInfo/ns2:FileFormat)}</ns3:FileFormat>
        <ns3:FileExtension>{fn:data($documentRequest/ns2:DocumentInfo/ns2:FileExtension)}</ns3:FileExtension>
        {
            for $Keywords in $documentRequest/ns2:DocumentInfo/ns2:Keywords
            return 
            <ns3:Keywords>
                <ns3:Name>{fn:data($Keywords/ns2:Name)}</ns3:Name>
                <ns3:Value>{fn:data($Keywords/ns2:Value)}</ns3:Value></ns3:Keywords>
        }
        <ns3:KTGs>
            {
                if ($documentRequest/ns2:DocumentInfo/ns2:KTGs/ns2:Name)
                then <ns3:Name>{fn:data($documentRequest/ns2:DocumentInfo/ns2:KTGs/ns2:Name)}</ns3:Name>
                else ()
            }
            {
                for $Keywords1 in $documentRequest/ns2:DocumentInfo/ns2:KTGs/ns2:Keywords
                return 
                <ns3:Keywords>
                    <ns3:Name>{fn:data($Keywords1/ns2:Name)}</ns3:Name>
                    <ns3:Value>{fn:data($Keywords1/ns2:Value)}</ns3:Value></ns3:Keywords>
            }</ns3:KTGs>
        {
            for $Pages in $documentRequest/ns2:DocumentInfo/ns2:Pages
            return 
            <ns3:Pages>{fn:data($documentRequest/ns2:DocumentInfo/ns2:Pages)}</ns3:Pages>
        }
        <ns3:FolderID>{fn:data($documentRequest/ns2:DocumentInfo/ns2:FolderID)}</ns3:FolderID>
    </ns3:SaveDocumentRequest>
};

ns1:tx_SaveDocument_To_OnBase($documentRequest)
