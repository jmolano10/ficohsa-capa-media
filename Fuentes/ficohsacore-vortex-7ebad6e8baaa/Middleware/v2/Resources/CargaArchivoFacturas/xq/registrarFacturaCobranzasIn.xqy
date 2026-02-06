xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$cargaArchivoFacturas1" element="ns1:cargaArchivoFacturas" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABK/registrarFacturaCobranzas/xsd/registrarFacturaCobranzas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarFacturaCobranzas";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CargaArchivoFacturas/xq/registrarFacturaCobranzasIn/";

declare function xf:registrarFacturaCobranzasIn($cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $USER_ID in $cargaArchivoFacturas1/USER_ID
                return
                    <ns0:PV_LOGIN>{ data($USER_ID) }</ns0:PV_LOGIN>
            }
            <ns0:PV_CODIGOCLIENTE>{ data($cargaArchivoFacturas1/CUSTOMER_ID) }</ns0:PV_CODIGOCLIENTE>
            <ns0:PV_NUMEROCONTRATO>{ data($cargaArchivoFacturas1/CONTRACT_ID) }</ns0:PV_NUMEROCONTRATO>
            <ns0:PC_ARCHIVO>{ data($cargaArchivoFacturas1/FLAT_FILE) }</ns0:PC_ARCHIVO>
            {
                for $ENCRYPTED_FILE in $cargaArchivoFacturas1/ENCRYPTED_FILE
                return
                    <ns0:PV_ENCRIPTADO>{ data($ENCRYPTED_FILE) }</ns0:PV_ENCRIPTADO>
            }
            <ns0:PV_NOMBREARCHIVO>{ data($cargaArchivoFacturas1/FILE_NAME) }</ns0:PV_NOMBREARCHIVO>
        </ns0:InputParameters>
};

declare variable $cargaArchivoFacturas1 as element(ns1:cargaArchivoFacturas) external;

xf:registrarFacturaCobranzasIn($cargaArchivoFacturas1)