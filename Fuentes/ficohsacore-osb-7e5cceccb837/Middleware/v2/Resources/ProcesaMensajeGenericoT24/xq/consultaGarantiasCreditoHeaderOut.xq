xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PWS/consultaGarantiasCredito/xsd/consultaGarantiasCredito_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaGarantiasCreditoHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaGarantiasCredito";

declare function xf:consultaGarantiasCreditoHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $LV_RESPUESTA in $outputParameters/ns0:LV_RESPUESTA
                return
                    <successIndicator>
                    { 
	                    if (fn:string($outputParameters/ns0:LV_RESPUESTA/text()) = "SUCCESS") then (
	                    	"SUCCESS"
	                	) else 
	                    	"ERROR"
                    }
                    </successIndicator>
            }
            {
				if (fn:string($outputParameters/ns0:LV_RESPUESTA/text()) = "SUCCESS") then (
                    <messages>
                    {
                    	fn:concat("0|", fn:string($outputParameters/ns0:LV_RESPUESTA/text()))
                    }
                    </messages>
                ) else (
                	<messages>
                	{
                		fn:concat("1|", fn:string($outputParameters/ns0:LV_RESPUESTA/text()))
                	}
                	</messages>
                )
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaGarantiasCreditoHeaderOut($outputParameters)