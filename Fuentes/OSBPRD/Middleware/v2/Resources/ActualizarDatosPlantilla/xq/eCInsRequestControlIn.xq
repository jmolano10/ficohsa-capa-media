(:: pragma bea:global-element-parameter parameter="$actualizarDatosPlantilla" element="ns0:actualizarDatosPlantilla" location="../../GestionesEstadoCuenta/xsd/gestionesEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterData/eCInsRequestControl/xsd/eCInsRequestControl_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarDatosPlantilla";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarDatosPlantilla/xq/eCInsRequestControlIn/";

declare function xf:eCInsRequestControlIn($actualizarDatosPlantilla as element(ns0:actualizarDatosPlantilla),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_tipo>{ data($actualizarDatosPlantilla/OPERATION_TYPE) }</ns1:i_tipo>
            <ns1:i_tabla>{ data($actualizarDatosPlantilla/TABLE_NAME) }</ns1:i_tabla>
            <ns1:i_lote>{ data($actualizarDatosPlantilla/BATCH_ID) }</ns1:i_lote>
            <ns1:i_pais>{ $codigoPais }</ns1:i_pais>
        </ns1:InputParameters>
};

declare variable $actualizarDatosPlantilla as element(ns0:actualizarDatosPlantilla) external;
declare variable $codigoPais as xs:string external;

xf:eCInsRequestControlIn($actualizarDatosPlantilla,
    $codigoPais)