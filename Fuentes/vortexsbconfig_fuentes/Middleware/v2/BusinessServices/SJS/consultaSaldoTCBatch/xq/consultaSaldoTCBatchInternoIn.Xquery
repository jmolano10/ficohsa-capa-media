<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma  parameter="$groupByCountry" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaSaldoTCBatchInterno" location="../../../../Resources/ConsultaSaldoTCBatchInterno/xsd/consultaSaldoTCBatchInternoTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/ConsultaSaldoTCBatchInterno";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaSaldoTCBatch/xq/consultaSaldoTCBatchInternoIn/";

declare function xf:consultaSaldoTCBatchInternoIn($groupByCountry as element(*),
    $pointerCountry as xs:int)
    as element(ns0:ConsultaSaldoTCBatchInterno) {
        <ns0:ConsultaSaldoTCBatchInterno>
        	<REGION>{ fn:string($groupByCountry/COUNTRY[$pointerCountry]/ID/text()) }</REGION>
        	{
				let $cards := $groupByCountry/COUNTRY[$pointerCountry]/CARDS
				return
		    		<CARDS>
		    			{
			    			for $i in 1 to count($cards/CARD)
			    			return
				    			<CARD>
				    				<ID>{fn:string($cards/CARD[$i]/ID/text())}</ID>
									<PRODUCT_REGION>{fn:string($cards/CARD[$i]/PRODUCT_REGION/text())}</PRODUCT_REGION>
				    			</CARD>
		    			}
		    		</CARDS>
   			}
        </ns0:ConsultaSaldoTCBatchInterno>
};

declare variable $groupByCountry as element(*) external;
declare variable $pointerCountry as xs:int external;

xf:consultaSaldoTCBatchInternoIn($groupByCountry,
    $pointerCountry)]]></con:xquery>
    <con:dependency location="../../../../Resources/ConsultaSaldoTCBatchInterno/xsd/consultaSaldoTCBatchInternoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaSaldoTCBatchInterno/xsd/consultaSaldoTCBatchInternoTypes"/>
    </con:dependency>
</con:xqueryEntry>