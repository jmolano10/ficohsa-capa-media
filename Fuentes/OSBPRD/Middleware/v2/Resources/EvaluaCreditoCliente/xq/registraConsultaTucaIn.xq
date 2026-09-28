(:: pragma bea:local-element-parameter parameter="$qUERIES" type="ns1:evaluaCreditoClienteRequest/BUREAUS/BUREAU/QUERIES" location="../xsd/evaluaCreditoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/OriginacionesGT/xsd/BLAZE_BOM_CONSULTA_TUCA_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/BLAZE_BOM_CONSULTA_TUCA";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EvaluaCreditoCliente/xq/registraConsultaTucaIn/";

declare function xf:registraConsultaTucaIn($qUERIES as element())
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {

               <ns0:pv_NumeroEvaluacion>{ $qUERIES }</ns0:pv_NumeroEvaluacion>

            }
        </ns0:InputParameters>
};

declare variable $qUERIES as element() external;

xf:registraConsultaTucaIn($qUERIES)