(:: pragma bea:global-element-parameter parameter="$FICOTSPGRUPOPLANILLA" element="ns2:FICOTSPGRUPOPLANILLA" location="../xsd/FICOTSPGRUPOPLANILLA-FICOTSPGRUPOPLANILLA.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/grupoPlanillaTSPPMSV/xsd/planillaTSP_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/FICOTSPGRUPOPLANILLA/FICOTSPGRUPOPLANILLA";
declare namespace ns1 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/planillaTSP";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24GrupoPlanillaTSP_inbound/xq/grupoPlanillaTSPIn/";

declare function xf:grupoPlanillaTSPIn($FICOTSPGRUPOPLANILLA as element(ns2:FICOTSPGRUPOPLANILLA))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRYCODE>HN</ns0:PV_COUNTRYCODE>
            {
                for $exonerateId in $FICOTSPGRUPOPLANILLA/ns2:exonerateId
                return
                    <ns0:PV_EXONERATEID>{ data($exonerateId) }</ns0:PV_EXONERATEID>
            }
            {
                for $exonerate in $FICOTSPGRUPOPLANILLA/ns2:exonerate
                return
                    <ns0:PV_EXONERATE>{ data($exonerate) }</ns0:PV_EXONERATE>
            }
            {
                for $dateTime in $FICOTSPGRUPOPLANILLA/ns2:dateTimeList/ns2:dateTime
                return
                    <ns0:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns0:PV_TIMESTAMPSOURCE>
            }
        </ns0:InputParameters>
};

declare variable $FICOTSPGRUPOPLANILLA as element(ns2:FICOTSPGRUPOPLANILLA) external;

xf:grupoPlanillaTSPIn($FICOTSPGRUPOPLANILLA)