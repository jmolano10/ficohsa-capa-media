xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$creaUsuarioSistemaIN" element="ns0:creaUsuarioSistema" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma  type="xs:anyType" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaUsuarioSistema/xq/creaUsuarioSistema/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.administration.general";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns6 = "urn:infocorp.framework.common";

declare function xf:creaUsuarioSistema($creaUsuarioSistemaIN as element(ns0:creaUsuarioSistema),
    $SubsidiaryID as xs:string,
    $ProductTypeID as xs:string,
    $DocumentTypeID as xs:string)
    as element(*) {
   <ns3:UsersOnboardingProcessMessageIn>
         <ns3:SubsidiaryId>{$SubsidiaryID}</ns3:SubsidiaryId>  
         <ns3:DocumentNumber>{data($creaUsuarioSistemaIN/DOCUMENT_NUMBER)}</ns3:DocumentNumber>
         <ns3:DocumentTypeId>{$DocumentTypeID}</ns3:DocumentTypeId>
         <ns3:Names>{data($creaUsuarioSistemaIN/CUSTOMER_NAMES)}</ns3:Names>
         <ns3:LastNames>{data($creaUsuarioSistemaIN/CUSTOMER_LAST_NAMES)}</ns3:LastNames>
         <ns3:Mail>{data($creaUsuarioSistemaIN/EMAIL)}</ns3:Mail>
         <ns3:Phone>{data($creaUsuarioSistemaIN/PHONE)}</ns3:Phone>
         <ns3:ProductTypeId>{$ProductTypeID}</ns3:ProductTypeId>
         <ns3:ProductNumber>{data($creaUsuarioSistemaIN/PRODUCT_NUMBER)}</ns3:ProductNumber>
         <ns3:UserName>{data($creaUsuarioSistemaIN/USER_NAME)}</ns3:UserName>
    </ns3:UsersOnboardingProcessMessageIn>
};

declare variable $creaUsuarioSistemaIN as element(ns0:creaUsuarioSistema) external;
declare variable $SubsidiaryID as xs:string external;
declare variable $ProductTypeID as xs:string external;
declare variable $DocumentTypeID as xs:string external;

xf:creaUsuarioSistema($creaUsuarioSistemaIN,
    $SubsidiaryID,
    $ProductTypeID,
    $DocumentTypeID)