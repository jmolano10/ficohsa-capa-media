(:: pragma bea:global-element-parameter parameter="$FICOTSPCUENTAS" element="ns1:FICOTSPCUENTAS" location="../xsd/FICOTSPCUENTAS-FICOTSPCUENTAS.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/cuentasTSPPMSV/xsd/cuentasTSP_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://www.temenos.com/T24/event/FICOTSPCUENTAS/FICOTSPCUENTAS";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/cuentasTSP";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24AccountMassivesTSP_inbound/xq/accountTSPIn/";

declare function xf:accountTSPIn($FICOTSPCUENTAS as element(ns1:FICOTSPCUENTAS))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRYCODE>HN</ns0:PV_COUNTRYCODE>
            {
                for $id in $FICOTSPCUENTAS/ns1:id
                return
                    <ns0:PV_ACCOUNTNUMBER>{ data($id) }</ns0:PV_ACCOUNTNUMBER>
            }
            {
                for $customer in $FICOTSPCUENTAS/ns1:customer
                return
                    <ns0:PV_CUSTOMERID>{ data($customer) }</ns0:PV_CUSTOMERID>
            }
            {
                for $exonerate in $FICOTSPCUENTAS/ns1:exonerate
                return
                    <ns0:PV_EXONERATE>{ data($exonerate) }</ns0:PV_EXONERATE>
            }
            <ns0:PV_STARTDATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', $FICOTSPCUENTAS/ns1:startDate) }</ns0:PV_STARTDATE>
            <ns0:PV_ENDDATE>{ fn-bea:date-to-string-with-format('yyyyMMdd', $FICOTSPCUENTAS/ns1:endDate) }</ns0:PV_ENDDATE>
            {
                for $payrollGroup in $FICOTSPCUENTAS/ns1:payrollGroup
                return
                    <ns0:PV_PAYROLLGROUP>{ data($payrollGroup) }</ns0:PV_PAYROLLGROUP>
            }
            {
                for $exonerateId in $FICOTSPCUENTAS/ns1:exonerateId
                return
                    <ns0:PV_EXONERATEID>{ data($exonerateId) }</ns0:PV_EXONERATEID>
            }
            {
                for $dateTime in $FICOTSPCUENTAS/ns1:dateTimeList/ns1:dateTime
                return
                    <ns0:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns0:PV_TIMESTAMPSOURCE>
            }
        </ns0:InputParameters>
};

declare variable $FICOTSPCUENTAS as element(ns1:FICOTSPCUENTAS) external;

xf:accountTSPIn($FICOTSPCUENTAS)