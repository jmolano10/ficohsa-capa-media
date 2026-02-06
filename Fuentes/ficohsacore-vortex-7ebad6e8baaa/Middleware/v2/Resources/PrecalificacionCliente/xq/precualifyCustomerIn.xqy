xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$precalificacionCliente" element="ns0:precalificacionCliente" location="../../GestionesSolicitudCredito/xsd/gestionesSolicitudCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:PrecualifyCustomer" location="../../../BusinessServices/CREDITFORCE/ficohsaServices/xsd/XMLSchema_-1613181781.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesSolicitudCreditoTypes";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/CreditForce.Common.DataContract.FicohsaServices";
declare namespace ns1 = "http://www.creditforce.com/SOA";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PrecalificacionCliente/xq/precalificacionClienteIn/";

declare function xf:validateBirthDate($birthDateParam as xs:string) as xs:dateTime{
	let $birthDate := 
	if($birthDateParam != '')then(
		adjust-dateTime-to-timezone(xs:dateTime(concat($birthDateParam,'T00:00:00')),())
	)else(
		adjust-dateTime-to-timezone(xs:dateTime('1900-01-01T00:00:00'),())
	) return
	$birthDate
};
declare function xf:precualifyCustomerIn($precalificacionCliente as element(ns0:precalificacionCliente),
    $idCompany as xs:string,
    $login as xs:string,
    $serviceId as xs:string,
    $token as xs:string)
    as element(ns1:PrecualifyCustomer) {
        <ns1:PrecualifyCustomer>
            <ns1:precualifyCustomer>
                {
                    for $CHANNEL_CODE in $precalificacionCliente/CHANNEL_CODE
                    return
                        <ns2:IdChannel>{ data($CHANNEL_CODE) }</ns2:IdChannel>
                }
                <ns2:IdCompany>{ data($idCompany) }</ns2:IdCompany>
                <ns2:Login>{ $login }</ns2:Login>
                <ns2:ServiceId>{ $serviceId }</ns2:ServiceId>
                <ns2:Token>{ $token }</ns2:Token>
                <ns2:UserName>{ data($precalificacionCliente/USERNAME) }</ns2:UserName>
                <ns2:AmountRequest>{ data($precalificacionCliente/REQUESTED_AMOUNT) }</ns2:AmountRequest>
                <ns2:BirthDate>{ xf:validateBirthDate(fn:string($precalificacionCliente/BIRTH_DATE/text())) }</ns2:BirthDate>
                <ns2:CommissionPercentage>{ data($precalificacionCliente/COMMISSION_PERCENTAGE) }</ns2:CommissionPercentage>
                <ns2:CustomerCampaign>{ data($precalificacionCliente/CUSTOMER_CAMPAIGN) }</ns2:CustomerCampaign>
                <ns2:CustomerFlag>{ data($precalificacionCliente/CUSTOMER_FLAG) }</ns2:CustomerFlag>
                <ns2:CustomerProfile>{ data($precalificacionCliente/CUSTOMER_PROFILE) }</ns2:CustomerProfile>
                <ns2:CustomerType>{ data($precalificacionCliente/CUSTOMER_TYPE) }</ns2:CustomerType>
                {
                    let $DOCUMENTS := $precalificacionCliente/DOCUMENTS
                    return
                        <ns2:Documents>
                            {
                                for $DOCUMENT in $DOCUMENTS/DOCUMENT
                                return
                                    <ns2:DocumentCommerce>
                                        {
                                            for $CONTENT_BYTES in $DOCUMENT/CONTENT_BYTES
                                            return
                                                <ns2:ContentBytes>{ data($CONTENT_BYTES) }</ns2:ContentBytes>
                                        }
                                        {
                                            for $FILE_EXTENSION in $DOCUMENT/FILE_EXTENSION
                                            return
                                                <ns2:FileExtension>{ data($FILE_EXTENSION) }</ns2:FileExtension>
                                        }
                                        {
                                            for $FILE_NAME in $DOCUMENT/FILE_NAME
                                            return
                                                <ns2:FileName>{ data($FILE_NAME) }</ns2:FileName>
                                        }
                                        {
                                            for $FILE_TYPE in $DOCUMENT/FILE_TYPE
                                            return
                                                <ns2:FileType>{ data($FILE_TYPE) }</ns2:FileType>
                                        }
                                    </ns2:DocumentCommerce>
                            }
                        </ns2:Documents>
                }
                <ns2:IdSaleForceRequest>{ data($precalificacionCliente/REQUEST_ID) }</ns2:IdSaleForceRequest>
                <ns2:Identification>{ data($precalificacionCliente/LEGAL_ID) }</ns2:Identification>
                <ns2:IdentificationType>{ data($precalificacionCliente/LEGAL_ID_TYPE) }</ns2:IdentificationType>
                <ns2:Income>{ data($precalificacionCliente/CUSTOMER_INCOME) }</ns2:Income>
                {
                    for $PHONE_NUMBER in $precalificacionCliente/PHONE_NUMBER
                    return
                        <ns2:PhoneNumber>{ data($PHONE_NUMBER) }</ns2:PhoneNumber>
                }
                <ns2:Term>{ data($precalificacionCliente/TERM) }</ns2:Term>
                <ns2:TotalAmountFees>{ data($precalificacionCliente/TOTAL_AMOUNT_FEE) }</ns2:TotalAmountFees>
                <ns2:TotalDebtAmount>{ data($precalificacionCliente/TOTAL_DEBT_AMOUNT) }</ns2:TotalDebtAmount>
                <ns2:WorkedMonths>{ data($precalificacionCliente/WORKED_MONTHS) }</ns2:WorkedMonths>
            </ns1:precualifyCustomer>
        </ns1:PrecualifyCustomer>
};

declare variable $precalificacionCliente as element(ns0:precalificacionCliente) external;
declare variable $idCompany as xs:string external;
declare variable $login as xs:string external;
declare variable $serviceId as xs:string external;
declare variable $token as xs:string external;

xf:precualifyCustomerIn($precalificacionCliente,
    $idCompany,
    $login,
    $serviceId,
    $token)