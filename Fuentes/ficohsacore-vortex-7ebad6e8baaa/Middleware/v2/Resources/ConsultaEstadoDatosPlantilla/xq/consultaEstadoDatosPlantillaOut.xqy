xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/MasterData/eCConRequestControl/xsd/eCConRequestControl_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaEstadoDatosPlantillaResponse" location="../../GestionesEstadoCuenta/xsd/gestionesEstadoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCConRequestControl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoDatosPlantilla/xq/consultaEstadoDatosPlantillaOut/";

declare function xf:consultaEstadoDatosPlantillaOut($outputParameters1 as element(ns1:OutputParameters),
    $batch_id as xs:string)
    as element(ns0:consultaEstadoDatosPlantillaResponse) {
        <ns0:consultaEstadoDatosPlantillaResponse>
            <BATCH_ID>{ $batch_id }</BATCH_ID>
            {
                for $o_tipo in $outputParameters1/ns1:o_tipo
                return
                    <OPERATION_TYPE>{ data($o_tipo) }</OPERATION_TYPE>
            }
            {
                for $o_tabla in $outputParameters1/ns1:o_tabla
                return
                    <TABLE_NAME>{ data($o_tabla) }</TABLE_NAME>
            }
            {
                for $o_estado in $outputParameters1/ns1:o_estado
                return
                    <STATUS>{ data($o_estado) }</STATUS>
            }
            {
                for $o_atencion in $outputParameters1/ns1:o_atencion
                return
                	if(string($o_atencion/text()) != '') then( 
						<PROCESS_DATE>{data($o_atencion) }</PROCESS_DATE>
					) else()
			}
			{								
                for $o_evento in $outputParameters1/ns1:o_evento
                return
                if(string($o_evento/text()) != '') then( 
						<CREATION_DATE>{ data($o_evento) }</CREATION_DATE>
					) else()
            }
        </ns0:consultaEstadoDatosPlantillaResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;
declare variable $batch_id as xs:string external;

xf:consultaEstadoDatosPlantillaOut($outputParameters1,
    $batch_id)