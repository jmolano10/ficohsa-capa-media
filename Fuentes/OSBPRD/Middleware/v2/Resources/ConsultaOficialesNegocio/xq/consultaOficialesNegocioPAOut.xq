(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/consultaOficialesNegocio/xsd/consultaOficialesNegocio_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaOficialesNegocioResponse" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaOficialesNegocio";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioPAOut/";

declare function xf:consultaOficialesNegocioPAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaOficialesNegocioResponse) {
        <ns1:consultaOficialesNegocioResponse>
            <ns1:consultaOficialesNegocioResponseType>
                {
                    for $P_INFO_OFICIAL_ITEM in $outputParameters/ns0:P_INFO_OFICIAL/ns0:P_INFO_OFICIAL_ITEM
                    return
                        <ns1:consultaOficialesNegocioResponseRecordType>
                            <OFFICER_CODE>{ data($P_INFO_OFICIAL_ITEM/ns0:CODIGO_EJECUTIVO) }</OFFICER_CODE>
                            <OFFICER_NAME>{ data($P_INFO_OFICIAL_ITEM/ns0:NOMBRE) }</OFFICER_NAME>
                            <BRANCH_CODE>{ data($P_INFO_OFICIAL_ITEM/ns0:CODIGO_AGENCIA) }</BRANCH_CODE>
                            <BRANCH_NAME>{ data($P_INFO_OFICIAL_ITEM/ns0:NOMBRE_AGENCIA) }</BRANCH_NAME>
                            <DEPARTMENT_ID>{ data($P_INFO_OFICIAL_ITEM/ns0:ID_DEPARTAMENTO) }</DEPARTMENT_ID>
                            <DEPARTMENT_NAME>{ data($P_INFO_OFICIAL_ITEM/ns0:NOMBRE_DEPARTAMENTO) }</DEPARTMENT_NAME>
                        </ns1:consultaOficialesNegocioResponseRecordType>
                }
            </ns1:consultaOficialesNegocioResponseType>
        </ns1:consultaOficialesNegocioResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaOficialesNegocioPAOut($outputParameters)