(:: pragma bea:global-element-parameter parameter="$fICOTSPTRANSACTION1" element="ns1:FICOTSPTRANSACTION" location="../xsd/FICOTSPTRANSACTION-FICOTSPTRANSACTION.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/transaccionTSPPMSV/xsd/transactionTSP_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://www.temenos.com/T24/event/FICOTSPTRANSACTION/FICOTSPTRANSACTION";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/transactionTSP";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24TransacctionMassivesTSP_inbound/xq/transactionTSPIn/";

declare function xf:transactionTSPIn($fICOTSPTRANSACTION1 as element(ns1:FICOTSPTRANSACTION))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_COUNTRYCODE>HN</ns0:PV_COUNTRYCODE>
            {
                for $id in $fICOTSPTRANSACTION1/ns1:id
                return
                    <ns0:PV_IDTRANSACTION>{ data($id) }</ns0:PV_IDTRANSACTION>
            }
            {
                for $exonSameCus in $fICOTSPTRANSACTION1/ns1:exonSameCus
                return
                    <ns0:PV_EXONERATESAMECUSTOMER>{ data($exonSameCus) }</ns0:PV_EXONERATESAMECUSTOMER>
            }
            {
                for $exonCcyDif in $fICOTSPTRANSACTION1/ns1:exonCcyDif
                return
                    <ns0:PV_EXONERATEDEFERREDCURRENCY>{ data($exonCcyDif) }</ns0:PV_EXONERATEDEFERREDCURRENCY>
            }
            {
                for $convenio in $fICOTSPTRANSACTION1/ns1:convenio
                return
                    <ns0:PV_APPLYCONVENTION>{ data($convenio) }</ns0:PV_APPLYCONVENTION>
            }
            {
                for $comision in $fICOTSPTRANSACTION1/ns1:comision
                return
                    <ns0:PV_COMMISSION>{ data($comision) }</ns0:PV_COMMISSION>
            }
            {
                for $tspLbtr in $fICOTSPTRANSACTION1/ns1:tspLbtr
                return
                    <ns0:PV_TRANSACTIONEXCEEDAMOUNT>{ data($tspLbtr) }</ns0:PV_TRANSACTIONEXCEEDAMOUNT>
            }
            {
                for $chargeByT24 in $fICOTSPTRANSACTION1/ns1:chargeByT24
                return
                    <ns0:PV_CHARGEBYCORE>{ data($chargeByT24) }</ns0:PV_CHARGEBYCORE>
            }
            {
                for $auditDateTime in $fICOTSPTRANSACTION1/ns1:auditDateTime
                return
                    <ns0:PV_TIMESTAMPSOURCE>{ data($auditDateTime) }</ns0:PV_TIMESTAMPSOURCE>
            }
        </ns0:InputParameters>
};

declare variable $fICOTSPTRANSACTION1 as element(ns1:FICOTSPTRANSACTION) external;

xf:transactionTSPIn($fICOTSPTRANSACTION1)