xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $entrada as xs:string external;


declare function local:base64-encode($b as xs:integer*) as xs:integer* {
    
    let $table := ( 65 to  90,  (: A-Z :)
                    97 to 122,  (: a-z :)
                    48 to  57,  (: 0-9 :)
                    43, 47 )    (: + / :)
                    
    for $byte0 at $p in $b
    where $p mod 3 = 1
    return
      let $byte1 as xs:integer? := $b[$p + 1]
      let $byte2 as xs:integer? := $b[$p + 2]

      (: Convert the three bytes into four characters :)
      let $c0 := $table[$byte0 idiv 4 +1]
      let $c1 := $table[sum((($byte0 mod 4)*16, $byte1 idiv 16)) +1]
      let $c2 := if (empty($byte1)) then 61 (: pad with = :)
                 else $table[sum((($byte1 mod 16)*4, $byte2 idiv 64)) + 1]
      let $c3 := if (empty($byte2)) then 61 (: pad with = :)
                 else $table[$byte2 mod 64 + 1]
      return ($c0, $c1, $c2, $c3)
 
};

declare function local:func($entrada as xs:string) as xs:string {
   
   fn:codepoints-to-string( 
   local:base64-encode(fn:string-to-codepoints($entrada)))
    
 
};


local:func($entrada)