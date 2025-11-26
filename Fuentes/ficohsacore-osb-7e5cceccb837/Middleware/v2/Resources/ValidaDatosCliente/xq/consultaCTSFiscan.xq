(:: pragma bea:global-element-return element="ns0:opLookupRequest" location="../../../BusinessServices/CTS/Fiscan/xsd/services.xsd" ::)

declare namespace ns0 = "http://service.srvaplcobisfinscan.ecobis.cobiscorp";
declare namespace ns1 = "http://dto.srvaplcobisentitiesfinscan.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaDatosCliente/ConsultaClienteFiscanCTS/";

declare function xf:ConsultaClienteFiscanCTS($Name as xs:string,
    $Sequence as xs:string)
    as element(ns0:opLookupRequest) {
        <ns0:opLookupRequest>
        <ns1:clientId>{ $Sequence }</ns1:clientId>
		<ns1:listId>WC</ns1:listId>
		<ns1:listName>World-Check</ns1:listName>
		<ns1:categoryName></ns1:categoryName>
		<ns1:isSelected>Yes</ns1:isSelected>
		<ns1:isMandatory>Yes</ns1:isMandatory>
		<ns1:searchType>Individual</ns1:searchType>
		<ns1:gender>Unknown</ns1:gender>
		<ns1:nameLine>{ $Name }</ns1:nameLine>
		<ns1:clientSearchCode>FullName</ns1:clientSearchCode>
        <ns1:returnComplianceRecords>Yes</ns1:returnComplianceRecords>
		<ns1:addClient>No</ns1:addClient>
		<ns1:sendToReview>Yes</ns1:sendToReview>
		<ns1:userFieldsSearch>3</ns1:userFieldsSearch>
		<ns1:updateUserFields>No</ns1:updateUserFields>
		<ns1:userField1Label>COUNTRY</ns1:userField1Label>
		<ns1:userField1Value></ns1:userField1Value>
		<ns1:userField2Label></ns1:userField2Label>
		<ns1:userField2Value></ns1:userField2Value>
		<ns1:userField3Label></ns1:userField3Label>
		<ns1:userField3Value></ns1:userField3Value>
		<ns1:returnCategory>Yes</ns1:returnCategory>
		<ns1:returnSourceLists>Yes</ns1:returnSourceLists>
		<ns1:generateclientId>No</ns1:generateclientId>
		<ns1:clientStatus>Active</ns1:clientStatus>
		<ns1:customStatus>PENDING</ns1:customStatus>
		<ns1:applicationId>ws_bd</ns1:applicationId>
        </ns0:opLookupRequest>
};

declare variable $Name as xs:string external;
declare variable $Sequence as xs:string external;

xf:ConsultaClienteFiscanCTS($Name,
    $Sequence)
