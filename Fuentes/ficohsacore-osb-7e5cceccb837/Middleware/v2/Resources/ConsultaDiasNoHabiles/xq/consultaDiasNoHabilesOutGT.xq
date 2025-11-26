xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParametersIN" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDiasNoHabiles/xsd/consultaDiasNoHabiles_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDiasNoHabilesResponse" location="../xsd/consultaDiasNoHabilesTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDiasNoHabiles/xq/consultaDiasNoHabilesOutGT/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MSG_P_DIAS_NO_HABILES";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDiasNoHabilesTypes";

declare function xf:consultaDiasNoHabilesOutGT($outputParametersIN as element(ns1:OutputParameters))
    as element(ns0:consultaDiasNoHabilesResponse) {
         <ns0:consultaDiasNoHabilesResponse>
            <NON_WORKING_DAYS>
                {
                    for $PT_FECHANOHABIL at $i in $outputParametersIN/ns1:PT_FECHANOHABIL/ns1:PT_FECHANOHABIL_ITEM
                    	return
                        <NON_WORKING_DAY>
							<DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($PT_FECHANOHABIL)) }</DATE>                    
                            <MODULE>{ data($outputParametersIN/ns1:PT_MODULOS/ns1:PT_MODULOS_ITEM[$i]) }</MODULE>                         
                            <STATUS>{ data($outputParametersIN/ns1:PT_ESTADOS/ns1:PT_ESTADOS_ITEM[$i]) }</STATUS>
                        </NON_WORKING_DAY>
                }
            </NON_WORKING_DAYS>
        </ns0:consultaDiasNoHabilesResponse>
};

declare variable $outputParametersIN as element(ns1:OutputParameters) external;

xf:consultaDiasNoHabilesOutGT($outputParametersIN)
