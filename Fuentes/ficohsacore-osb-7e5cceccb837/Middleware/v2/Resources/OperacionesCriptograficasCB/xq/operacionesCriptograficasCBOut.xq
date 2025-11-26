(:: pragma bea:global-element-parameter parameter="$cifrarDatosResponse" element="ns0:cifrarDatosResponse" location="../../OperacionesCriptograficas/xsd/operacionesCriptograficasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cifrarDatosResponse" location="../xsd/operacionesCriptograficasCBTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasCBTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OperacionesCriptograficasCB/xq/operacionesCriptograficasCBOut/";

declare function xf:operacionesCriptograficasCBOut($cifrarDatosResponse as element(ns0:cifrarDatosResponse))
    as element(ns1:cifrarDatosResponse) {
        <ns1:cifrarDatosResponse>
            <ns1:ENCRYPTED_DATA>{ data($cifrarDatosResponse/ns0:ENCRYPTED_DATA) }</ns1:ENCRYPTED_DATA>
        </ns1:cifrarDatosResponse>
};

declare variable $cifrarDatosResponse as element(ns0:cifrarDatosResponse) external;

xf:operacionesCriptograficasCBOut($cifrarDatosResponse)
