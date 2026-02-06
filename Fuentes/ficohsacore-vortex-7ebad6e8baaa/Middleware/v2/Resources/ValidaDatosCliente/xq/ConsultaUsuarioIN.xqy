xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaDatosClienteIN" element="ns0:validaDatosCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaUsuario" location="../../ConsultaUsuario/xsd/consultaUsuarioTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaUsuarioTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/xq/ConsultaUsuarioIN/";

declare function xf:ConsultaUsuarioIN($validaDatosClienteIN as element(ns0:validaDatosCliente))
    as element(ns1:consultaUsuario) {
        <ns1:consultaUsuario>
            <CUSTOMER_ID_TYPE>LEGAL_ID</CUSTOMER_ID_TYPE>
            <CUSTOMER_ID_VALUE>{ data($validaDatosClienteIN/LEGAL_ID) }</CUSTOMER_ID_VALUE>
        </ns1:consultaUsuario>
};

declare variable $validaDatosClienteIN as element(ns0:validaDatosCliente) external;

xf:ConsultaUsuarioIN($validaDatosClienteIN)