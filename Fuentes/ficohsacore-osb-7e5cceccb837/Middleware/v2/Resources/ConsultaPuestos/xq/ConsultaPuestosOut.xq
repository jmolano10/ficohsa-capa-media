(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoCargos/xsd/listadoCargosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaPuestosResponse" location="../xsd/consultaPuestosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoCargosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaPuestosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPuestos/xq/ConsultaPuestosOut/";

declare function xf:ConsultaPuestosOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaPuestosResponse) {
        <ns0:consultaPuestosResponse>
            <ns0:jobTitleList>
                {
                    for $PT_CARGOS_ITEM in $outputParameters/ns1:PT_CARGOS/ns1:PT_CARGOS_ITEM
                    where data($PT_CARGOS_ITEM/ns1:DESCRIPCION) = data($PT_CARGOS_ITEM/ns1:DESCRIPCION)
                    return
                        <ns0:jobTitleItem>
                            {
                                for $COD_CARGO in $PT_CARGOS_ITEM/ns1:COD_CARGO
                                return
                                    <ns0:JOBTITLE_CODE>{ data($COD_CARGO) }</ns0:JOBTITLE_CODE>
                            }
                            {
                                for $DESCRIPCION in $PT_CARGOS_ITEM/ns1:DESCRIPCION
                                return
                                    <ns0:JOBTITLE_DESCRIPTION>{ data($DESCRIPCION) }</ns0:JOBTITLE_DESCRIPTION>
                            }
                        </ns0:jobTitleItem>
                }
            </ns0:jobTitleList>
        </ns0:consultaPuestosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ConsultaPuestosOut($outputParameters)