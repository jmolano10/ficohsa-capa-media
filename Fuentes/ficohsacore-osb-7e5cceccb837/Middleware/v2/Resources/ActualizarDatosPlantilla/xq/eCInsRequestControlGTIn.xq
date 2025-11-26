(:: pragma bea:global-element-parameter parameter="$actualizarDatosPlantilla1" element="ns1:actualizarDatosPlantilla" location="../../GestionesEstadoCuenta/xsd/gestionesEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosGT/eCInsRequestControl/xsd/eCInsRequestControl_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCInsRequestControl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarDatosPlantilla/xq/eCInsRequestControlGTIn/";

declare function xf:eCInsRequestControlGTIn($actualizarDatosPlantilla1 as element(ns1:actualizarDatosPlantilla),
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_tipo>{ data($actualizarDatosPlantilla1/OPERATION_TYPE) }</ns0:i_tipo>
            <ns0:i_tabla>{ data($actualizarDatosPlantilla1/TABLE_NAME) }</ns0:i_tabla>
            <ns0:i_lote>{ data($actualizarDatosPlantilla1/BATCH_ID) }</ns0:i_lote>
            <ns0:i_pais>{ $codigoPais }</ns0:i_pais>
        </ns0:InputParameters>
};

declare variable $actualizarDatosPlantilla1 as element(ns1:actualizarDatosPlantilla) external;
declare variable $codigoPais as xs:string external;

xf:eCInsRequestControlGTIn($actualizarDatosPlantilla1,
    $codigoPais)