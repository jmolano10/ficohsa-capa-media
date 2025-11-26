(:: pragma bea:global-element-parameter parameter="$eliminarProveedores" element="ns1:eliminarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/eliminarProveedores/xsd/eliminarProveedores_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eliminarProveedores";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EliminarProveedores/xq/eliminarProveedoresHNIn/";

declare function xf:eliminarProveedoresHNIn($eliminarProveedores as element(ns1:eliminarProveedores))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_AUDITORIAINFO>
                <ns0:CODIGO_CLIENTE>{ data($eliminarProveedores/CUSTOMER_ID) }</ns0:CODIGO_CLIENTE>
            </ns0:PT_AUDITORIAINFO>
            <ns0:PT_CODIGOPROVEEDORES>
            {
            	for $PROVEEDOR in $eliminarProveedores/SUPPLIERS/SUPPLIER
                return
                	<ns1:ITEM>{ data($PROVEEDOR/ID) }</ns1:ITEM>
            }
            </ns0:PT_CODIGOPROVEEDORES>
        </ns0:InputParameters>
};

declare variable $eliminarProveedores as element(ns1:eliminarProveedores) external;

xf:eliminarProveedoresHNIn($eliminarProveedores)