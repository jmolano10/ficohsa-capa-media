(:: pragma bea:global-element-parameter parameter="$inscripcionesRENAP" element="ns1:inscripcionesRENAP" location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionHUELLA" location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionRENAPTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/inscripcionesRENAPTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/InscripcionesRENAPGT/xq/consultaInformacionHUELLAGTIn/";

declare function xf:consultaInformacionHUELLAGTIn($inscripcionesRENAP as element(ns1:inscripcionesRENAP))
    as element(ns0:consultaInformacionHUELLA) {
        <ns0:consultaInformacionHUELLA>
        	{
        		let $fingerCode := fn:upper-case(fn:substring(data($inscripcionesRENAP/FINGER_CODE), 1, 5)) 
        	 	return 
		        	if($fingerCode = "RIGHT") then(
		        		<RIGHT_FINGER>{ data($inscripcionesRENAP/FOOTPRINT) }</RIGHT_FINGER>,
		            		<RIGHT_CODE>{ data($inscripcionesRENAP/FINGER_CODE) }</RIGHT_CODE>
		        	)else(
		        		<LEFT_FINGER>{ data($inscripcionesRENAP/FOOTPRINT) }</LEFT_FINGER>,
		            		<LEFT_CODE>{ data($inscripcionesRENAP/FINGER_CODE) }</LEFT_CODE>
		        	)
            }
            <CUI>{ data($inscripcionesRENAP/CUI) }</CUI>
        </ns0:consultaInformacionHUELLA>
};

declare variable $inscripcionesRENAP as element(ns1:inscripcionesRENAP) external;

xf:consultaInformacionHUELLAGTIn($inscripcionesRENAP)