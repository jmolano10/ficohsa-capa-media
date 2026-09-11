<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/autType";
(:: import schema at "../../Esquemas_Generales/HeaderElements.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $username as xs:string external;
declare variable $password as xs:string external;

declare function xq:envioEmailHeaderIn($username as xs:string, 
                                       $password as xs:string) 
                                       as element() (:: schema-element(ns1:RequestHeader) ::) {
    <ns1:RequestHeader>
        <Authentication>
            <UserName>{fn:data($username)}</UserName>
            <Password>{fn:data($password)}</Password>
        </Authentication>
        <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
        </Region>
    </ns1:RequestHeader>
};

xq:envioEmailHeaderIn($username, $password)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../Esquemas_Generales/HeaderElements.xsd">
            <con:schema ref="Middleware/v2/Resources/Esquemas_Generales/HeaderElements"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>