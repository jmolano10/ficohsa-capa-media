xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaTxnReprocesoACHEnviadasResponse" element="ns0:ConsultatxnreprocesoACHEnviadasResponse" location="../../../BusinessServices/ACH/Enviado/SvcACHConsultas/xsd/XMLSchema_814484778.xsd" ::)
(:: pragma bea:global-element-return element="ns1:reprocesoACHEnviadasCRResponse" location="../xsd/reprocesoACHEnviadasCRTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHEnviadasCRTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/reprocesoACHEnviadasCROut/";

declare function xf:reprocesoACHEnviadasCROut($consultaTxnReprocesoACHEnviadasResponse as element(ns0:ConsultatxnreprocesoACHEnviadasResponse),
    $achSequence as xs:integer,
    $pxpIdTxnRef as xs:string,
    $pxpBatchRef as xs:string)
    as element(ns1:reprocesoACHEnviadasCRResponse) {
        let $consultaReprocesoResponse := $consultaTxnReprocesoACHEnviadasResponse/WSACHOUTGOINGREPROCESSType[1]/gWSACHOUTGOINGREPROCESSDetailType/mWSACHOUTGOINGREPROCESSDetailType[1]
        return
            <ns1:reprocesoACHEnviadasCRResponse>
                <ACH_SEQUENCE>{ $achSequence }</ACH_SEQUENCE>
	            <PXP_ID_TXN_REF>{ $pxpIdTxnRef }</PXP_ID_TXN_REF>
	            <PXP_BATCH_REF>{ $pxpBatchRef }</PXP_BATCH_REF>
	            {
	                for $ACHROUTINGNUM in $consultaReprocesoResponse/ACHROUTINGNUM
	                return
	                    <TRANSIT_ROUTE>{ data($ACHROUTINGNUM) }</TRANSIT_ROUTE>
	            }
	            {
	                for $CUSTOMERID in $consultaReprocesoResponse/CUSTOMERID
	                return
	                    <T24_CUSTOMER_ID>{ data($CUSTOMERID) }</T24_CUSTOMER_ID>
	            }
	            {
	                for $ACCTSHORTTITLE in $consultaReprocesoResponse/ACCTSHORTTITLE
	                return
	                    <ORD_NAME>{ data($ACCTSHORTTITLE) }</ORD_NAME>
	            }
	            {
	                for $LEGALID in $consultaReprocesoResponse/LEGALID
	                return
	                    <ORD_IDENTIFICATION>{ data($LEGALID) }</ORD_IDENTIFICATION>
	            }
	            {
	                for $ADDRESSLINE1 in $consultaReprocesoResponse/ADDRESSLINE1
	                return
	                    <ORD_CUSTOMER_DIRECTION>{ data($ADDRESSLINE1) }</ORD_CUSTOMER_DIRECTION>
	            }
	            {
	                for $DEBITACCOUNTTYPE in $consultaReprocesoResponse/DEBITACCOUNTTYPE
	                return
	                    <ORD_ACCOUNT_TYPE>{ data($DEBITACCOUNTTYPE) }</ORD_ACCOUNT_TYPE>
	            }
	            {
	                for $ISLBTR in $consultaReprocesoResponse/ISLBTR
	                return
	                    <IS_LBTR>{ data($ISLBTR) }</IS_LBTR>
	            }
	            {
	                for $ID in $consultaReprocesoResponse/ID
	                return
	                    <T24_CONTROL_REF>{ data($ID) }</T24_CONTROL_REF>
	            }
	            {
	                for $IDTXNT24 in $consultaReprocesoResponse/IDTXNT24
	                return
	                    <T24_TRANSACTION_REF>{ data($IDTXNT24) }</T24_TRANSACTION_REF>
	            }
	            {
	                for $ACLKID in $consultaReprocesoResponse/ACLKID
	                return
	                    <T24_LOCK_ID>{ data($ACLKID) }</T24_LOCK_ID>
	            }
	            {
	                for $ISREPROCESS in $consultaReprocesoResponse/ISREPROCESS
	                return
	                    <T24_IS_REPROCESS>{ data($ISREPROCESS) }</T24_IS_REPROCESS>
	            }
	            {
	                for $TXNSTATUS in $consultaReprocesoResponse/TXNSTATUS
	                return
	                    <T24_STATUS>{ data($TXNSTATUS) }</T24_STATUS>
	            }
	            {
	                for $IDREJECTION in $consultaReprocesoResponse/IDREJECTION
	                return
	                    <T24_ID_REJECTION>{ data($IDREJECTION) }</T24_ID_REJECTION>
	            }
	            {
	                for $STAGE in $consultaReprocesoResponse/STAGE
	                return
	                    <T24_STAGE>{ data($STAGE) }</T24_STAGE>
	            }
            </ns1:reprocesoACHEnviadasCRResponse>
};

declare variable $consultaTxnReprocesoACHEnviadasResponse as element(ns0:ConsultatxnreprocesoACHEnviadasResponse) external;
declare variable $achSequence as xs:integer external;
declare variable $pxpIdTxnRef as xs:string external;
declare variable $pxpBatchRef as xs:string external;

xf:reprocesoACHEnviadasCROut($consultaTxnReprocesoACHEnviadasResponse,
    $achSequence,
    $pxpIdTxnRef,
    $pxpBatchRef)