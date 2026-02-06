xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace tp = "http://www.bea.com/wli/sb/transports";
declare namespace wls = "http://www.bea.com/wli/sb/stages/transform";

declare variable $input as xs:string external;

declare function local:func($input as xs:string) {

    <tp:headers>
        <wls:Authorization>{ concat("Bearer ", $input) }</wls:Authorization>
    </tp:headers>
};

local:func($input)