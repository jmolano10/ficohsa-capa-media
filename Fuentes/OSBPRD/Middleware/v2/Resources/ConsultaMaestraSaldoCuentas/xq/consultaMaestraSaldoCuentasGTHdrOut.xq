(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/consultaMaestraSaldoCuenta/xsd/consultaMaestraSaldoCuenta_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaMaestraSaldoCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaMaestraSaldoCuentas/xq/consultaMaestraSaldoCuentasGTHdrOut/";

declare function xf:consultaMaestraSaldoCuentasGTHdrOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $PV_ERROR_CODE := string($outputParameters1/ns0:PV_ERROR_CODE/text())
                return
                	if ($PV_ERROR_CODE = 'SUCCESS')then(
                		<successIndicator>Success</successIndicator>
                	)else(
                		<successIndicator>{ $PV_ERROR_CODE }</successIndicator>,
		                <messages>{ data($outputParameters1/ns0:PV_ERROR_MESSAGE) }</messages>
                	)
                    
            }
        </ns1:ResponseHeader>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaMaestraSaldoCuentasGTHdrOut($outputParameters1)