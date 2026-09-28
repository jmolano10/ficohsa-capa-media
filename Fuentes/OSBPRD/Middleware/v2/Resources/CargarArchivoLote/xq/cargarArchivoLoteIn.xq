(:: pragma bea:global-element-parameter parameter="$cargarArchivoLote1" element="ns0:cargarArchivoLote" location="../../PagosMasivos/xsd/pagosMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/cargarArchivoLote/xsd/cargarArchivoLote_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargarArchivoLote";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargarArchivoLote/xq/cargarArchivoLoteIn/";

declare function xf:cargarArchivoLoteIn($cargarArchivoLote1 as element(ns0:cargarArchivoLote),
    $USERNAME as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PT_AUDITORIAINFO>
                <ns1:CODIGO_CLIENTE>{ data($cargarArchivoLote1/CUSTOMER_ID) }</ns1:CODIGO_CLIENTE>
                <ns1:CODIGO_USUARIO>{ data($cargarArchivoLote1/USER_ID) }</ns1:CODIGO_USUARIO>
                <ns1:USUARIO_SERVICIO>{ $USERNAME }</ns1:USUARIO_SERVICIO>
            </ns1:PT_AUDITORIAINFO>
            <ns1:PV_CODIGOCLIENTE>{ data($cargarArchivoLote1/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_CODIGOUSUARIO>{ data($cargarArchivoLote1/USER_ID) }</ns1:PV_CODIGOUSUARIO>
            <ns1:PN_TIPOOPERACION>{ data($cargarArchivoLote1/TYPE) }</ns1:PN_TIPOOPERACION>
            {
                for $ENCRYPTED_FILE in $cargarArchivoLote1/ENCRYPTED_FILE
                return
                    <ns1:PV_ENCRIPTADO>{ data($ENCRYPTED_FILE) }</ns1:PV_ENCRIPTADO>
            }
            <ns1:PC_ARCHIVO>{ data($cargarArchivoLote1/FLAT_FILE) }</ns1:PC_ARCHIVO>
            <ns1:PV_NOMBREARCHIVO>{ data($cargarArchivoLote1/FILE_NAME) }</ns1:PV_NOMBREARCHIVO>
            {
                for $APPLICATION_DATE in $cargarArchivoLote1/APPLICATION_DATE
                return
                    <ns1:PD_FECHAAPLICACION>{ data($APPLICATION_DATE) }</ns1:PD_FECHAAPLICACION>
            }
        </ns1:InputParameters>
};

declare variable $cargarArchivoLote1 as element(ns0:cargarArchivoLote) external;
declare variable $USERNAME as xs:string external;

xf:cargarArchivoLoteIn($cargarArchivoLote1,
    $USERNAME)