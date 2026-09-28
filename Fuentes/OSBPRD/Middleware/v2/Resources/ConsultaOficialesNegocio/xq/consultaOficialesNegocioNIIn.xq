(:: pragma bea:global-element-parameter parameter="$consultaOficialesNegocio" element="ns2:consultaOficialesNegocio" location="../../../../Business_Resources/Core/consultaOficialesNegocio/consultaOficialesNegocioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:opConsultaOficialesSolicitud" location="../../../BusinessServices/CTS/generalService/xsd/services.xsd" ::)

declare namespace ns0 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaOficialesNegocioTypes";
declare namespace ns1 = "http://service.srvaplcobisgenerales.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaOficialesNegocio/xq/consultaOficialesNegocioNIIn/";

declare function xf:consultaOficialesNegocioNIIn($consultaOficialesNegocio as element(ns2:consultaOficialesNegocio))
    as element(ns1:opConsultaOficialesSolicitud) {
        <ns1:opConsultaOficialesSolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:oficial>
                {
                    for $OFFICER_CODE in $consultaOficialesNegocio/OFFICER_CODE 
                        where fn:string($OFFICER_CODE/text()) != ''
                        return
                            <ns0:codOficial>{ data($OFFICER_CODE) }</ns0:codOficial>
                }
                {
                    for $BRANCH_CODE in $consultaOficialesNegocio/BRANCH_CODE
                        where fn:string($BRANCH_CODE/text()) != ''
                        return
                            <ns0:oficina>
                                <ns0:codOficina>{ data($BRANCH_CODE) }</ns0:codOficina>
                            </ns0:oficina>
                }
            </ns0:oficial>
        </ns1:opConsultaOficialesSolicitud>
};

declare variable $consultaOficialesNegocio as element(ns2:consultaOficialesNegocio) external;

xf:consultaOficialesNegocioNIIn($consultaOficialesNegocio)