(:: pragma bea:local-element-parameter parameter="$rEFERENCES" type="ns1:evaluaCreditoClienteRequest/BUREAUS/BUREAU/REFERENCES" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_REFERENCIAS_SIRC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_REFERENCIAS_SIRC";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraReferenciaSirc/";

declare function xf:registraReferenciaSirc($rEFERENCES as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                
			<ns0:pv_NumeroEvaluacion>{ $rEFERENCES }</ns0:pv_NumeroEvaluacion>
               
            }
        </ns0:InputParameters>
};

declare variable $rEFERENCES as element() external;

xf:registraReferenciaSirc($rEFERENCES)
