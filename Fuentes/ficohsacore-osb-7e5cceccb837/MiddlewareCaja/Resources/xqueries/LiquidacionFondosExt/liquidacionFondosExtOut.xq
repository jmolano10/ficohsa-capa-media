(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalResponse1" element="ns0:RetiroenmonedalocalResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns2:OutputParameters" location="../../xsds/RegistrarLiqFondosExt/registrarLiqFondosExt_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:liquidacionFondosExtResponse" location="../../xsds/LiquidacionFondosExt/LiquidacionFondosExt.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/registrarLiqFondosExt";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/liquidacionFondosExtTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/LiquidacionFondosExt/liquidacionFondosExtOut/";

declare function zeroReplace($value as xs:string?) as xs:string {
	if ($value = "" or fn:empty($value)) then (
		"0.00"
	) else (
		$value
	)
};

declare function xf:liquidacionFondosExtOut($retiroenmonedalocalResponse1 as element(ns0:RetiroenmonedalocalResponse),
    $outputParameters1 as element(ns2:OutputParameters),
    $assetId as xs:string,
    $balances as xs:string)
    as element(ns1:liquidacionFondosExtResponse) {
    	if (fn:string($retiroenmonedalocalResponse1/Status/successIndicator/text()) = "Success" and
    		fn:string($outputParameters1/ns2:PN_ERROR/text()) = "0" ) then (
	        <ns1:liquidacionFondosExtResponse>
	        	<ASSET_ID>{ $assetId }</ASSET_ID>
	            {
	                for $PV_NOMBRECONT in $outputParameters1/ns2:PV_NOMBRECONT
	                return
	                    <ASSET_NAME>{ data($PV_NOMBRECONT) }</ASSET_NAME>
	            }
	            <CURRENCY>HNL</CURRENCY>
	            <ASSET_AMOUNT>{ fn:string($outputParameters1/ns2:PN_MONTOTOTAL/text()) }</ASSET_AMOUNT>
	            <ASSET_DETAIL>
	            {
	            	let $balancesList := fn:tokenize($balances,"!")
	            	let $assets := fn:concat("@72@SALDO CUENTA        :  ",$balancesList[1],"!@72@SALDO A LIQUIDAR    : ",$balancesList[2])
	            	let $liabilities := fn:concat("@72@TOTAL OBLIGACIONES  :  ",zeroReplace($balancesList[3]),"!@72@VALOR APLICADO    : ",zeroReplace($balancesList[4]),"!@72@SALDO OBLIGACION    : ",zeroReplace($balancesList[5]))
	            	return
	            		fn:concat($assets,"!@72@---------------!",$liabilities)
	            }
	            </ASSET_DETAIL> 
	            {
	                let $result :=
	                    for $INPUTTER in $retiroenmonedalocalResponse1/TELLERType/gINPUTTER/INPUTTER
	                    return
	                        <INPUTTER>{ fn:tokenize(data($INPUTTER),"_")[2] }</INPUTTER>
	                return
	                    $result[1]
	            }
	            {
	                let $result :=
	                    for $DATETIME in $retiroenmonedalocalResponse1/TELLERType/gDATETIME/DATETIME
	                    return
	                        <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
	                return
	                    $result[1]
	            }
	        </ns1:liquidacionFondosExtResponse>
	    ) else (
	    	<ns1:liquidacionFondosExtResponse/>
	    )
};

declare variable $retiroenmonedalocalResponse1 as element(ns0:RetiroenmonedalocalResponse) external;
declare variable $outputParameters1 as element(ns2:OutputParameters) external;
declare variable $assetId as xs:string external;
declare variable $balances as xs:string external;

xf:liquidacionFondosExtOut($retiroenmonedalocalResponse1,
    $outputParameters1,
    $assetId,
    $balances)