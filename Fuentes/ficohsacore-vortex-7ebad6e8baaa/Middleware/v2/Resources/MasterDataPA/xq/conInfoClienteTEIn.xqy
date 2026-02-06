xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataPA/conInfoClienteTE/xsd/conInfoClienteTE_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoClienteTE";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataPA/xq/conInfoClienteTEIn/";

declare function xf:conInfoClienteTEIn($country as xs:string,
    $idType as xs:string,
    $idValue as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $country }</ns0:Pais>
            <ns0:TipoIdentificacion>{ xs:int($idType) }</ns0:TipoIdentificacion>
            <ns0:NumeroIdentificacion>{ $idValue }</ns0:NumeroIdentificacion>
        </ns0:InputParameters>
};

declare variable $country as xs:string external;
declare variable $idType as xs:string external;
declare variable $idValue as xs:string external;

xf:conInfoClienteTEIn($country,
    $idType,
    $idValue)