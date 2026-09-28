xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/Remesas/ConsultaRemesaPorNombreBDRemesas/xsd/consultaRemesaPorNombreBDRemesas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesaPorNombreYMetodo/xq/consultaRemesaPorNombreBDRemesasHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRemesaPorNombreBDRemesas";

declare function xf:consultaRemesaPorNombreBDRemesasHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>
            {
		    	if (fn:string($outputParameters/ns0:O_MENSAJE_ERROR/text()) != "") then (
					"ERROR"
				) else (
					"SUCCESS"
				)
			}
            </successIndicator>
            {
                for $PV_ERROR in $outputParameters/ns0:O_MENSAJE_ERROR
                return
                    <messages>{ data($PV_ERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaRemesaPorNombreBDRemesasHeaderOut($outputParameters)