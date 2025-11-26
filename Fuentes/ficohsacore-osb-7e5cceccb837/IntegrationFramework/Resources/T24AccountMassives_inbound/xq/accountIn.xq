(:: pragma bea:global-element-parameter parameter="$ACCOUNT" element="ns0:ACCOUNT" location="../xsd/T24ACCOUNT-ACCOUNT.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/cuentasPMSV/xsd/account_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/account";
declare namespace ns0 = "http://www.temenos.com/T24/event/T24ACCOUNT/ACCOUNT";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24AccountMassives_inbound/xq/accountIn/";

declare function xf:accountIn($ACCOUNT as element(ns0:ACCOUNT))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_COUNTRYCODE>HN</ns1:PV_COUNTRYCODE>
            {
                for $id in $ACCOUNT/ns0:id
                return
                    <ns1:PV_ACCOUNTNUMBER>{ data($id) }</ns1:PV_ACCOUNTNUMBER>
            }
            {
                for $altAcctId in $ACCOUNT/ns0:altAcctIdGroup[1]/ns0:altAcctId
                return
                    <ns1:PV_ALTACCOUNT>{ data($altAcctId) }</ns1:PV_ALTACCOUNT>
            }
            <ns1:PV_CUSTOMERID>{ xs:string($ACCOUNT/ns0:customer) }</ns1:PV_CUSTOMERID>
            {
                for $category in $ACCOUNT/ns0:category
                return
                    <ns1:PV_CATEGORY>{ data($category) }</ns1:PV_CATEGORY>
            }
            {
                for $currency in $ACCOUNT/ns0:currency
                return
                    <ns1:PV_CURRENCY>{ data($currency) }</ns1:PV_CURRENCY>
            }
            {
                for $shortTitle in $ACCOUNT/ns0:shortTitle
                return
                    <ns1:PV_ACCOUNTNAME>{ data($shortTitle) }</ns1:PV_ACCOUNTNAME>
            }
            {
                for $POSTINGNAME in $ACCOUNT/ns0:POSTINGNAME
                return
                    <ns1:PV_BLOCKTYPE>{ data($POSTINGNAME) }</ns1:PV_BLOCKTYPE>
            }
            {
                for $inactivMarker in $ACCOUNT/ns0:inactivMarker
                return
                    <ns1:PV_INACTIVEMARKER>{ data($inactivMarker) }</ns1:PV_INACTIVEMARKER>
            }
            <ns1:PV_AVAILABLEBALANCE>{ xs:string($ACCOUNT/ns0:workingBalance) }</ns1:PV_AVAILABLEBALANCE>
            <ns1:PV_OPENINGDATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', $ACCOUNT/ns0:openingDate) }</ns1:PV_OPENINGDATE>
            <ns1:PV_LASTUPDATEDATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', $ACCOUNT/ns0:dateLastUpdate) }</ns1:PV_LASTUPDATEDATE>
            <ns1:PV_LASTDEBITDATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', $ACCOUNT/ns0:dateLastDrCust) }</ns1:PV_LASTDEBITDATE>
            <ns1:PV_LASTCREDITDATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', $ACCOUNT/ns0:dateLastCrCust) }</ns1:PV_LASTCREDITDATE>
            <ns1:PV_CANCELDATE>{ data($ACCOUNT/ns0:closureDate) }</ns1:PV_CANCELDATE>
            {
             
                for $dateTime in $ACCOUNT/ns0:dateTimeList/ns0:dateTime
                return
                    <ns1:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns1:PV_TIMESTAMPSOURCE>
             
            }
        </ns1:InputParameters>
};

declare variable $ACCOUNT as element(ns0:ACCOUNT) external;

xf:accountIn($ACCOUNT)