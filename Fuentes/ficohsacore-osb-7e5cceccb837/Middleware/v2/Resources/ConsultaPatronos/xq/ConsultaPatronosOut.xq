(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoPatronos/xsd/listadoPatronosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPatronosResponse" location="../xsd/consultaPatronosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoPatronosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPatronosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPatronos/xq/ConsultaPatronosOut/";

declare function xf:ConsultaPatronosOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaPatronosResponse) {
        <ns0:consultaPatronosResponse>
            <ns0:employerList>
                {
                    for $PT_PATRONOS_ITEM in $outputParameters/ns1:PT_PATRONOS/ns1:PT_PATRONOS_ITEM
                    return
                        <ns0:employerItem>
                            {
                                for $COD_PATRONO in $PT_PATRONOS_ITEM/ns1:COD_PATRONO
                                return
                                    <ns0:EMPLOYER_CODE>{ data($COD_PATRONO) }</ns0:EMPLOYER_CODE>
                            }
                            {
                                for $DES_PATRONO in $PT_PATRONOS_ITEM/ns1:DES_PATRONO
                                return
                                    <ns0:EMPLOYER_NAME>{ data($DES_PATRONO) }</ns0:EMPLOYER_NAME>
                            }
                        </ns0:employerItem>
                }
            </ns0:employerList>
        </ns0:consultaPatronosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaPatronosOut($outputParameters)