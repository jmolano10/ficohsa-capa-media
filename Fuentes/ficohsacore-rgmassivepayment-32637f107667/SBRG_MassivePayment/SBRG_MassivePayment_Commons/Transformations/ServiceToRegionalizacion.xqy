xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/regional/utility/constants";
(:: import schema at "../Resources/SBRG_Constants_Commons/Schemas/Regional.xsd" ::)

declare variable $service as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $operation as xs:string external;
declare variable $version as xs:string external;
declare variable $user as xs:string external;

declare function local:funcServiceToRegionalizacion($service as xs:string, 
                                                    $sourceBank as xs:string, 
                                                    $destinationBank as xs:string, 
                                                    $operation as xs:string, 
                                                    $version as xs:string, 
                                                    $user as xs:string) 
                                                    as element() (:: schema-element(ns1:countryServiceInput) ::) {
    <ns1:countryServiceInput>
        <ns1:service>{fn:data($service)}</ns1:service>
        <ns1:sourceBank>{fn:data($sourceBank)}</ns1:sourceBank>
        <ns1:destinationBank>{fn:data($destinationBank)}</ns1:destinationBank>
        <ns1:operation>{fn:data($operation)}</ns1:operation>
        <ns1:version>{fn:data($version)}</ns1:version>
        <ns1:user>{fn:data($user)}</ns1:user>
    </ns1:countryServiceInput>
};

local:funcServiceToRegionalizacion($service, $sourceBank, $destinationBank, $operation, $version, $user)