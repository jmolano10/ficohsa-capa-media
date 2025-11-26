(:: pragma bea:global-element-parameter parameter="$fICOTSPPARAMTRXXSECTOR1" element="ns2:FICOTSPPARAMTRXXSECTOR" location="../xsd/FICOTSPPARAMTRXXSECTOR-FICOTSPPARAMTRXXSECTOR.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/parametroSectorTSPPMSV/xsd/sectorTSP_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/FICOTSPPARAMTRXXSECTOR/FICOTSPPARAMTRXXSECTOR";
declare namespace ns1 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/sectorTSP";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24ParametroSector_inbound/xq/paramSectorTSPIn/";

declare function xf:paramSectorTSPIn($fICOTSPPARAMTRXXSECTOR1 as element(ns2:FICOTSPPARAMTRXXSECTOR))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRYCODE>HN</ns0:PV_COUNTRYCODE>
            {
                for $id in $fICOTSPPARAMTRXXSECTOR1/ns2:id
                return
                    <ns0:PV_IDTRANSACTIONSECTOR>{ data($id) }</ns0:PV_IDTRANSACTIONSECTOR>
            }
            {
                for $avgAmtPrevMth in $fICOTSPPARAMTRXXSECTOR1/ns2:avgAmtPrevMth
                return
                    <ns0:PV_AVERAGEPREVIOUSMONTH>{ data($avgAmtPrevMth) }</ns0:PV_AVERAGEPREVIOUSMONTH>
            }
            {
                for $payer in $fICOTSPPARAMTRXXSECTOR1/ns2:payer
                return
                    <ns0:PV_PAYER>{ data($payer) }</ns0:PV_PAYER>
            }
            {
                for $valueBase in $fICOTSPPARAMTRXXSECTOR1/ns2:valueBase
                return
                    <ns0:PV_BASEVALUE>{ data($valueBase) }</ns0:PV_BASEVALUE>
            }
            {
                for $timeLimit in $fICOTSPPARAMTRXXSECTOR1/ns2:timeLimit
                return
                    <ns0:PV_LIMITTIME>{ data($timeLimit) }</ns0:PV_LIMITTIME>
            }
            {
                for $accPayerBank in $fICOTSPPARAMTRXXSECTOR1/ns2:accPayerBank
                return
                    <ns0:PV_ACCOUNTPAYERBANK>{ data($accPayerBank) }</ns0:PV_ACCOUNTPAYERBANK>
            }
            {
                for $accIntColl in $fICOTSPPARAMTRXXSECTOR1/ns2:accIntColl
                return
                    <ns0:PV_ACCOUNTINTERNALCOLLECTION>{ data($accIntColl) }</ns0:PV_ACCOUNTINTERNALCOLLECTION>
            }
            {
                for $valueTax in $fICOTSPPARAMTRXXSECTOR1/ns2:valueTax
                return
                    <ns0:PV_TAXVALUE>{ data($valueTax) }</ns0:PV_TAXVALUE>
            }
            {
                for $idSar in $fICOTSPPARAMTRXXSECTOR1/ns2:idSar
                return
                    <ns0:PV_IDSAR>{ data($idSar) }</ns0:PV_IDSAR>
            }
            {
                for $dateTime in $fICOTSPPARAMTRXXSECTOR1/ns2:dateTimeList/ns2:dateTime
                return
                    <ns0:PV_TIMESTAMPSOURCE>{ data($dateTime) }</ns0:PV_TIMESTAMPSOURCE>
            }
        </ns0:InputParameters>
};

declare variable $fICOTSPPARAMTRXXSECTOR1 as element(ns2:FICOTSPPARAMTRXXSECTOR) external;

xf:paramSectorTSPIn($fICOTSPPARAMTRXXSECTOR1)