(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/FPC/listadoDepartamentos/xsd/listadoDepartamentosFPC_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDepartamentosResponse" location="../../../../Business_Resources/direcciones/ConsultaDepartamentos/consultaDepartamentosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/listadoDepartamentosFPC";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDepartamentosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDepartamentos/xq/consultaDepartamentosFPCOut/";

declare function xf:consultaDepartamentosFPCOut($outputParameters as element(ns1:OutputParameters),
    $countryCode as xs:string)
    as element(ns0:consultaDepartamentosResponse) {
        <ns0:consultaDepartamentosResponse>
            <ns0:consultaDepartamentosResponseType>
                {
                    for $PT_PROVINCIAS_ITEM in $outputParameters/ns1:PT_PROVINCIAS/ns1:PT_PROVINCIAS_ITEM
                    return
                        <ns0:consultaDepartamentosResponseRecordType>
                            {
                                for $COD_PROVINCIA in $PT_PROVINCIAS_ITEM/ns1:COD_PROVINCIA
                                return
                                    <DEPT_CODE>{ data($COD_PROVINCIA) }</DEPT_CODE>
                            }
                            {
                                for $DES_PROVINCIA in $PT_PROVINCIAS_ITEM/ns1:DES_PROVINCIA
                                return
                                    <DEPT_NAME>{ data($DES_PROVINCIA) }</DEPT_NAME>
                            }
                            <COUNTRY_CODE>{ $countryCode }</COUNTRY_CODE>
                        </ns0:consultaDepartamentosResponseRecordType>
                }
            </ns0:consultaDepartamentosResponseType>
        </ns0:consultaDepartamentosResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $countryCode as xs:string external;

xf:consultaDepartamentosFPCOut($outputParameters,
    $countryCode)