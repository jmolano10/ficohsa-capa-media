(:: pragma bea:global-element-parameter parameter="$registraLoteExterno1" element="ns4:registraLoteExterno" location="../xsd/registraLoteExternoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ProcesarLotesMessageIn" location="../../../BusinessServices/ICB/RegistraLoteExterno/wsdl/CustomBulkService.wsdl" ::)

declare namespace ns0 = "http://schemas.microsoft.com/2003/10/Serialization/Arrays";
declare namespace ns2 = "urn:tailored.icbanking.services.bulk";
declare namespace ns1 = "urn:infocorp.framework.services.common";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraLoteExterno/xq/procesarLotesIn/";
declare namespace ns4 = "http://www.ficohsa.com.hn/middleware.services/registraLoteExternoTypes";
declare namespace ns3 = "urn:infocorp.framework.businessentities.common";

declare function xf:procesarLotesIn($registraLoteExterno1 as element(ns4:registraLoteExterno))
    as element(ns2:ProcesarLotesMessageIn) {
        <ns2:ProcesarLotesMessageIn>
            <ns2:ApplicationDate>{ data($registraLoteExterno1/APPLICATION_DATE) }</ns2:ApplicationDate>
            <ns2:AuthorizationRequired>
                {
                    for $AUTHORIZATION_REQUIRED in $registraLoteExterno1/AUTHORIZATION_REQUIRED  
                    return
                        if (upper-case($AUTHORIZATION_REQUIRED/text()) = "YES") then(
                        	'true'
                        )else(
                        	'false'
                        ) 
                }
			</ns2:AuthorizationRequired>
            <ns2:BatchId>{ data($registraLoteExterno1/BANK_BATCH_ID) }</ns2:BatchId>
            <ns2:ClientId>{ data($registraLoteExterno1/CUSTOMER_ID) }</ns2:ClientId>
            <ns2:Concept>{ data($registraLoteExterno1/CONCEPT) }</ns2:Concept>
            <ns2:DocumentNumber>{ data($registraLoteExterno1/LEGAL_ID) }</ns2:DocumentNumber>
            <ns2:DocumentType>{ data($registraLoteExterno1/DOCUMENT_TYPE) }</ns2:DocumentType>
            <ns2:NotificationTo>{ data($registraLoteExterno1/NOTIFICATION_EMAIL) }</ns2:NotificationTo>
            <ns2:Type>{ data($registraLoteExterno1/TYPE) }</ns2:Type>
            <ns2:UploadDate>{data($registraLoteExterno1/UPLOAD_DATE)}</ns2:UploadDate>
        </ns2:ProcesarLotesMessageIn>
};

declare variable $registraLoteExterno1 as element(ns4:registraLoteExterno) external;

xf:procesarLotesIn($registraLoteExterno1)
