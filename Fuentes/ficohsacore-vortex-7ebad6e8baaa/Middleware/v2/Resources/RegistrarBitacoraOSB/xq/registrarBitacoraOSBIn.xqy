xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$registrarBitacoraOSB" element="ns1:registrarBitacoraOSB" location="../xsd/registrarBitacoraOSBTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MDW/registrarBitacoraOSB/xsd/registrarBitacoraOSB_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarBitacoraOSB";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registrarBitacoraOSBTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarBitacoraOSB/xq/registrarBitacoraOSBIn/";

declare function xf:registrarBitacoraOSBIn($contenido as xs:string,
    $registrarBitacoraOSB as element(ns1:registrarBitacoraOSB))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_UUID>{ data($registrarBitacoraOSB/UUID) }</ns0:PV_UUID>
            <ns0:PV_TIPOMENSAJE>{ data($registrarBitacoraOSB/TIPO_MENSAJE) }</ns0:PV_TIPOMENSAJE>
            <ns0:PV_IDSERVICIO>{ data($registrarBitacoraOSB/ID_SERVICIO) }</ns0:PV_IDSERVICIO>
            <ns0:PV_IDOPERACION>{ data($registrarBitacoraOSB/ID_OPERACION) }</ns0:PV_IDOPERACION>
            <ns0:PV_IDOSB>{ data($registrarBitacoraOSB/ID_OSB) }</ns0:PV_IDOSB>
            <ns0:PV_BANCOORIGEN>{ data($registrarBitacoraOSB/BANCO_ORIGEN) }</ns0:PV_BANCOORIGEN>
            <ns0:PV_BANCODESTINO>{ data($registrarBitacoraOSB/BANCO_DESTINO) }</ns0:PV_BANCODESTINO>
            <ns0:PV_USUARIO>{ data($registrarBitacoraOSB/USUARIO) }</ns0:PV_USUARIO>
            <ns0:PC_CONTENIDO>{ $contenido }</ns0:PC_CONTENIDO>
            <ns0:PV_IDTXN>{ data($registrarBitacoraOSB/ID_TRANSACCION) }</ns0:PV_IDTXN>
            <ns0:PV_RESULTADO>{ data($registrarBitacoraOSB/RESULTADO) }</ns0:PV_RESULTADO>
            <ns0:PV_MENSAJEERROR>{ data($registrarBitacoraOSB/MENSAJE_ERROR) }</ns0:PV_MENSAJEERROR>
            <ns0:PV_UUIDREQ>{ data($registrarBitacoraOSB/UUID_REQUEST) }</ns0:PV_UUIDREQ>
            <ns0:PD_FECHATXN>{ fn:adjust-dateTime-to-timezone(current-dateTime(), ()) }</ns0:PD_FECHATXN>
            {
                for $CLAVE_PRIMARIA in $registrarBitacoraOSB/CLAVE_PRIMARIA
                return
                    <ns0:PV_CLAVEPRIMARIA>{ data($CLAVE_PRIMARIA) }</ns0:PV_CLAVEPRIMARIA>
            }
        </ns0:InputParameters>
};

declare variable $contenido as xs:string external;
declare variable $registrarBitacoraOSB as element(ns1:registrarBitacoraOSB) external;

xf:registrarBitacoraOSBIn($contenido,
    $registrarBitacoraOSB)