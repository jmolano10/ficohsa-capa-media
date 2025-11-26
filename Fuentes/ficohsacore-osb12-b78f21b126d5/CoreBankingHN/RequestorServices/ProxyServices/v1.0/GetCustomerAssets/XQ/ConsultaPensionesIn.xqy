xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../../../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $IdType as xs:string external;
declare variable $legalId as xs:string external;

declare function local:func($IdType as xs:string, 
                            $legalId as xs:string) 
                            as element() (:: schema-element(ns1:saldos) ::) {
     <ns1:saldos>
        <ns1:codigoTipoIdentificacion>{fn:data($IdType)}</ns1:codigoTipoIdentificacion>
        <ns1:numeroIdentificacion>{fn:data($legalId)}</ns1:numeroIdentificacion>
    </ns1:saldos>
};

local:func($IdType, $legalId)
