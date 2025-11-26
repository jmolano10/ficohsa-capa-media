(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/consultaDiasNoHabiles/xsd/consultaDiasNoHabiles_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDiasNoHabilesResponse" location="../xsd/consultaDiasNoHabilesTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDiasNoHabiles";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDiasNoHabilesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDiasNoHabiles/xq/consultaDiasNoHabilesOut/";

declare function xf:consultaDiasNoHabilesOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaDiasNoHabilesResponse) {
        <ns1:consultaDiasNoHabilesResponse>
            <NON_WORKING_DAYS>
                {
                    for $PT_FECHANOHABIL at $i in $outputParameters/ns0:PT_FECHANOHABIL/ns0:ITEM
                    	return
                        <NON_WORKING_DAY>
							<DATE>{ fn-bea:dateTime-to-string-with-format("yyyyMMdd", data($PT_FECHANOHABIL)) }</DATE>                    
                            <MODULE>{ data($outputParameters/ns0:PT_MODULOS/ns0:ITEM[$i]) }</MODULE>                         
                            <STATUS>{ data($outputParameters/ns0:PT_ESTADOS/ns0:ITEM[$i]) }</STATUS>
                        </NON_WORKING_DAY>
                }
            </NON_WORKING_DAYS>
        </ns1:consultaDiasNoHabilesResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDiasNoHabilesOut($outputParameters)