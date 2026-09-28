(:: pragma bea:global-element-parameter parameter="$cargarProveedores" element="ns1:cargarProveedores" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/PMSV/cargarProveedores/xsd/cargarProveedores_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargarProveedores";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaProveedores/xq/cargaProveedoresIn/";

declare function xf:CargaProveedoresIn($cargarProveedores as element(ns1:cargarProveedores),
    $USERNAME as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_AUDITORIAINFO>
                <ns0:CODIGO_CLIENTE>{ data($cargarProveedores/CUSTOMER_ID) }</ns0:CODIGO_CLIENTE>
                <ns0:CODIGO_USUARIO>{ data($cargarProveedores/USER_ID) }</ns0:CODIGO_USUARIO>
                <ns0:USUARIO_SERVICIO>{ $USERNAME }</ns0:USUARIO_SERVICIO>
                <ns0:PROCESO_ORIGEN_ERROR>CargaProveedores</ns0:PROCESO_ORIGEN_ERROR>
            </ns0:PT_AUDITORIAINFO>
            <ns0:PT_CODIGOPROVEEDOR>
                {
                    for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/ID) }</ns0:ITEM>
                }
            </ns0:PT_CODIGOPROVEEDOR>
            <ns0:PT_NOMBREPROVEEDOR>
                {
                    for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/NAME) }</ns0:ITEM>
                }
            </ns0:PT_NOMBREPROVEEDOR>
            <ns0:PT_NUMEROIDENTIFICACION>
                {
                    for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/LEGAL_ID) }</ns0:ITEM>
                }
            </ns0:PT_NUMEROIDENTIFICACION>
            <ns0:PT_CODIGOBANCODESTINO>
                {
                    for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/DESTINATION_BANK) }</ns0:ITEM>
                }
            </ns0:PT_CODIGOBANCODESTINO>
            <ns0:PT_NUMEROCUENTA>
                {
                    for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/ACCOUNT_NUMBER) }</ns0:ITEM>
                }
            </ns0:PT_NUMEROCUENTA>
            <ns0:PT_TIPOCUENTA>
                {
                    for $SUPPLIER in $cargarProveedores/SUPPLIERS/SUPPLIER
                    return
                        <ns0:ITEM>{ data($SUPPLIER/ACCOUNT_TYPE) }</ns0:ITEM>
                }
            </ns0:PT_TIPOCUENTA>
        </ns0:InputParameters>
        
};

declare variable $cargarProveedores as element(ns1:cargarProveedores) external;
declare variable $USERNAME as xs:string external;

xf:CargaProveedoresIn($cargarProveedores,
    $USERNAME)