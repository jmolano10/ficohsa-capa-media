(:: pragma bea:global-element-parameter parameter="$evaluaCreditoClienteRequest" element="ns0:evaluaCreditoClienteRequest" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_ENTRADA_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_ENTRADA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registroEntradaBlazeIn/";

declare function xf:registroEntradaBlazeIn($evaluaCreditoClienteRequest as element(ns0:evaluaCreditoClienteRequest))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:pv_NumeroEvaluacion>{ data($evaluaCreditoClienteRequest/ID) }</ns1:pv_NumeroEvaluacion>
            <ns1:pv_identidad>{ data($evaluaCreditoClienteRequest/CUSTOMER_ID) }</ns1:pv_identidad>
            <ns1:pv_fecha_nacimiento>{ xs:date(data($evaluaCreditoClienteRequest/DATE_OF_BIRTH)) }</ns1:pv_fecha_nacimiento>
            <ns1:pv_fecha_aplicacion>{ xs:date(data($evaluaCreditoClienteRequest/APPLICATION_DATE)) }</ns1:pv_fecha_aplicacion>
            <ns1:pv_ingresosMensuales>{ data($evaluaCreditoClienteRequest/MONTHLY_INCOME) }</ns1:pv_ingresosMensuales>
            <ns1:pv_sexo>
                {
                    if (fn:string($evaluaCreditoClienteRequest/GENDER/text()) = "M") then
                        (1)
                    else 
                        2
                }
</ns1:pv_sexo>
            <ns1:pv_tiempoResidenciaMeses>{ data($evaluaCreditoClienteRequest/RESIDENCE_TIME) }</ns1:pv_tiempoResidenciaMeses>
            <ns1:pv_TipoVivienda>{ data($evaluaCreditoClienteRequest/HOUSING_TYPE) }</ns1:pv_TipoVivienda>
            <ns1:pv_RechazoSIRC>{ data($evaluaCreditoClienteRequest/PRE_REJECTED) }</ns1:pv_RechazoSIRC>
            <ns1:pv_flagSirc>{ data($evaluaCreditoClienteRequest/FLAG_SIRC) }</ns1:pv_flagSirc>
            <ns1:pv_BuroScore>
                { 
            		if (xs:int($evaluaCreditoClienteRequest/BUREAUS/BUREAU[2]/SCORE_BURO) > 0) then
            		    xs:int($evaluaCreditoClienteRequest/BUREAUS/BUREAU[2]/SCORE_BURO)
            		else
            		   0
            	}
            	</ns1:pv_BuroScore>
            <ns1:pv_tipo_cambio>{ data($evaluaCreditoClienteRequest/EXCHANGE_RATE) }</ns1:pv_tipo_cambio>
            <ns1:pv_codigo_resultado/>
            <ns1:pv_desc_resultado/>
        </ns1:InputParameters>
};

declare variable $evaluaCreditoClienteRequest as element(ns0:evaluaCreditoClienteRequest) external;

xf:registroEntradaBlazeIn($evaluaCreditoClienteRequest)
