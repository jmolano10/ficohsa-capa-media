xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaEstadoDatosPlantilla1" element="ns0:consultaEstadoDatosPlantilla" location="../../GestionesEstadoCuenta/xsd/gestionesEstadoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/MasterData/eCConRequestControl/xsd/eCConRequestControl_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCConRequestControl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoDatosPlantilla/xq/eCConRequestControl/";

declare function xf:eCConRequestControl($consultaEstadoDatosPlantilla1 as element(ns0:consultaEstadoDatosPlantilla),
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_lote>{ data($consultaEstadoDatosPlantilla1/BATCH_ID) }</ns1:i_lote>
            <ns1:i_pais>{ $codigoPais }</ns1:i_pais>
        </ns1:InputParameters>
};

declare variable $consultaEstadoDatosPlantilla1 as element(ns0:consultaEstadoDatosPlantilla) external;
declare variable $codigoPais as xs:string external;

xf:eCConRequestControl($consultaEstadoDatosPlantilla1,
    $codigoPais)