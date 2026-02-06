xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$reprocesoACHEnviadasCR" element="ns1:reprocesoACHEnviadasCR" location="../xsd/reprocesoACHEnviadasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/TransferenciasACH/svcACHDevoluciones/xsd/svcACHDevoluciones_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/svcACHDevoluciones";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHEnviadasCRTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/svcACHDevolucionesIn/";

declare function xf:svcACHDevolucionesIn($reprocesoACHEnviadasCR as element(ns1:reprocesoACHEnviadasCR))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $ORD_ACCOUNT in $reprocesoACHEnviadasCR/ORD_ACCOUNT
                return
                    <ns0:PV_PARAM01>{ data($ORD_ACCOUNT) }</ns0:PV_PARAM01>
            }
            <ns0:PV_PARAM02>{ substring(data($reprocesoACHEnviadasCR/DESTINATION_BANK), 6, 2) }</ns0:PV_PARAM02>
            {
                for $BEN_ACCOUNT in $reprocesoACHEnviadasCR/BEN_ACCOUNT
                return
                    <ns0:PV_PARAM03>{ data($BEN_ACCOUNT) }</ns0:PV_PARAM03>
            }
            {
                for $BEN_CURRENCY in $reprocesoACHEnviadasCR/BEN_CURRENCY
                return
                    <ns0:PV_PARAM04>{ data($BEN_CURRENCY) }</ns0:PV_PARAM04>
            }
            {
                for $BEN_NAME in $reprocesoACHEnviadasCR/BEN_NAME
                return
                    <ns0:PV_PARAM05>{ data($BEN_NAME) }</ns0:PV_PARAM05>
            }
            <ns0:PV_PARAM06>{ data($reprocesoACHEnviadasCR/BEN_AMOUNT) }</ns0:PV_PARAM06>
            {
                for $TXN_DETAIL in $reprocesoACHEnviadasCR/TXN_DETAIL
                return
                    <ns0:PV_PARAM07>{ data($TXN_DETAIL) }</ns0:PV_PARAM07>
            }
            {
                for $TRANSACTION_TYPE in $reprocesoACHEnviadasCR/TRANSACTION_TYPE
                return
                    <ns0:PV_PARAM08>{ data($TRANSACTION_TYPE) }</ns0:PV_PARAM08>
            }
            {
                for $ORD_ORIGINAL_ACCOUNT in $reprocesoACHEnviadasCR/ORD_ORIGINAL_ACCOUNT
                return
                    <ns0:PV_PARAM09>{ data($ORD_ORIGINAL_ACCOUNT) }</ns0:PV_PARAM09>
            }
            {
                for $ERROR_CODE in $reprocesoACHEnviadasCR/ERROR_CODE,
                    $ERROR_MESSAGE in $reprocesoACHEnviadasCR/ERROR_MESSAGE
                return
                    <ns0:PV_PARAM10>{ concat($ERROR_CODE, '-', $ERROR_MESSAGE) }</ns0:PV_PARAM10>
            }
            {
                for $INTERFACE_REFERENCE_NO in $reprocesoACHEnviadasCR/INTERFACE_REFERENCE_NO
                return
                    <ns0:PV_PARAM11>{ data($INTERFACE_REFERENCE_NO) }</ns0:PV_PARAM11>
            }
        </ns0:InputParameters>
};

declare variable $reprocesoACHEnviadasCR as element(ns1:reprocesoACHEnviadasCR) external;

xf:svcACHDevolucionesIn($reprocesoACHEnviadasCR)