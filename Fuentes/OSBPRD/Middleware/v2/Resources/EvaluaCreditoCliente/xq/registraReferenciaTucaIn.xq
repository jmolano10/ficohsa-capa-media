(:: pragma bea:local-element-parameter parameter="$rEFERENCES" type="ns0:evaluaCreditoClienteRequest/BUREAUS/BUREAU/REFERENCES" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_TUCA_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_REFERENCIAS_TUCA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraReferenciaTucaIn/";

declare function xf:registraReferenciaTucaIn($rEFERENCES as element())
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                <ns1:pv_NumeroEvaluacion>{ $rEFERENCES }</ns1:pv_NumeroEvaluacion>
            }
        </ns1:InputParameters>
};

declare variable $rEFERENCES as element() external;

xf:registraReferenciaTucaIn($rEFERENCES)