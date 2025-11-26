(:: pragma bea:global-element-parameter parameter="$Customer" element="ns1:Customer" location="../xsd/T24Customer-Customer.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/clientesPMSV/xsd/customer_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/customer";
declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://www.temenos.com/T24/event/T24Customer/Customer";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24CustomerPMSV/xq/customerIn/";

declare function xf:customerIn($Customer as element(ns1:Customer))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRYCODE>HN</ns0:PV_COUNTRYCODE>
            <ns0:PV_CUSTOMERID>{ xs:string($Customer/ns1:id) }</ns0:PV_CUSTOMERID>
            {
                for $legalDocName in $Customer/ns1:legalIdGroup[1]/ns1:legalDocName
                return
                    <ns0:PV_IDENTIFICATIONTYPE>{ data($legalDocName) }</ns0:PV_IDENTIFICATIONTYPE>
            }
            {
                for $legalId in $Customer/ns1:legalIdGroup[1]/ns1:legalId
                return
                    <ns0:PV_IDENTIFICATION>{ data($legalId) }</ns0:PV_IDENTIFICATION>
            }
            {
                let $result :=
                    for $shortName in $Customer/ns1:shortNameList/ns1:shortName
                    return
                        <ns0:PV_CLIENTNAME>{ data($shortName) }</ns0:PV_CLIENTNAME>
                return
                    $result[1]
            }
            {
                for $sector in $Customer/ns1:sector
                return
                    <ns0:PV_CLIENTTYPE>{ data($sector) }</ns0:PV_CLIENTTYPE>
            }
            {
                let $result :=
                    for $email1 in $Customer/ns1:email1List/ns1:email1
                    return
                        <ns0:PV_EMAIL>{ data($email1) }</ns0:PV_EMAIL>
                return
                    $result[1]
            }
            {
                let $result :=
                    for $sms1 in $Customer/ns1:sms1List/ns1:sms1
                    return
                        <ns0:PV_SMS>{ data($sms1) }</ns0:PV_SMS>
                return
                    $result[1]
            }
            {
                for $legalRepEmail in $Customer/ns1:legalRepEmail
                return
                    <ns0:PV_LEGALREPEMAIL>{ data($legalRepEmail) }</ns0:PV_LEGALREPEMAIL>
            }
            {
               let $result :=
                 for $nameOfBusines in $Customer/ns1:nameOfBusinesList/ns1:nameOfBusines
                 return
                       data($nameOfBusines)  
                 let $concatenatedNames := string-join($result, ' ')  
                 return
                  <ns0:PV_NAMEOFBUSINESS>{$concatenatedNames}</ns0:PV_NAMEOFBUSINESS>
  
            }
            <ns0:PV_OPENINGDATE>{ data($Customer/ns1:customerSince) }</ns0:PV_OPENINGDATE>
            <ns0:PV_LASTUPDATEDATE>{ data($Customer/ns1:lrFecOfi) }</ns0:PV_LASTUPDATEDATE>
            {
                let $result :=
                    for $dateTime in $Customer/ns1:dateTimeList/ns1:dateTime
                    return
                        <ns0:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns0:PV_TIMESTAMPSOURCE>
                return
                    $result[1]
            }
        </ns0:InputParameters>
};

declare variable $Customer as element(ns1:Customer) external;

xf:customerIn($Customer)