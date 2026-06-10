<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft" encoding "Cp1252";
(:: pragma  type="xs:anyType" ::)

declare namespace ns2 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns1 = "urn:infocorp.framework.businessentities.security";
declare namespace ns4 = "urn:infocorp.framework.businessentities.common";
declare namespace ns3 = "urn:tailored.icbanking.services.transactionscustom";
declare namespace ns5 = "urn:infocorp.framework.services.common";
declare namespace ns6 = "urn:infocorp.framework.common";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionCupon/xq/updateTransactionIn/";

declare function xf:updateTransactionIn($bakendReference as xs:string,
										$backendErrorCode as xs:string,
										$status as xs:string,
										$transactionId as xs:string)
    as element(*) {
        <ns3:UpdateTransactionMessageIn>
			<ns3:BackendReference>{ data($bakendReference) }</ns3:BackendReference>
        	<ns3:ErrorBackendCode>{ data($backendErrorCode) }</ns3:ErrorBackendCode>
        	<ns3:Status>{ data($status) }</ns3:Status>
			<ns3:TransactionId>{ data($transactionId) }</ns3:TransactionId>
			<ns3:Type>2401</ns3:Type>
      	</ns3:UpdateTransactionMessageIn>
};

declare variable $backendReference as xs:string external;
declare variable $backendErrorCode as xs:string external;
declare variable $status as xs:string external;
declare variable $transactionId as xs:string external;

xf:updateTransactionIn($backendReference,
						$backendErrorCode,
						$status,
						$transactionId)]]></con:xquery>
</con:xqueryEntry>