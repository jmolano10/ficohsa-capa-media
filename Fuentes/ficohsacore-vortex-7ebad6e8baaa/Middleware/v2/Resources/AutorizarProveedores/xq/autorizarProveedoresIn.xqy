xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autorizarProveedores" element="ns1:autorizarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/autorizarProveedores/xsd/autorizarProveedores_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/autorizarProveedores";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AutorizarProveedores/xq/AutorizarProveedoresIn/";

declare function xf:AutorizarProveedoresIn($autorizarProveedores as element(ns1:autorizarProveedores),
    $USERNAME as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_AUDITORIAINFO>
                <ns0:CODIGO_CLIENTE>{ data($autorizarProveedores/CUSTOMER_ID) }</ns0:CODIGO_CLIENTE>
                <ns0:CODIGO_USUARIO>{ data($autorizarProveedores/USER_ID) }</ns0:CODIGO_USUARIO>
                <ns0:USUARIO_SERVICIO>{ $USERNAME }</ns0:USUARIO_SERVICIO>
                <ns0:PROCESO_ORIGEN_ERROR>AutorizarProveedores</ns0:PROCESO_ORIGEN_ERROR>
            </ns0:PT_AUDITORIAINFO>
            <ns0:PT_CODIGOPROVEEDOR>
                {
                    for $SUPPLIER in $autorizarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/ID) }</ns0:ITEM>
                }
            </ns0:PT_CODIGOPROVEEDOR>
        </ns0:InputParameters>
};

declare variable $autorizarProveedores as element(ns1:autorizarProveedores) external;
declare variable $USERNAME as xs:string external;

xf:AutorizarProveedoresIn($autorizarProveedores,
    $USERNAME)