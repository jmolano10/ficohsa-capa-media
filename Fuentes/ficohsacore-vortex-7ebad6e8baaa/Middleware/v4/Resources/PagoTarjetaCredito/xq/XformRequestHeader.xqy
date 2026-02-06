xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:RequestHeader" location="../../../../v2/Resources/esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v3/Resources/PagoTarjetaCredito/xq/ValidacionCuentaHeader/";

declare function xf:ValidacionCuentaHeader($UserName as xs:string,
    $Password as xs:string,
    $Bank as xs:string)
    as element(ns0:RequestHeader) {
        <ns0:RequestHeader>
            <Authentication>
                <UserName>{ $UserName }</UserName>
                <Password>{ $Password }</Password>
            </Authentication>
            <Region>
                <SourceBank>{ $Bank }</SourceBank>
                <DestinationBank>{ $Bank }</DestinationBank>
            </Region>
        </ns0:RequestHeader>
};

declare variable $UserName as xs:string external;
declare variable $Password as xs:string external;
declare variable $Bank as xs:string external;

xf:ValidacionCuentaHeader($UserName,
    $Password,
    $Bank)