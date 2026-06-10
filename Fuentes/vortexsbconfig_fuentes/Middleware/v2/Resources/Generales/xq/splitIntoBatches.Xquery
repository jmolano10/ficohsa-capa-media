<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "UTF-8";

(:: Versión base tomada de :)
(: (C) Vladimir Dyuzhev http://genericparallel.com GenericParallel is a simpler and a more functional wrapper over Split &amp; Join facility. :)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/splitIntoBatches/";

declare function xf:splitIntoBatches($requests as element(*), $maxParallel as xs:int) as element() {
	
	&lt;Batches>    
		{
	    let $elsize := count($requests/AGREEMENTS/AGREEMENT)
	    
	    let $num := fn:ceiling($elsize div $maxParallel) cast as xs:positiveInteger
	    
		for $idx in 1 to $num
		let $startPos := ($idx - 1) * $maxParallel + 1 
		let $endPos := $idx * $maxParallel
		return 
	        &lt;Batch> 
	        {
	        	$requests/AGREEMENTS/AGREEMENT[fn:position() = ($startPos to $endPos)]
	        }
	        &lt;/Batch>
	    }
	&lt;/Batches>
};

declare variable $requests as element(*) external;
declare variable $maxParallel as xs:int external;

xf:splitIntoBatches($requests, $maxParallel)</con:xquery>
</con:xqueryEntry>