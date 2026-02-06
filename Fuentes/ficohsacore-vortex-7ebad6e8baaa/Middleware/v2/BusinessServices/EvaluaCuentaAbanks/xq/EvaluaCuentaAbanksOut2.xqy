xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:EvaluaCuentaAbanksTypeResponse" location="../xsd/EvaluaCuentaAbanks.xsd" ::)

declare namespace ns0 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluaCuentaAbanks/EvaluaCuentaAbanksOut2/";

declare function xf:EvaluaCuentaAbanksOut2($cuenta as xs:string,
    $boolResponse as xs:string)
    as element(ns0:EvaluaCuentaAbanksTypeResponse) {
        <ns0:EvaluaCuentaAbanksTypeResponse>
            <ns0:ACCOUNT_ID>{ $cuenta }</ns0:ACCOUNT_ID>
            <ns0:MOD10_INDICATOR>{ $boolResponse }</ns0:MOD10_INDICATOR>
        </ns0:EvaluaCuentaAbanksTypeResponse>
};

declare variable $cuenta as xs:string external;
declare variable $boolResponse as xs:string external;

xf:EvaluaCuentaAbanksOut2($cuenta,
    $boolResponse)