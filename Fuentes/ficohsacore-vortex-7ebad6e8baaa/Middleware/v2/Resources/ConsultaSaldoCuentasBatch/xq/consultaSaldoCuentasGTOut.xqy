xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaSaldoCuentasBatch" element="ns0:consultaSaldoCuentasBatch" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/Alertas/consultaSaldoCuentas/xsd/consultaSaldoCuentas_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSaldoCuentasBatchResponse" location="../../AlertasProductos/xsd/alertasProductosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/alertasProductosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaSaldoCuentas_db";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSaldoCuentasBatch/xq/consultaSaldoCuentasHNOut/";

declare function xf:consultaSaldoCuentasHNOut($consultaSaldoCuentasBatch as element(ns0:consultaSaldoCuentasBatch),
    $outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaSaldoCuentasBatchResponse) {
        <ns0:consultaSaldoCuentasBatchResponse>
        	<ACCOUNTS>
            	{
                    for $i in (1 to count($consultaSaldoCuentasBatch/ACCOUNTS/ACCOUNT))
                    	return
                        	<ACCOUNT>
                            	<ID>{ data($consultaSaldoCuentasBatch/ACCOUNTS/ACCOUNT[$i]/ID) }</ID>
                                {
                                	for $currency in $outputParameters/ns1:P_CODIGO_MONEDA/ns1:P_CODIGO_MONEDA_ITEM[$i]
                                    return
                                    	if(string($currency) != '')then(
                                    		<CURRENCY>{ data($currency) }</CURRENCY>
                                    	)else()
                                }
                            	{
                                	for $availableBalance in $outputParameters/ns1:P_SALDO_DISPONIBLE/ns1:P_NUMERO_PRODUCTO_ITEM[$i]
                                    return
                                    	if(string($availableBalance) != '')then(
                                    		<AVAILABLE_BALANCE>{ data($availableBalance) }</AVAILABLE_BALANCE>
                                    	)else()
                                }
                            	{
                                	for $totalBalance in $outputParameters/ns1:P_SALDO_TOTAL/ns1:P_NUMERO_PRODUCTO_ITEM[$i]
                                    return
                                    	if(string($totalBalance) != '')then(
                                    		<TOTAL_BALANCE>{ data($totalBalance) }</TOTAL_BALANCE>
                                    	)else()
                                }
                                <SOURCE_BANK>{ data($consultaSaldoCuentasBatch/ACCOUNTS/ACCOUNT[$i]/PRODUCT_REGION) }</SOURCE_BANK>
                            	{
                                	for $successIndicator in $outputParameters/ns1:P_CODIGO_MSJ_PRD/ns1:P_NUMERO_PRODUCTO_ITEM[$i]
                                    return
                                    	<SUCCESS_INDICATOR>{ data($successIndicator)}</SUCCESS_INDICATOR>
                                }
                            	{
                                	for $errorMessage in $outputParameters/ns1:P_DESC_MSJ_PRD/ns1:P_DESC_MSJ_PRD_ITEM[$i]
                                    return
                                    	if(string($errorMessage) != '')then(
                                    		<ERROR_MESSAGE>{ data($errorMessage) }</ERROR_MESSAGE>
                                    	)else()
                                }
                        	</ACCOUNT>
             	}
          	</ACCOUNTS>
        </ns0:consultaSaldoCuentasBatchResponse>
};

declare variable $consultaSaldoCuentasBatch as element(ns0:consultaSaldoCuentasBatch) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaSaldoCuentasHNOut($consultaSaldoCuentasBatch,
    $outputParameters)