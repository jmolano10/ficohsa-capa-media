xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizarDatosPlantilla" element="ns1:actualizarDatosPlantilla" location="../../GestionesEstadoCuenta/xsd/gestionesEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/eCInsRequestControl/xsd/eCisRequestControl_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCisRequestControl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarDatosPlantilla/xq/eCInsRequestControlHNIn/";

declare function xf:eCInsRequestControlHNIn($actualizarDatosPlantilla as element(ns1:actualizarDatosPlantilla),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_tipo>{ data($actualizarDatosPlantilla/OPERATION_TYPE) }</ns0:i_tipo>
            <ns0:i_tabla>{ data($actualizarDatosPlantilla/TABLE_NAME) }</ns0:i_tabla>
            <ns0:i_lote>{ data($actualizarDatosPlantilla/BATCH_ID) }</ns0:i_lote>
            <ns0:i_pais>{ $codigoPais }</ns0:i_pais>
        </ns0:InputParameters>
};

declare variable $actualizarDatosPlantilla as element(ns1:actualizarDatosPlantilla) external;
declare variable $codigoPais as xs:string external;

xf:eCInsRequestControlHNIn($actualizarDatosPlantilla,
    $codigoPais)