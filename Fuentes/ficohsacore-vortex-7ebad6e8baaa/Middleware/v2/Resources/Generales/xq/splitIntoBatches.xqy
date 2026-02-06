xquery version "2004-draft" encoding "UTF-8";

(:: Versión base tomada de :)
(: (C) Vladimir Dyuzhev http://genericparallel.com GenericParallel is a simpler and a more functional wrapper over Split & Join facility. :)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/Generales/splitIntoBatches/";

declare function xf:splitIntoBatches($requests as element(*), $maxParallel as xs:int) as element() {
	
	<Batches>    
		{
	    let $elsize := count($requests/AGREEMENTS/AGREEMENT)
	    
	    let $num := fn:ceiling($elsize div $maxParallel) cast as xs:positiveInteger
	    
		for $idx in 1 to $num
		let $startPos := ($idx - 1) * $maxParallel + 1 
		let $endPos := $idx * $maxParallel
		return 
	        <Batch> 
	        {
	        	$requests/AGREEMENTS/AGREEMENT[fn:position() = ($startPos to $endPos)]
	        }
	        </Batch>
	    }
	</Batches>
};

declare variable $requests as element(*) external;
declare variable $maxParallel as xs:int external;

xf:splitIntoBatches($requests, $maxParallel)