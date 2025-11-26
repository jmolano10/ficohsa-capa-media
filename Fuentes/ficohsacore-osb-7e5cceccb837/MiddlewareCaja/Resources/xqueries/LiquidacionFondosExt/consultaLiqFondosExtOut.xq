(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../xsds/ConsultarLiqFondosExt/consultarLiqFondosExt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaFondosExtResponse" location="../../xsds/LiquidacionFondosExt/LiquidacionFondosExt.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarLiqFondosExt";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidacionFondosExtTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/consultaLiqFondosExtOut/";

declare function zeroReplace($value as xs:string?) as xs:string {
	if ($value = "" or fn:empty($value)) then (
		"0.00"
	) else (
		$value
	)
};

declare function xf:consultaLiqFondosExtOut($outputParameters1 as element(ns0:OutputParameters),
	$assetId as xs:string)
    as element(ns1:consultaFondosExtResponse) {
    	if (fn:string($outputParameters1/ns0:PN_ERROR/text()) = "0") then (
	        <ns1:consultaFondosExtResponse>
	        	<ASSET_ID>{ $assetId }</ASSET_ID>
	            {
	                for $PV_NOMBRECONT in $outputParameters1/ns0:PV_NOMBRECONT
	                return
	                    <ASSET_NAME>{ data($PV_NOMBRECONT) }</ASSET_NAME>
	            }
	            <CURRENCY>HNL</CURRENCY>
	            <ASSET_AMOUNT>{ fn:string($outputParameters1/ns0:PN_MONTOTOTAL/text()) }</ASSET_AMOUNT>
	            {
	            	let $header1 := "!@20@DETALLE DE CUENTAS CONTINENTAL!!@70@"
	            	let $header2 := "!!@20@DETALLE DE CUENTAS FICOHSA!!@70@"
	            	let $balancesList := fn:tokenize(data($outputParameters1/ns0:PV_CUENTASCONT),"!")
	            	let $contAssets := fn:concat("@70@SALDO CUENTA        :  ",$balancesList[1],"!@70@SALDO A LIQUIDAR    : ",$balancesList[2])
	            	let $contLiabilities := fn:concat("!@70@TOTAL OBLIGACIONES  :  ",zeroReplace($balancesList[3]),"!@70@VALOR APLICADO    : ",zeroReplace($balancesList[4]),"!@70@SALDO OBLIGACION    : ",zeroReplace($balancesList[5]))
	            	let $contDetails := fn:concat($contAssets,"!@70@--------------------",$contLiabilities)
	            	let $ficoAccounts := fn:replace(data($outputParameters1/ns0:PV_CUENTASFICOHSA),"\*","!@70@")
	            	return
					<ASSET_DETAIL>{ fn:concat($header1,$contDetails,$header2, $ficoAccounts) }</ASSET_DETAIL>
	            }
	        </ns1:consultaFondosExtResponse>
	        
	    ) else (
	    	<ns1:consultaFondosExtResponse/>
	    )
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $assetId as xs:string external;

xf:consultaLiqFondosExtOut($outputParameters1,
	$assetId)