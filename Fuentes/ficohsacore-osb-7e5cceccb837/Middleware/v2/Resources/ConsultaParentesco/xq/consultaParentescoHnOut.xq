(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../BusinessServices/Terceros/listadoParentescoTerceros/xsd/listadoParentescoTerceros_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaParentescoResponse" location="../xsd/consultaParentescoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ConsultaParentescoTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoParentescoTerceros";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaParentesco/xq/consultaParentescoHnOut/";

declare function xf:consultaParentescoHnOut($outputParameters1 as element(ns0:OutputParameters))
    as element(ns1:consultaParentescoResponse) {
        <ns1:consultaParentescoResponse>
            <ns1:relationList>
                <ns1:relationItem>
                    {
                        for $PARENTESCO_ITEM  in ($outputParameters1/ns0:T_PARENTESCO/ns0:PT_PARENTESCO_ITEM)  
                        return
                            (<ns1:relationItem>
                                          <ns1:RELATION_CODE>{ data($PARENTESCO_ITEM/ns0:COD_PARENTESCO) }</ns1:RELATION_CODE>
                                          <ns1:RELATION_DESCRIPTION>{ data($PARENTESCO_ITEM/ns0:DES_PARENTESCO) }</ns1:RELATION_DESCRIPTION>
                                          <ns1:REVERSE_RELATION_CODE/>
                                          <ns1:REVERSE_RELATION_DESCRIPTION/>
                            </ns1:relationItem>)
                    }
                 </ns1:relationItem>
            </ns1:relationList>
        </ns1:consultaParentescoResponse>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;

xf:consultaParentescoHnOut($outputParameters1)