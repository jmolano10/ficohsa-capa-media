<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
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

xf:consultaInformacionHUELLAGTIn($inscripcionesRENAP)]]></con:xquery>
    <con:dependency location="../../InscripcionesRENAP/xsd/inscripcionesRENAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/InscripcionesRENAP/xsd/inscripcionesRENAPTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaInformacionRENAP/xsd/consultaInformacionRENAPTypes"/>
    </con:dependency>
</con:xqueryEntry>