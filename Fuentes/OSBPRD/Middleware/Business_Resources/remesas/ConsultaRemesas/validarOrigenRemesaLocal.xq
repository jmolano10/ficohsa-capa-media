(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/validarOrigenRemesaLocal/";

declare function xf:validarOrigenRemesaLocal($outputParameters1 as element(ns0:OutputParameters))
    as xs:string {
        if (fn:string($outputParameters1/ns0:ERROR_CODE/text()) = "SUCCESS") then (
	        data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[1]/ns0:VALUE)
        ) else
        (
        	fn:string($outputParameters1/ns0:ERROR_CODE/text())
        )
        
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:validarOrigenRemesaLocal($outputParameters1)