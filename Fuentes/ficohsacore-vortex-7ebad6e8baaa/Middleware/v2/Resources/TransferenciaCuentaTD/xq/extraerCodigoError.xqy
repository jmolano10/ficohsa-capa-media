xquery version "2004-draft";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciaCuentaTD/xq/extraerCodigoError/";

declare function get-matches($string as xs:string? ,
    $regex as xs:string) as xs:string* {
	get-matches-and-non-matches($string, $regex)/self::match
 }; 	
 
declare function get-matches-and-non-matches($string as xs:string? ,
    $regex as xs:string)  as element()* {

	let $iomf := index-of-match-first($string, $regex)
	return
		if (empty($iomf)) then 
			<non-match>{$string}</non-match>
   		else
   			if ($iomf > 1) then (
   				<non-match>{substring($string,1,$iomf - 1)}</non-match>,
         		get-matches-and-non-matches(substring($string, $iomf), $regex))
   			else
   				let $length := string-length($string) - string-length(replace-first($string, $regex,''))
   				return (
   					<match>{substring($string,1,$length)}</match>,
           			if (string-length($string) > $length) then 
           				get-matches-and-non-matches(substring($string,$length + 1),$regex)
           			else ()
           		)
} ;
 
 declare function replace-first($arg as xs:string?,
	$pattern as xs:string,
	$replacement as xs:string) as xs:string {

	replace($arg, concat('(^.*?)', $pattern),
             concat('$1',$replacement))
 };
 
 declare function index-of-match-first($arg as xs:string?,
	$pattern as xs:string) as xs:integer? {

	if (matches($arg, $pattern)) then 
		string-length(tokenize($arg, $pattern)[1]) + 1
  	else ()
 };

declare function xf:extraerCodigoError($validationMessage as xs:string)
    as xs:string {
       		 let $regex := 'FF-\d{4}'
       		 
      		 let $errorCode := get-matches($validationMessage, $regex)[1]
      		 return
      			if(string($errorCode) = '') then(
      				'ERROR'
      			) 
      			else (
      				concat('260000', '-', $errorCode)
      			)
};

declare variable $validationMessage as xs:string external;

xf:extraerCodigoError($validationMessage)