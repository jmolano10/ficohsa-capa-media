xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKGT/consultaActivosCliente/xsd/consultaActivosCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaActivosCliente/xq/sjConsultaActivosClienteHeaderOut/";

declare function xf:sjConsultaActivosClienteHeaderOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                for $PV_ERROR_CODE in $outputParameters1/ns1:OutputParametersDepositos/ns1:PV_ERROR_CODE,
                    $PV_ERROR_CODE0 in $outputParameters1/ns1:OutputParametersCuentas/ns1:PV_ERROR_CODE
                return
                
               if ((fn:string($PV_ERROR_CODE) = "SUCCESS") and (fn:string($PV_ERROR_CODE0) = "SUCCESS")) then (
                	<successIndicator>{data($PV_ERROR_CODE)}</successIndicator>
                ) elseif((fn:string($PV_ERROR_CODE) = "SUCCESS") and (fn:string($PV_ERROR_CODE0) != "SUCCESS")) then (
                	<successIndicator>{data($PV_ERROR_CODE)}</successIndicator>
                )elseif((fn:string($PV_ERROR_CODE) != "SUCCESS") and (fn:string($PV_ERROR_CODE0) = "SUCCESS")) then (
                	<successIndicator>{data($PV_ERROR_CODE0)}</successIndicator>
                )else (
                <successIndicator>{data($PV_ERROR_CODE)}</successIndicator>
                )
            }
			{
               	 for $OutputParametersDepositos in $outputParameters1/ns1:OutputParametersDepositos/ns1:PV_ERROR_MESSAGE union $outputParameters1/ns1:OutputParametersCuentas/ns1:PV_ERROR_MESSAGE
                return
                if ((fn:string($outputParameters1/ns1:OutputParametersDepositos/ns1:PV_ERROR_CODE) = "ERROR") and (fn:string($outputParameters1/ns1:OutputParametersCuentas/ns1:PV_ERROR_CODE) = "ERROR")) then (
                    <messages>{ data($OutputParametersDepositos) }</messages>
                    )
				else(
                  <messages></messages>
                  	)
			}
           
        </ns0:ResponseHeader>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:sjConsultaActivosClienteHeaderOut($outputParameters1)