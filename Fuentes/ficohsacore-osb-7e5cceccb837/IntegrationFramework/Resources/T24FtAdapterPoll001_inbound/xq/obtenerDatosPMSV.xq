(:: pragma bea:global-element-parameter parameter="$t24FTAuthFlow" element="ns2:T24FTAuthFlow" location="../xsd/T24FicoTSPServices-T24FTAuthFlow.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/T24FicoTSPServices/T24FTAuthFlow";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtAdapterPoll001_inbound/xq/test/";

declare function xf:test($t24FTAuthFlow as element(ns2:T24FTAuthFlow))
    as element(*)? {
          
	    for $i in $t24FTAuthFlow/ns2:paymentDetailsList	    
	    where matches(string($i), 'PMSV.*B.*D.*E', 's') 
	    return             
	        <pmsv>
	    		<codigoCliente>{fn:replace(fn:normalize-space(fn:substring-before(fn:substring-after(string($i), 'PMSV'), 'B')),'\s+','')}</codigoCliente>
	    		<numeroLote>{fn:replace(fn:normalize-space(fn:substring-before(fn:substring-after(string($i), 'B'), 'D')),'\s+','')}</numeroLote>
	    		<fechaLote>{fn:replace(fn:normalize-space(fn:substring-before(fn:substring-after($i, 'D'), 'E')),'\s+','')}</fechaLote>
	    	</pmsv>
      
};

declare variable $t24FTAuthFlow as element(ns2:T24FTAuthFlow) external;

xf:test($t24FTAuthFlow)