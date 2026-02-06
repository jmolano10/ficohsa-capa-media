xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParametersIN" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaDiasNoHabiles/xsd/consultaDiasNoHabiles_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDiasNoHabiles/xq/consultaDiasNoHabilesHeaderOutGT/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/MSG_P_DIAS_NO_HABILES";

declare function xf:consultaDiasNoHabilesHeaderOutGT($outputParametersIN as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
       <ns1:ResponseHeader>
            <successIndicator>
	            {
		            if (data($outputParametersIN/ns0:PV_CODIGOMENSAJE) = "SUCCESS") then
		                ("Success")
		            else 
		                data($outputParametersIN/ns0:PV_CODIGOMENSAJE)
	            }
	        </successIndicator>
            {
                for $PV_DESCRIPCIONMENSAJE in $outputParametersIN/ns0:PV_DESCRIPCIONMENSAJE
                return
                    <messages>{ data($PV_DESCRIPCIONMENSAJE) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParametersIN as element(ns0:OutputParameters) external;

xf:consultaDiasNoHabilesHeaderOutGT($outputParametersIN)