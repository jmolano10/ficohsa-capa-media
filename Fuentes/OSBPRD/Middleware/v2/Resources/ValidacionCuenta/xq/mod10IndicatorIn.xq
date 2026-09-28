xquery version "1.0" encoding "Cp1252";
(:: pragma  parameter="$ResponseEvaluaCuentaAbanks" type="xs:anyType" ::)

declare namespace con = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/mod10IndicatorIn/";

declare function xf:mod10IndicatorIn($ResponseEvaluaCuentaAbanks as element(*),
    $index as xs:integer){
    
    for $ITEM at $i in $ResponseEvaluaCuentaAbanks/con:EvaluaCuentaAbanksTypeResponse[$index]/con:MOD10_INDICATOR
    return data($ITEM)
    
};

declare variable $ResponseEvaluaCuentaAbanks as element(*) external;
declare variable $index as xs:integer external;

xf:mod10IndicatorIn($ResponseEvaluaCuentaAbanks,
    $index)