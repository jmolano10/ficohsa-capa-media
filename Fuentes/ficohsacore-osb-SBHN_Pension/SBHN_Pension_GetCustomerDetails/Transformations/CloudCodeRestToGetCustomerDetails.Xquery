<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="https://www.ficohsa.com/honduras/pension";
(:: import schema at "../Schemas/CustomerLocatorFavoritesTypes.xsd", 
                     "../Schemas/CustomerWorkTypes.xsd", 
                     "../Schemas/GetCustomerDetailsTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $demographicResponse as element() (:: schema-element(ns1:demograficosResponse) ::) external;
declare variable $workResponse as element()? (:: schema-element(ns2:customerWorkResponse) ::) external;
declare variable $favoritesResponse as element()? (:: schema-element(ns2:customerLocatorFavoritesResponse) ::) external;
declare variable $globalId as xs:string external;

declare function local:func($demographicResponse as element() (:: schema-element(ns1:demograficosResponse) ::), 
                            $workResponse as element()? (:: schema-element(ns2:customerWorkResponse) ::), 
                            $favoritesResponse as element()? (:: schema-element(ns2:customerLocatorFavoritesResponse) ::),
                            $globalId as xs:string)
                            as element() (:: schema-element(ns2:getCustomerDetailsResponse) ::) {
    <ns2:getCustomerDetailsResponse>
        <StatusInfo>
            <Status>Success</Status>
            <TransactionId></TransactionId>
            <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
            <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
            <GlobalId>{$globalId}</GlobalId>
        </StatusInfo>
        <IdentificationInfo>
		{
		   for $item in $demographicResponse/ns1:datos/ns1:persona
		   return
            <LegalIdentificationItem>
              <LegalDocumentName>{fn:data($item/ns1:tipoIdentificacion)}</LegalDocumentName> 
              <LegalId>{fn:data($item/ns1:identificacion)}</LegalId>
              <ExpirationDate>{fn:data($item/ns1:fechaVencimiento)}</ExpirationDate>
            </LegalIdentificationItem>
		}
        </IdentificationInfo>
        <GivenNames>{
          fn-bea:trim(
            fn:concat(
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:primerNombre),
              ' ',
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:segundoNombre)
            )
          )
        }</GivenNames>
        <FamilyName>{
          fn-bea:trim(
            fn:concat(
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:primerApellido),
              ' ',
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:segundoApellido)
            )
          )
        }</FamilyName>
        <FullName>{
          fn-bea:trim(
            fn:concat(
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:primerNombre),
              ' ',
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:segundoNombre),
              ' ',
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:primerApellido),
              ' ',
              fn:data($demographicResponse/ns1:datos/ns1:persona/ns1:segundoApellido)
            )
          )
        }</FullName>
        {
          for $DateOfBirth in $demographicResponse/ns1:datos/ns1:persona/ns1:fechaNacimiento
          return
          <DateOfBirth>{fn:data($DateOfBirth)}</DateOfBirth>
        }
        {
          for $currentEmployee in $demographicResponse/ns1:datos/ns1:patrono/ns1:razonSocial
          return
          <EmployersName>{fn:data($currentEmployee)}</EmployersName>
        }
        {
          if(fn:exists($favoritesResponse/datos/localizadores)) then (
            <PhoneInfo>
            {
              for $itemHome in $favoritesResponse/datos/localizadores/residencial
              return(
                <PhoneNumberItem>
                  <PhoneLocation>HOME</PhoneLocation>
                  <PhoneType>{fn:data($itemHome/tipoLocalizador)}</PhoneType>
                  <PhoneAreaCode>{fn:data($itemHome/codigoAreaCelular)}</PhoneAreaCode>
                  <PhoneNumber>{fn:data($itemHome/numeroCelular)}</PhoneNumber>
                </PhoneNumberItem>
              )
            }
		    {
              for $itemWork in $favoritesResponse/datos/localizadores/laboral
              return(
                <PhoneNumberItem>
                  <PhoneLocation>WORK</PhoneLocation>
                  <PhoneType>{fn:data($itemWork/tipoLocalizador)}</PhoneType>
                  <PhoneAreaCode>{fn:data($itemWork/codigoAreaCelular)}</PhoneAreaCode>
                  <PhoneNumber>{fn:data($itemWork/numeroCelular)}</PhoneNumber>
                </PhoneNumberItem>
              )
            }
            </PhoneInfo>
          ) else ()
        }
        {
          if(fn:exists($favoritesResponse/datos/localizadores)) then (
            <AddressInfo>
            {
              for $AddressItemHome in $favoritesResponse/datos/localizadores/residencial
              return(
                <AddressItem>
                  <AddressCode>{fn:data($AddressItemHome/codigoUbicacion)}</AddressCode>
                  <AddressType>HOME</AddressType>
                  <CountryCode>{fn:data($AddressItemHome/codigoPais)}</CountryCode>
                  <DepartmentCode>{fn:data($AddressItemHome/codigoDepartamento)}</DepartmentCode>
				  <MunicipalityCode>{fn:data($AddressItemHome/codigoMunicipio)}</MunicipalityCode>
                  <CityCode>{fn:data($AddressItemHome/codigoColinia)}</CityCode>
                  <AddressLine5>{fn:data($AddressItemHome/direccionFisica)}</AddressLine5>
                </AddressItem>
              )
            }
			{
              for $AddressItemWork in $favoritesResponse/datos/localizadores/laboral
              return(
                <AddressItem>
                  <AddressCode>{fn:data($AddressItemWork/codigoUbicacion)}</AddressCode>
                  <AddressType>WORK</AddressType>
                  <CountryCode>{fn:data($AddressItemWork/codigoPais)}</CountryCode>
                  <DepartmentCode>{fn:data($AddressItemWork/codigoDepartamento)}</DepartmentCode>
				  <MunicipalityCode>{fn:data($AddressItemWork/codigoMunicipio)}</MunicipalityCode>
                  <CityCode>{fn:data($AddressItemWork/codigoColinia)}</CityCode>
                  <AddressLine5>{fn:data($AddressItemWork/direccionFisica)}</AddressLine5>
                </AddressItem>
              )
            }
            </AddressInfo>
          ) else ()
        }
        {
          if (fn:exists($favoritesResponse/datos/localizadores)) then (
            <EmailInfo>
            {
              for $EmailItem in $favoritesResponse/datos/localizadores/residencial 
              return(
                <EmailItem>
                  <EmailAddress>{fn:data($EmailItem/correoElectronico)}</EmailAddress>
                </EmailItem>
              )
            }
            </EmailInfo>
          ) else ()
        }
        {
          if(fn:exists($workResponse/datos/laborales)) then (
            <JobInfo>
            {
                for $JobItem in $workResponse/datos/laborales
                return(
                  <JobItem>
                    <EmployerCode>{fn-bea:trim(fn:concat(fn:data($JobItem/codigoIdentificacionEmpleador), ' ', fn:data($JobItem/numeroIdentificacionEmpleador)))}</EmployerCode>
                    <EmployerName>{fn:data($JobItem/razonSocial)}</EmployerName>
                    <JobDescription>{fn:data($JobItem/cargo)}</JobDescription>
                    <StartDate>{fn:data($JobItem/fechaIngresoLabor)}</StartDate>
                    {
                      for $IsCurrentJob in $JobItem/empleoActual
                      return
                      if (fn:data($IsCurrentJob) = 'SI') then (
                        <IsCurrentJob>YES</IsCurrentJob>
                      ) else (
                        <IsCurrentJob>NO</IsCurrentJob>
                      )
                    }
                  </JobItem>
                )
            }
            </JobInfo>
          ) else ()
        }
    </ns2:getCustomerDetailsResponse>
};

local:func($demographicResponse, $workResponse, $favoritesResponse, $globalId)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd">
            <con:schema ref="SBHN_Pension_Commons/Schemas/CloudCodeTypes"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>