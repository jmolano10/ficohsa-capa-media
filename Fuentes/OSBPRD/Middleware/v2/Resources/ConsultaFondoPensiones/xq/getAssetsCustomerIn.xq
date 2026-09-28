(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultaFondoPensiones12c/xsd/GetAssetsCustomerTypes.xsd" ::)

declare namespace ns1 = "https://www.ficohsa.com/regional/common/commonTypes";
declare namespace ns0 = "https://www.ficohsa.com/regional/pension";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFondoPensiones/xq/getAssetsCustomerIn/";

declare function xf:getAssetsCustomerIn($userName as xs:string,
	$sourceBank as xs:string,
	$destinationBank as xs:string,
    $legalIdType as xs:string,
    $legalId as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <GeneralInfo>
            	<SourceBank>{ $sourceBank }</SourceBank>            		
            	<DestinationBank>{ $destinationBank }</DestinationBank>
            	<ApplicationUser>{ $userName }</ApplicationUser>
                <Language>es</Language>
            </GeneralInfo>
            <PV_IDENTIFICATION_TYPE>{ $legalIdType }</PV_IDENTIFICATION_TYPE>
            <PV_IDENTIFICACION>{ $legalId }</PV_IDENTIFICACION>
        </ns0:InputParameters>
};

declare variable $userName as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $legalIdType as xs:string external;
declare variable $legalId as xs:string external;

xf:getAssetsCustomerIn($userName,
	$sourceBank,
	$destinationBank,
    $legalIdType,
    $legalId)