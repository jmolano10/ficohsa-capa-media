xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/digitalizacionExpedienteTypes";
(:: import schema at "../../../../../../MWBanking/Documents/RequestorServices/XSD/digitalizacionExpedienteTypes.xsd" ::)
declare namespace ns2="http://www.ficohsa.com/midleware.services/ExpedientesAPITypes";
(:: import schema at "../../../../../ProviderServices/v1.0/XSD/TotalImage/ExpedientesAPITypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $input as element() (:: schema-element(ns1:creaExpedienteRequest) ::) external;

declare function xq:createFileIn($input as element() (:: schema-element(ns1:creaExpedienteRequest) ::)) as element() (:: schema-element(ns2:getTransaction6Request) ::) {
    <ns2:getTransaction6Request>
        <ns2:carpeta>{fn:data($input/ns1:directories)}</ns2:carpeta>
        <ns2:archivador>{fn:data($input/ns1:storageName)}</ns2:archivador>
        {
            for $item in $input/ns1:keyInfo/ns1:item
            return 
            <ns2:llaves>
                <ns2:nombre>{fn:data($item/ns1:KEY)}</ns2:nombre>
                <ns2:valor>{fn:data($item/ns1:VALUE)}</ns2:valor></ns2:llaves>
        }
        <ns2:tipoExpediente>
            <ns2:nombre>{fn:data($input/ns1:fileTypeName)}</ns2:nombre>
        </ns2:tipoExpediente>
    </ns2:getTransaction6Request>
};

xq:createFileIn($input)