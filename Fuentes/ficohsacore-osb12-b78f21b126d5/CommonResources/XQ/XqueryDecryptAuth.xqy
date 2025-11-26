xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare variable $entrada as xs:string external;

declare function local:base64-decode($b as xs:string) as xs:integer* {
    let $codepoints :=  string-to-codepoints($b)
    let $table := ( 65 to  90,  (: A-Z :)
                    97 to 122,  (: a-z :)
                    48 to  57,  (: 0-9 :)
                    43, 47 )    (: + / :)
    return
    for $ch at $p in $codepoints
    where $p mod 4 = 1
    return
      let $c0 as xs:integer? := (index-of($table, $ch) - 1)
      let $c1 as xs:integer? := (index-of($table, $codepoints[$p + 1]) - 1)
      let $c2 as xs:integer? := (index-of($table, $codepoints[$p + 2]) - 1)
      let $c3 as xs:integer? := (index-of($table, $codepoints[$p + 3]) - 1)
      
      (: Convert the three bytes into four characters :)
      let $byte0 := ($c0 * 4) + ($c1 idiv 16)
      
      let $byte1 := (($c1 mod 16) * 16) +  ($c2 idiv 4)  
      
      let $byte2 := ($c2 mod 4) * 64 + ($c3 mod 64)
                 
      return ($byte0, $byte1, $byte2)

};


declare function local:func($entrada as xs:string) as xs:string {
   
    fn:codepoints-to-string(local:base64-decode( $entrada ))
    
 
};

local:func($entrada)