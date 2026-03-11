xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../Schemas/ReversarTransacciones.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/transfer/transferTypes";
(:: import schema at "../Schemas/RollbackTaxesBulletinTypes.xsd" ::)

declare variable $coreResponse as element() (:: schema-element(ns1:rollbackTaxesBulletinResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcT24ToRollbackTaxesBulletin($coreResponse as element() (:: schema-element(ns1:rollbackTaxesBulletinResponse) ::),
                                                      $globalId as xs:string) as element() (:: schema-element(ns2:rollbackTaxesBullletinResponse) ::) {
    <ns2:rollbackTaxesBullletinResponse>
        <StatusInfo>
            {
                if ($coreResponse/Status/successIndicator)
                then <Status>{fn:data($coreResponse/Status/successIndicator)}</Status>
                else ()
            }
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>  
    </ns2:rollbackTaxesBullletinResponse>
};

local:funcT24ToRollbackTaxesBulletin($coreResponse, $globalId)
