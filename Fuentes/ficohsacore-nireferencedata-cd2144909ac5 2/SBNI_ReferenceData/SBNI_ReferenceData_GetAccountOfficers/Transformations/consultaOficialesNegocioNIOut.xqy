xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://service.srvaplcobisgenerales.ecobis.cobiscorp";
(:: import schema at "../Schemas/services.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/referencedata";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/ReferenceDataInquiryTypes.xsd" ::)

declare namespace dto="http://dto.srvaplcobisentidades.ecobis.cobiscorp";
(:: import schema at "../Schemas/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd" ::)

declare variable $globalId as xs:string external;
declare variable $coreResponse as element() (:: schema-element(ns1:opConsultaOficialesRespuesta) ::) external;

declare function local:coreToRegional($globalId as xs:string, 
                                      $coreResponse as element() (:: schema-element(ns1:opConsultaOficialesRespuesta) ::)) 
                                      as element() (:: schema-element(ns2:getAccountOfficersResponse) ::) {
    <ns2:getAccountOfficersResponse>
        <StatusInfo>
           <Status>Success</Status>           
          <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>            
          <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
          <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        
       
        {
            for $oficial in $coreResponse/dto:oficial
            return
                <BussinessOfficers>
                    <OfficerCode>{ data($oficial/dto:codOficial) }</OfficerCode>
                    {
                        for $valOficial in $oficial/dto:valOficial
                        return
                            <OfficerName>{ data($valOficial) }</OfficerName>
                    }
                    {
                        for $codOficina in $oficial/dto:oficina/dto:codOficina
                        return
                            <BranchCode>{ data($codOficina) }</BranchCode>
                    }
                    {
                        for $valOficina in $oficial/dto:oficina/dto:valOficina
                        return
                            <BranchName>{ data($valOficina) }</BranchName>
                    }
                    <DeptoId>{ data($oficial/dto:codDepartamento) }</DeptoId>
                    {
                        for $valDepartamento in $oficial/dto:valDepartamento
                        return
                            <DeptoName>{ data($valDepartamento) }</DeptoName>
                    }
                </BussinessOfficers>
            }
      
    </ns2:getAccountOfficersResponse>
};

local:coreToRegional($globalId, $coreResponse)