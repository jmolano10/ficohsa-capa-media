xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/ConsultasCuentaT24/v1.0/ConsultasCuentaBS.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/accountValidation";
(:: import schema at "../../../../../MWBanking/Accounts/RequestorServices/XSD/accountValidationTypes.xsd" ::)

declare namespace key = "http://www.ficohsa.com.hn/middleware.services/keyValueTypes";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $RSPDetallesCuenta as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::) external;
declare variable $accountFound as xs:string external;

declare function local:func($uuid as xs:string, $accountFound as xs:string, $RSPDetallesCuenta as element() (:: schema-element(ns1:ConsultadedetallesdelacuentaResponse) ::)) as element() (:: schema-element(ns2:accountValidationResponse) ::) {
    <ns2:accountValidationResponse>
        <ns2:StatusInfo>
            {
                if ($RSPDetallesCuenta/Status/successIndicator)
                then <com:Status>{fn:data($RSPDetallesCuenta/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($RSPDetallesCuenta/Status/transactionId)
                then <com:TransactionId>{fn:data($RSPDetallesCuenta/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:AccountNumber>{fn:data($accountFound)}</ns2:AccountNumber>
        {
           for $accountNameFound in data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/SHORTTITLE)
              return
                <ns2:AccountName>{$accountNameFound}</ns2:AccountName>
        }
        {
            for $accountCurrencyFound in data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CURRENCY)
              return		
                <ns2:Currency>{$accountCurrencyFound}</ns2:Currency>
        }
        {
            let $accountPostingRestrictFound := data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/POSTINGRESTRICT)
            let $accountInactiveMarkerFound  := data($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/INACTIVEMARKER)
              return
                if($accountPostingRestrictFound = '') then 
                    (
                      if($accountInactiveMarkerFound = '') then
                          <ns2:AccountStatus>ACTIVE</ns2:AccountStatus>
                      else
                          <ns2:AccountStatus>INACTIVE</ns2:AccountStatus>
                    )
                else
                  <ns2:AccountStatus>{ fn:concat('BLOCKED ',$accountPostingRestrictFound) }</ns2:AccountStatus>
        }
        {
	    for $accountCategoryFound in fn:number($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CATEGORY)
              return
                  if ($accountCategoryFound >= 1000 and $accountCategoryFound <= 1999) then
                      <ns2:ProductType>CHQ</ns2:ProductType>
                  else if ($accountCategoryFound >= 6000 and $accountCategoryFound <= 6999) then
                      <ns2:ProductType>AHO</ns2:ProductType>
                  else
                      <ns2:ProductType></ns2:ProductType>
	    	}
        {
            for $customerId in fn:string($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/CUSTOMERNUMBER/text())
              return
              <ns2:CustomerId>{$customerId}</ns2:CustomerId>
        }
        <ns2:AdditionalInfo>
        {
            for $kvPair in fn:string($RSPDetallesCuenta/WSACCOUNTLISTType/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/DEPREFACCOUNT/text())
              return
                if($kvPair = 'A')then(
                    <key:KV_PAIR>
                        <key:Key>DEP_REF_ACCOUNT</key:Key>
                        <key:Value>YES</key:Value>
                    </key:KV_PAIR>
                )else(
                   <key:KV_PAIR>
                        <key:Key>DEP_REF_ACCOUNT</key:Key>
                        <key:Value>NO</key:Value>
                    </key:KV_PAIR>     
                )
        }
        </ns2:AdditionalInfo>
    </ns2:accountValidationResponse>
};

local:func($uuid, $accountFound, $RSPDetallesCuenta)