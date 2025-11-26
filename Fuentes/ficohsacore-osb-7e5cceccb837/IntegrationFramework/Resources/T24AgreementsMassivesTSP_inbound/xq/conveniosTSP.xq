(:: pragma bea:global-element-parameter parameter="$FICOTSPCONVENIOS" element="ns1:FICOTSPCONVENIOS" location="../xsd/FICOTSPCONVENIOS-FICOTSPCONVENIOS.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/conveniosTSPPMSV/xsd/conveniosTSP_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://www.temenos.com/T24/event/FICOTSPCONVENIOS/FICOTSPCONVENIOS";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conveniosTSP";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24AgreementsMassivesTSP_inbound/xq/conveniosTSP/";

declare function xf:conveniosTSP($FICOTSPCONVENIOS as element(ns1:FICOTSPCONVENIOS))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRYCODE>HN</ns0:PV_COUNTRYCODE>
            {
                for $id in $FICOTSPCONVENIOS/ns1:id
                return
                    <ns0:PV_AGREEMENTID>{ data($id) }</ns0:PV_AGREEMENTID>
            }
            {
                for $exonerate in $FICOTSPCONVENIOS/ns1:exonerate
                return
                    <ns0:PV_EXONERATE>{ data($exonerate) }</ns0:PV_EXONERATE>
            }
            {
                for $dateTime in $FICOTSPCONVENIOS/ns1:dateTimeList/ns1:dateTime
                return
                    <ns0:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns0:PV_TIMESTAMPSOURCE>
            }
        </ns0:InputParameters>
};

declare variable $FICOTSPCONVENIOS as element(ns1:FICOTSPCONVENIOS) external;

xf:conveniosTSP($FICOTSPCONVENIOS)