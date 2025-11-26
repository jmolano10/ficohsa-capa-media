(:: pragma bea:global-element-parameter parameter="$registroBitacoraConvenio" element="ns1:registroBitacoraConvenio" location="../../xsds/RegistroBitacoraConvenio/RegistroBitacoraConvenio.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../xsds/RegistroBitacoraConvenio/RegistrarBitacoraRequestConvenio/FLINK_OSB_REG_BITACORA_RECAUDO_REQ.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registroBitacoraConvenioTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_REG_BITACORA_RECAUDO_REQ/";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RegistroBitacoraConvenio/RegistrarBitacoraRequestConvenioIn/";

declare function xf:RegistrarBitacoraRequestConvenioIn($registroBitacoraConvenio as element(ns1:registroBitacoraConvenio))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_UUID>{ data($registroBitacoraConvenio/LOG_UUID) }</ns0:P_UUID>
            {
                for $CONTRACT_ID in $registroBitacoraConvenio/CONTRACT_ID
                return
                    <ns0:P_CODIGO_CONVENIO>{ data($CONTRACT_ID) }</ns0:P_CODIGO_CONVENIO>
            }
            {
                for $DEBTOR_CODE in $registroBitacoraConvenio/DEBTOR_CODE
                return
                    <ns0:P_CODIGO_DEUDOR>{ data($DEBTOR_CODE) }</ns0:P_CODIGO_DEUDOR>
            }
            {
                for $OPERATION_CODE in $registroBitacoraConvenio/OPERATION_CODE
                return
                    <ns0:P_CODIGO_OPERACION>{ data($OPERATION_CODE) }</ns0:P_CODIGO_OPERACION>
            }
            {
                for $DATE_TIME in $registroBitacoraConvenio/DATE_TIME
                return
                    <ns0:P_FECHA>{ data($DATE_TIME) }</ns0:P_FECHA>
            }
            {
                for $USER in $registroBitacoraConvenio/USER
                return
                    <ns0:P_USUARIO>{ data($USER) }</ns0:P_USUARIO>
            }
            {
                for $SOAP_MESSAGE in $registroBitacoraConvenio/SOAP_MESSAGE/*
                return
                    <ns0:P_REQUEST>{ $SOAP_MESSAGE }</ns0:P_REQUEST>
            }
        </ns0:InputParameters>
};

declare variable $registroBitacoraConvenio as element(ns1:registroBitacoraConvenio) external;

xf:RegistrarBitacoraRequestConvenioIn($registroBitacoraConvenio)