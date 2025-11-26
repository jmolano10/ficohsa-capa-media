(:: pragma bea:global-element-return element="ns0:generarHash" location="../xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficas/xq/generarHashIn/";

declare function xf:generarHashIn($algorithm as xs:string,
    $plainData as xs:string)
    as element(ns0:generarHash) {
        <ns0:generarHash>
            <ns0:ALGORITHM>{ $algorithm }</ns0:ALGORITHM>
            <ns0:PLAIN_DATA>{ $plainData }</ns0:PLAIN_DATA>
        </ns0:generarHash>
};

declare variable $algorithm as xs:string external;
declare variable $plainData as xs:string external;

xf:generarHashIn($algorithm,
    $plainData)
