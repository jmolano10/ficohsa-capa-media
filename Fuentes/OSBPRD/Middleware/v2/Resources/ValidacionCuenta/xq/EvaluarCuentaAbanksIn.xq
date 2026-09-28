(:: pragma bea:global-element-return element="ns0:EvaluaCuentaAbanksTypeRequest" location="../../../BusinessServices/EvaluaCuentaAbanks/xsd/EvaluaCuentaAbanks.xsd" ::)

declare namespace ns0 = "EvaluaCuentaAbanks";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/validacionCuenta/ValidacionCuenta2.0/EvaluarCuentaAbanksIn/";

declare function xf:EvaluarCuentaAbanksIn($accountNumber as xs:string)
    as element(ns0:EvaluaCuentaAbanksTypeRequest) {
        <ns0:EvaluaCuentaAbanksTypeRequest>
            <ns0:ACCOUNT_ID>{ $accountNumber }</ns0:ACCOUNT_ID>
        </ns0:EvaluaCuentaAbanksTypeRequest>
};

declare variable $accountNumber as xs:string external;

xf:EvaluarCuentaAbanksIn($accountNumber)