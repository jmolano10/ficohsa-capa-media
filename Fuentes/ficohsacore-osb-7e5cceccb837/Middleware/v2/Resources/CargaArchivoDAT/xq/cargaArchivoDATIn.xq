(:: pragma bea:global-element-parameter parameter="$cargaArchivoDAT" element="ns1:cargaArchivoDAT" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEI/cargarArchivoDAT/xsd/cargarArchivoDAT_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cargarArchivoDAT";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoDAT/xq/cargaArchivoDATIn/";

declare function xf:cargaArchivoDATIn($cargaArchivoDAT as element(ns1:cargaArchivoDAT),
    $USERNAME as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PT_AUDITORIAINFO>
                <ns0:RTN>{ data($cargaArchivoDAT/RTN) }</ns0:RTN>
                <ns0:USUARIO_SERVICIO>{ $USERNAME }</ns0:USUARIO_SERVICIO>
                <ns0:NOMBRE_ARCHIVO>{ data($cargaArchivoDAT/FILE_NAME) }</ns0:NOMBRE_ARCHIVO>
                <ns0:PROCESO_ORIGEN_ERROR>CargaArchivoDAT</ns0:PROCESO_ORIGEN_ERROR>
            </ns0:PT_AUDITORIAINFO>
            <ns0:PV_CODIGOUSUARIO>{ data($cargaArchivoDAT/USER_ID) }</ns0:PV_CODIGOUSUARIO>
            <ns0:PV_NUMEROCONTRATO>{ data($cargaArchivoDAT/CONTRACT_NUMBER) }</ns0:PV_NUMEROCONTRATO>
            <ns0:PV_CODIGOCLIENTE>{ data($cargaArchivoDAT/CUSTOMER_ID) }</ns0:PV_CODIGOCLIENTE>
            <ns0:PC_ARCHIVO>{ data($cargaArchivoDAT/TAX_FILE) }</ns0:PC_ARCHIVO>
        </ns0:InputParameters>
};

declare variable $cargaArchivoDAT as element(ns1:cargaArchivoDAT) external;
declare variable $USERNAME as xs:string external;

xf:cargaArchivoDATIn($cargaArchivoDAT,
    $USERNAME)