xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$outputParameter" element="ns1:OutputParameters" location="../../../BusinessServices/INTFC/obtenerSituacionFinanciera/xsd/obtenerSituacionFinanciera_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaSituacionFinancieraResponse" location="../xsd/consultaSituacionFinancieraTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaSituacionFinanciera/xq/consultaSituacionFinancieraOut/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaSituacionFinancieraTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerSituacionFinanciera";

declare function xf:consultaSituacionFinancieraOut($outputParameter as element(ns1:OutputParameters))
    as element(ns0:consultaSituacionFinancieraResponse) {
 		<ns0:consultaSituacionFinancieraResponse>   
        	<ASSETS>
            {
            	for $asset in $outputParameter/ns1:PT_PROD_ACTIVOS_GRUPO/ns1:PT_PROD_ACTIVOS_GRUPO_ITEM
		        return
					<BALANCE>
						<CURRENCY>{ fn:string($asset/ns1:CODIGO_MONEDA/text()) }</CURRENCY>
						<TOTAL>{ fn:string($asset/ns1:SALDO_TOTAL/text()) }</TOTAL>
					</BALANCE>
					
            }
        	</ASSETS> 
        	<ASSETS_DETAILS>
            {
            	for $assetType in distinct-values($outputParameter/ns1:PT_DET_PROD_ACTIVOS/ns1:PT_PROD_ACTIVOS_GRUPO_ITEM/ns1:CODIGO_TIPO_PRODUCTO)
		        return
					<ASSET>
						<TYPE>{ $assetType }</TYPE>
						<BALANCES>
						{
							for $asset in $outputParameter/ns1:PT_DET_PROD_ACTIVOS/ns1:PT_PROD_ACTIVOS_GRUPO_ITEM[ns1:CODIGO_TIPO_PRODUCTO = $assetType]
							return
								<BALANCE>
									<CURRENCY>{ fn:string($asset/ns1:CODIGO_MONEDA/text()) }</CURRENCY>
									<AVAILABLE>{ fn:string($asset/ns1:SALDO_DISPONIBLE/text()) }</AVAILABLE>
									<TOTAL>{ fn:string($asset/ns1:SALDO_TOTAL/text()) }</TOTAL>
								</BALANCE>
						}							
						</BALANCES>
					</ASSET>
            }
        	</ASSETS_DETAILS>    
        	<LIABILITIES>
            {
            	for $liabilities in $outputParameter/ns1:PT_PROD_PASIVOS_GRUPO/ns1:PT_PROD_ACTIVOS_GRUPO_ITEM
		        return(
			        <BALANCE>
						<CURRENCY>{$liabilities/ns1:CODIGO_MONEDA/text()}</CURRENCY>
						<TOTAL>{$liabilities/ns1:SALDO_TOTAL/text()}</TOTAL>
					</BALANCE>
					)
            }
        	</LIABILITIES>
        	<LIABILITIES_DETAILS>
            {
            	for $liabilitiesType in distinct-values($outputParameter/ns1:PT_DET_PROD_PASIVOS/ns1:PT_PROD_ACTIVOS_GRUPO_ITEM/ns1:CODIGO_TIPO_PRODUCTO)
		        return(
			        <LIABILITY>
						<TYPE>{ $liabilitiesType }</TYPE>
						<BALANCES>
						{
							for $liabilities in $outputParameter/ns1:PT_DET_PROD_PASIVOS/ns1:PT_PROD_ACTIVOS_GRUPO_ITEM[ns1:CODIGO_TIPO_PRODUCTO = $liabilitiesType]
							return
								<BALANCE>
									<CURRENCY>{ fn:string($liabilities/ns1:CODIGO_MONEDA/text()) }</CURRENCY>
									<TOTAL>{ fn:string($liabilities/ns1:SALDO_TOTAL/text()) }</TOTAL>
								</BALANCE>	
						}						
						</BALANCES>
					</LIABILITY>
					)
            }
        	</LIABILITIES_DETAILS>            	        	     	  
        </ns0:consultaSituacionFinancieraResponse>
};

declare variable $outputParameter as element(ns1:OutputParameters) external;

xf:consultaSituacionFinancieraOut($outputParameter)
