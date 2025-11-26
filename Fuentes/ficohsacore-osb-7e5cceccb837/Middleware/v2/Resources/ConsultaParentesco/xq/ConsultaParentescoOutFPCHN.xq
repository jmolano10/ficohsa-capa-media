(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/FPC/listadoParentesco/xsd/listadoParentescoFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaParentescoResponse" location="../xsd/consultaParentescoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultaParentescoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoParentescoFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaParentesco/xq/ConsultaParentescoOut/";

declare function xf:ConsultaParentescoOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaParentescoResponse) {
        <ns1:consultaParentescoResponse>
            <ns1:relationList>
                {
                    for $T_PARENTESCOS_ITEM in $outputParameters/ns0:T_PARENTESCOS/ns0:T_PARENTESCOS_ITEM
                    return
                        <ns1:relationItem>
                            {
                                for $COD_PARENTESCO in $T_PARENTESCOS_ITEM/ns0:COD_PARENTESCO
                                return
                                    <ns1:RELATION_CODE>{ data($COD_PARENTESCO) }</ns1:RELATION_CODE>
                            }
                            {
                                for $DES_PARENTESCO in $T_PARENTESCOS_ITEM/ns0:DES_PARENTESCO
                                return
                                    <ns1:RELATION_DESCRIPTION>{ data($DES_PARENTESCO) }</ns1:RELATION_DESCRIPTION>
                            }
                            <ns1:REVERSE_RELATION_CODE/>
                            <ns1:REVERSE_RELATION_DESCRIPTION/>
                        </ns1:relationItem>
                }
            </ns1:relationList>
        </ns1:consultaParentescoResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:ConsultaParentescoOut($outputParameters)