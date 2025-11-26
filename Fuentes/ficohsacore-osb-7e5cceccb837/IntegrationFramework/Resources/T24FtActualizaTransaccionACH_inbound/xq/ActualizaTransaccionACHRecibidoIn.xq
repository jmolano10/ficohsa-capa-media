(:: pragma bea:global-element-parameter parameter="$t24FtActualizaTransaccionACH" element="ns2:T24FtActualizaTransaccionACH" location="../xsd/T24FtActualizaTransaccionACH-T24FtActualizaTransaccionACH.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/actualizaEstadoReprocesoACH/xsd/ActualizaTransaccionACH_IF_sp.xsd" ::)

declare namespace ns0 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns2 = "http://www.temenos.com/T24/event/T24FtActualizaTransaccionACH/T24FtActualizaTransaccionACH";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ActualizaTransaccionACH_IF";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/T24FtActualizaTransaccionACH_inbound/xq/ActualizaTransaccionACHRecibidoIn/";

declare function xf:ActualizaTransaccionACHRecibidoIn($t24FtActualizaTransaccionACH as element(ns2:T24FtActualizaTransaccionACH))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $id in $t24FtActualizaTransaccionACH/ns2:id
                return
                    <ns1:PV_REF_CONTROL_T24>{ data($id) }</ns1:PV_REF_CONTROL_T24>
            }
            {
                for $customerId in $t24FtActualizaTransaccionACH/ns2:customerId
                return
                    <ns1:PV_CUSTOMER_ID>{ data($customerId) }</ns1:PV_CUSTOMER_ID>
            }
            {
                for $isLbtr in $t24FtActualizaTransaccionACH/ns2:isLbtr
                return
                    <ns1:PV_IS_LBTR>{ data($isLbtr) }</ns1:PV_IS_LBTR>
            }
            {
                for $ftTransaction in $t24FtActualizaTransaccionACH/ns2:ftTransaction
                return
                    <ns1:PV_FT_TRANSACCIONT24>{ data($ftTransaction) }</ns1:PV_FT_TRANSACCIONT24>
            }
            {
                for $status in $t24FtActualizaTransaccionACH/ns2:status
                return
                    <ns1:PV_ESTADOPROCESO>{ data($status) }</ns1:PV_ESTADOPROCESO>
            }
            {
                for $rejectionCode in $t24FtActualizaTransaccionACH/ns2:rejectionCode
                return
                    <ns1:PV_CODIGOERRORPROCESO>{ data($rejectionCode) }</ns1:PV_CODIGOERRORPROCESO>
            }
            {
                for $rejectionMessaje in $t24FtActualizaTransaccionACH/ns2:rejectionMessaje
                return
                    <ns1:PV_MENSAJEERRORPROCESO>{ data($rejectionMessaje) }</ns1:PV_MENSAJEERRORPROCESO>
            }
        </ns1:InputParameters>
};

declare variable $t24FtActualizaTransaccionACH as element(ns2:T24FtActualizaTransaccionACH) external;

xf:ActualizaTransaccionACHRecibidoIn($t24FtActualizaTransaccionACH)
