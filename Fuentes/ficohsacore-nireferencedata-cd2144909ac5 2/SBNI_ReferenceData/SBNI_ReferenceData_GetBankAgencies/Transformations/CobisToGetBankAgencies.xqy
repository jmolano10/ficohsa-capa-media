xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://service.srvaplcobisgenerales.ecobis.cobiscorp";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/COBIS/GeneralService/SrvAplCobisGeneralesServices.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/regional/referencedata";
(:: import schema at "../../SBNI_ReferenceData_Commons/Schemas/ReferenceDataInquiryTypes.xsd" ::)

declare namespace ref = "https://www.ficohsa.com/regional/common/referenceDataCommonType";

declare namespace dto = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";

declare variable $coreResponse as element() (:: schema-element(ns1:opConsultaAgenciasRespuesta) ::) external;
declare variable $globalId as xs:string external;

declare function local:funcCoreToRegional($coreResponse as element() (:: schema-element(ns1:opConsultaAgenciasRespuesta) ::), 
                                          $globalId as xs:string) 
                                          as element() (:: schema-element(ns2:getBankAgenciesResponse) ::) {
    <ns2:getBankAgenciesResponse>
    
    
    
    
        <StatusInfo>
              <Status>{              
              if (string($coreResponse/dto:contextoRespuesta/dto:codTipoRespuesta/text()) eq "0") then
                  "Success"
                else()
              }</Status>
                       
             <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>            
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{fn:data($globalId)}</GlobalId>
        </StatusInfo>
        {
           for $item in $coreResponse/dto:oficina
           return 
        <AgenciesDetails>
            <BranchCode>{data($item/dto:codOficina)}</BranchCode>
            <BranchName>{data($item/dto:valOficina)}</BranchName>
            <BranchType>{data($item/dto:valTipoOficina)}</BranchType>
            
           
            {
                let $valZonaGeografica := string($item/dto:valZonaGeografica/text())
                return
                if( $valZonaGeografica != '' )then(
                         <GeographicZone>{$valZonaGeografica}</GeographicZone>
                )else(
                         <GeographicZone/>
                )   
            }           
            
            
             <ServicesAvailable>                
                <Name>{'CHQPRINTZONE'}</Name>
                <Value>{'NONE'}</Value>                           
            </ServicesAvailable>
            
            
            
            <ServicesAvailable>
                <Service>
                    <Name>{'ALLOWSCHQBKPRINT'}</Name>
                    <Value>{'NONE'}</Value>
                </Service>
                <Service>
                    <Name>{'ALLOWSCASHIERCHQPRINT'}</Name>
                    <Value>{'NONE'}</Value>
                </Service>
                <Service>
                    <Name>{'CHQPRINTZONE'}</Name>
                    <Value>{'NONE'}</Value>
                </Service>               
            </ServicesAvailable>
            
        </AgenciesDetails>
        }
    </ns2:getBankAgenciesResponse>
};

local:funcCoreToRegional($coreResponse, $globalId)