xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://service.srvaplcobisgenerales.ecobis.cobiscorp";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/COBIS/GeneralService/SrvAplCobisGeneralesServices.xsd" ::)

declare namespace ns1="https://www.ficohsa.com/regional/referencedata";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/ReferenceDataInquiryTypes.xsd" ::)
declare namespace dto = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";


declare variable $serviceInput as element() (:: schema-element(ns1:getBankAgencies) ::) external;


declare function local:func( 
                            $serviceInput as element() (:: schema-element(ns1:getBankAgencies) ::)) 
                            as element() (:: schema-element(ns2:opConsultaAgenciasSolicitud) ::) {
    <ns2:opConsultaAgenciasSolicitud>
    
            <dto:contextoTransaccional>
                      <dto:codCanalOriginador>1</dto:codCanalOriginador>
            </dto:contextoTransaccional>
            <dto:oficina>
                {
                    for $BRANCH_CODE in $serviceInput/BranchCode
                    return
                        <dto:codOficina>{ data($BRANCH_CODE) }</dto:codOficina>
                }
            </dto:oficina>
    
    </ns2:opConsultaAgenciasSolicitud>
};

local:func($serviceInput)