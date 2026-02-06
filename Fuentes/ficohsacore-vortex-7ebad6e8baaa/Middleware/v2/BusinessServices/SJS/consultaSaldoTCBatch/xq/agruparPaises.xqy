xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaSaldoTCBatch" element="ns0:sjConsultaSaldoTCBatch" location="../xsd/sjConsultaSaldoTCBatchTypes.xsd" ::)
(:: pragma  type="anyType" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaSaldoTCBatch";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldoTCBatch/xq/agruparPaises/";

declare function xf:agruparPaises($sjConsultaSaldoTCBatch as element(ns0:sjConsultaSaldoTCBatch))
    as element(*) {
    	let $countries := distinct-values($sjConsultaSaldoTCBatch/CARDS/CARD/REGION)
		return
        <COUNTRIES>
				{
					for $i in 1 to count($countries)
					return
						<COUNTRY>
							<ID>{$countries[$i]}</ID>		
							<CARDS>
								{
									for $card in  $sjConsultaSaldoTCBatch/CARDS/CARD
									where $card/REGION = $countries[$i]
									return
										<CARD>
											<ID>{fn:string($card/ID/text())}</ID>
											<PRODUCT_REGION>{fn:string($card/PRODUCT_REGION/text())}</PRODUCT_REGION>
								    	</CARD>
								}
							</CARDS>
		    			</COUNTRY>
				}
    		</COUNTRIES>
};

declare variable $sjConsultaSaldoTCBatch as element(ns0:sjConsultaSaldoTCBatch) external;

xf:agruparPaises($sjConsultaSaldoTCBatch)