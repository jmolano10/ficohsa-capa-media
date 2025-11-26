(:: pragma bea:global-element-parameter parameter="$evaluaCreditoClienteRequest" element="ns1:evaluaCreditoClienteRequest" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_CONSULTA_TUCA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_CONSULTA_TUCA";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraConsultaBlazeIn/";

declare function xf:registraConsultaBlazeIn($evaluaCreditoClienteRequest as element(ns1:evaluaCreditoClienteRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:pv_NumeroEvaluacion>{ data($evaluaCreditoClienteRequest/BUREAUS/BUREAU[1]/QUERIES/QUERY[1]/ID) }</ns0:pv_NumeroEvaluacion>
            <ns0:pv_TipoConsulta>{ data($evaluaCreditoClienteRequest/BUREAUS/BUREAU[1]/QUERIES/QUERY[1]/TYPE) }</ns0:pv_TipoConsulta>
            <ns0:pv_Entidad>{ data($evaluaCreditoClienteRequest/BUREAUS/BUREAU[1]/QUERIES/QUERY[1]/ENTITY) }</ns0:pv_Entidad>
            <ns0:pv_Fecha>{ data($evaluaCreditoClienteRequest/BUREAUS/BUREAU[1]/QUERIES/QUERY[1]/DATE) }</ns0:pv_Fecha>
            {
                for $MOTIVE in $evaluaCreditoClienteRequest/BUREAUS/BUREAU[1]/QUERIES/QUERY[1]/MOTIVE
                return
                    <ns0:pv_Motivo>{ data($MOTIVE) }</ns0:pv_Motivo>
            }
        </ns0:InputParameters>
        
};

declare variable $evaluaCreditoClienteRequest as element(ns1:evaluaCreditoClienteRequest) external;

xf:registraConsultaBlazeIn($evaluaCreditoClienteRequest)
