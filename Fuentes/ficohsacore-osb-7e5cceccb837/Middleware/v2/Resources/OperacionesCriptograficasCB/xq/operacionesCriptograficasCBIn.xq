(:: pragma bea:global-element-parameter parameter="$cifrarDatos" element="ns1:cifrarDatos" location="../xsd/operacionesCriptograficasCBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:cifrarDatos" location="../../OperacionesCriptograficas/xsd/operacionesCriptograficasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficasCB/xq/operacionesCriptograficasCBIn/";

declare function xf:operacionesCriptograficasCBIn($cifrarDatos as element(ns1:cifrarDatos))
    as element(ns0:cifrarDatos) {
        <ns0:cifrarDatos>
            <ns0:CIPHER>{ data($cifrarDatos/ns1:CIPHER) }</ns0:CIPHER>
            <ns0:CRYPTOKEY_ALIAS>{ data($cifrarDatos/ns1:CRYPTOKEY_ALIAS) }</ns0:CRYPTOKEY_ALIAS>
            <ns0:DECRYPTED_DATA>{ data($cifrarDatos/ns1:DECRYPTED_DATA) }</ns0:DECRYPTED_DATA>
        </ns0:cifrarDatos>
};

declare variable $cifrarDatos as element(ns1:cifrarDatos) external;

xf:operacionesCriptograficasCBIn($cifrarDatos)