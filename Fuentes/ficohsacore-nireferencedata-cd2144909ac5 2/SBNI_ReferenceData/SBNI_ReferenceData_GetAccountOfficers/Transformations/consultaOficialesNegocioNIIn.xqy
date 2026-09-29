xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://service.srvaplcobisgenerales.ecobis.cobiscorp";
(:: import schema at "../Schemas/services.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/regional/referencedata";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/ReferenceDataInquiryTypes.xsd" ::)

declare namespace dto="http://dto.srvaplcobisentidades.ecobis.cobiscorp";
(:: import schema at "../Schemas/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd" ::)

declare variable $regionalRequest as element() (:: schema-element(ns1:getAccountOfficers) ::) external;

declare function local:regionalToCore($regionalRequest as element() (:: schema-element(ns1:getAccountOfficers) ::)) as element() (:: schema-element(ns0:opConsultaOficialesSolicitud) ::) {
    <ns0:opConsultaOficialesSolicitud>
    
            <dto:contextoTransaccional>
                <dto:codCanalOriginador>1</dto:codCanalOriginador>
            </dto:contextoTransaccional>
            <dto:oficial>
                {
                    for $OFFICER_CODE in $regionalRequest/OfficerCode 
                        where fn:string($OFFICER_CODE/text()) != ''
                        return
                            <dto:codOficial>{ data($OFFICER_CODE) }</dto:codOficial>
                }
                {
                    for $BRANCH_CODE in $regionalRequest/BranchCode
                        where fn:string($BRANCH_CODE/text()) != ''
                        return
                            <dto:oficina>
                                <dto:codOficina>{ data($BRANCH_CODE) }</dto:codOficina>
                            </dto:oficina>
                }
            </dto:oficial>
    
    
    </ns0:opConsultaOficialesSolicitud>
};

local:regionalToCore($regionalRequest)