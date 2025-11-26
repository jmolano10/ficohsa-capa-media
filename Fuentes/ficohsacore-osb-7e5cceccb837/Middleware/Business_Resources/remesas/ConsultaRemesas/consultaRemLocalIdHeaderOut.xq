(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../Resoruces/ConsultarRemLocalId/consultarRemLocalId_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalIdHeaderOut/";

declare function xf:consultaRemLocalIdHeaderOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>
            {
		    	if (fn:string($outputParameters1/ns0:PV_ERROR/text()) != "") then (
					"ERROR"
				) else (
					"SUCCESS"
				)
			}
            </successIndicator>
            {
                for $PV_ERROR in $outputParameters1/ns0:PV_ERROR
                return
                    <messages>{ data($PV_ERROR) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaRemLocalIdHeaderOut($outputParameters1)