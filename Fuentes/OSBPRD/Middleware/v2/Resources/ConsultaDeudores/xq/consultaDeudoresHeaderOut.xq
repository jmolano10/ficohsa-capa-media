(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABK/consultarDeudoresCliente/xsd/consultarDeudoresCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarDeudoresCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeudores/xq/consultaDeudoresHeaderOut/";

declare function xf:consultaDeudoresHeaderOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $PV_CODRESPUESTA in $outputParameters/ns0:PV_CODRESPUESTA
                return
                    <successIndicator>
                    	{ 
	                    	if (data($PV_CODRESPUESTA) = "SUCCESS") then
	                    		"Success"
	                    	else
	                    		data($PV_CODRESPUESTA)
                    	}
                    </successIndicator>
            }
            {
                for $PV_MSJRESPUESTA in $outputParameters/ns0:PV_MSJRESPUESTA
                return
                    <messages>{ data($PV_MSJRESPUESTA) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaDeudoresHeaderOut($outputParameters)