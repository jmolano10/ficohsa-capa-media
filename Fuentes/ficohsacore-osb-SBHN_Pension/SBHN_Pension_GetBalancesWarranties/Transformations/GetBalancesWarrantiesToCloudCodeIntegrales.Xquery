<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../Schemas/CloudCodeTypes.xsd" ::)

declare variable $request as element() (:: schema-element(ns1:restriccionesResponse) ::) external;
declare variable $subAccount as xs:string external;

declare function local:func($request as element() (:: schema-element(ns1:restriccionesResponse) ::), $subAccount as xs:string) as element() (:: schema-element(ns1:integrales) ::) {
    <ns1:integrales>
        <ns1:codigoLineaProducto>{fn:data($request/ns1:datos/ns1:cuenta/ns1:codigoLineaProducto)}</ns1:codigoLineaProducto>
        <ns1:codigoTipoIdentificacionCliente>{fn:data($request/ns1:datos/ns1:cuenta/ns1:codigoTipoIdentificacionCliente)}</ns1:codigoTipoIdentificacionCliente>
        <ns1:numeroIdentificacionCliente>{fn:data($request/ns1:datos/ns1:cuenta/ns1:numeroIdentificacionCliente)}</ns1:numeroIdentificacionCliente>
        <ns1:codigoCuenta>{fn:data($request/ns1:datos/ns1:cuenta/ns1:codigoCuenta)}</ns1:codigoCuenta>
        <ns1:codigoSubcuenta>{fn:data($subAccount)}</ns1:codigoSubcuenta>
    </ns1:integrales>
};

local:func($request,$subAccount)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_GetBalancesWarranties/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>