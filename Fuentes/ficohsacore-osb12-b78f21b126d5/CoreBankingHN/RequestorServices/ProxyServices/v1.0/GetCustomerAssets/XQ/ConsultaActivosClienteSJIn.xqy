xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/ConsultaActivosClienteSJIn";

declare variable $customerId as xs:string external;
declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $legalId as xs:string external;
declare variable $assetType as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $uuid as xs:string external;

declare function ns1:consultaActivosClienteSJIn($username as xs:string, $password as xs:string, $customerId as xs:string, $legalId as xs:string, $assetType as xs:string, $sourceBank as xs:string, $destinationBank as xs:string, $uuid as xs:string) as element() (:: schema-element(ns2:sjConsultaActivosClienteRequest) ::) {
    <ns2:sjConsultaActivosClienteRequest>
        <ns2:USERNAME>{fn:data($username)}</ns2:USERNAME>
        <ns2:PASSWORD>{fn:data($password)}</ns2:PASSWORD>
        <ns2:CUSTOMER_ID>{fn:data($customerId)}</ns2:CUSTOMER_ID>
        <ns2:LEGAL_ID>{fn:data($legalId)}</ns2:LEGAL_ID>
        <ns2:ASSET_TYPE>{fn:data($assetType)}</ns2:ASSET_TYPE>
        <ns2:SOURCE_BANK>{fn:data($sourceBank)}</ns2:SOURCE_BANK>
        <ns2:DESTINATION_BANK>{fn:data($destinationBank)}</ns2:DESTINATION_BANK>
        <ns2:UUID>{fn:data($uuid)}</ns2:UUID>
    </ns2:sjConsultaActivosClienteRequest>
};

ns1:consultaActivosClienteSJIn($username, $password, $customerId, $legalId, $assetType, $sourceBank, $destinationBank, $uuid)
