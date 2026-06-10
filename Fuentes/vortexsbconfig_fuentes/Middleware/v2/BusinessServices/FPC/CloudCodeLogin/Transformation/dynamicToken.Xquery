<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace tp = "http://www.bea.com/wli/sb/transports";
declare namespace wls = "http://www.bea.com/wli/sb/stages/transform";

declare variable $input as xs:string external;

declare function local:func($input as xs:string) {

    &lt;tp:headers>
        &lt;wls:Authorization>{ concat("Bearer ", $input) }&lt;/wls:Authorization>
    &lt;/tp:headers>
};

local:func($input)</con:xquery>
</con:xqueryEntry>