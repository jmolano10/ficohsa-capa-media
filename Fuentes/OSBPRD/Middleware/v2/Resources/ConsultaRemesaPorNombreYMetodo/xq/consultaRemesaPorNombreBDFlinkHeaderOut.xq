xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ConsultarRemPorNombre/xsd/consultarRemPorNombre_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreBDFlinkHeaderOut/";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemPorNombre";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";

declare function xf:consultaRemesaPorNombreBDFlinkHeaderOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            <successIndicator>
            {
		    	if (fn:string($outputParameters/ns1:PN_ERROR/text()) != "0") then (
					"ERROR"
				) else (
					"SUCCESS"
				)
			}
            </successIndicator>
            {
                for $PV_ERROR in $outputParameters/ns1:PV_ERROR
                return
                    <messages>{ data($PV_ERROR) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaRemesaPorNombreBDFlinkHeaderOut($outputParameters)