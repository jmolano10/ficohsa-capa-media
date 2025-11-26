(:: pragma bea:global-element-parameter parameter="$eCConRequestControl" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataGT/eCConRequestControl/xsd/eCConRequestControl_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoDatosPlantillaResponse" location="../../GestionesEstadoCuenta/xsd/gestionesEstadoCuentaTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCConRequestControl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoDatosPlantilla/xq/consultaEstadoDatosPlantillaGTOut/";

declare function xf:consultaEstadoDatosPlantillaGTOut($eCConRequestControl as element(ns1:OutputParameters),
    $batch_id as xs:string)
    as element(ns0:consultaEstadoDatosPlantillaResponse) {
        <ns0:consultaEstadoDatosPlantillaResponse>
            <BATCH_ID>{ $batch_id }</BATCH_ID>
            {
                for $o_tipo in $eCConRequestControl/ns1:o_tipo
                return
                    <OPERATION_TYPE>{ data($o_tipo) }</OPERATION_TYPE>
            }
            {
                for $o_tabla in $eCConRequestControl/ns1:o_tabla
                return
                    <TABLE_NAME>{ data($o_tabla) }</TABLE_NAME>
            }
            {
                for $o_estado in $eCConRequestControl/ns1:o_estado
                return
                    <STATUS>{ data($o_estado) }</STATUS>
            }
            {
                for $o_atencion in $eCConRequestControl/ns1:o_atencion
                return
                    <PROCESS_DATE>{ data($o_atencion) }</PROCESS_DATE>
            }
            {
                for $o_evento in $eCConRequestControl/ns1:o_evento
                return
                    <CREATION_DATE>{ data($o_evento) }</CREATION_DATE>
            }
        </ns0:consultaEstadoDatosPlantillaResponse>
};

declare variable $eCConRequestControl as element(ns1:OutputParameters) external;
declare variable $batch_id as xs:string external;

xf:consultaEstadoDatosPlantillaGTOut($eCConRequestControl,
    $batch_id)