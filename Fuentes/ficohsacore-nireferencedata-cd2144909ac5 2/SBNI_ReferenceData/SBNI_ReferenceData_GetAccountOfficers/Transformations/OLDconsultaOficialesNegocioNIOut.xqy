xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$opConsultaOficialesRespuesta" element="ns2:opConsultaOficialesRespuesta" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)
(:: pragma bea:global-element-return element="ns4:consultaOficialesNegocioResponse" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace ns1 = "http://dto2.commons.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioNIOut/";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace ns3 = "http://dto2.sdf.cts.cobis.cobiscorp.com";

declare function xf:consultaOficialesNegocioNIOut($opConsultaOficialesRespuesta as element(ns2:opConsultaOficialesRespuesta))
    as element(ns4:consultaOficialesNegocioResponse) {
        <ns4:consultaOficialesNegocioResponse>
            <ns4:consultaOficialesNegocioResponseType>
                {
                    for $oficial in $opConsultaOficialesRespuesta/ns0:oficial
                    return
                        <ns4:consultaOficialesNegocioResponseRecordType>
                            <OFFICER_CODE>{ data($oficial/ns0:codOficial) }</OFFICER_CODE>
                            {
                                for $valOficial in $oficial/ns0:valOficial
                                return
                                    <OFFICER_NAME>{ data($valOficial) }</OFFICER_NAME>
                            }
                            {
                                for $codOficina in $oficial/ns0:oficina/ns0:codOficina
                                return
                                    <BRANCH_CODE>{ data($codOficina) }</BRANCH_CODE>
                            }
                            {
                                for $valOficina in $oficial/ns0:oficina/ns0:valOficina
                                return
                                    <BRANCH_NAME>{ data($valOficina) }</BRANCH_NAME>
                            }
                            <DEPARTMENT_ID>{ data($oficial/ns0:codDepartamento) }</DEPARTMENT_ID>
                            {
                                for $valDepartamento in $oficial/ns0:valDepartamento
                                return
                                    <DEPARTMENT_NAME>{ data($valDepartamento) }</DEPARTMENT_NAME>
                            }
                        </ns4:consultaOficialesNegocioResponseRecordType>
                }
            </ns4:consultaOficialesNegocioResponseType>
        </ns4:consultaOficialesNegocioResponse>
};

declare variable $opConsultaOficialesRespuesta as element(ns2:opConsultaOficialesRespuesta) external;

xf:consultaOficialesNegocioNIOut($opConsultaOficialesRespuesta)