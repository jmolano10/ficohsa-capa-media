(:: pragma bea:global-element-parameter parameter="$t24NewAccount1" element="ns1:T24NewAccount" location="../xsd/T24FicoTSPServices2-T24NewAccount.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/RegistraCuentaTSPDB/xsd/TSP_CREA_CUENTA_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://www.temenos.com/T24/event/T24FicoTSPServices2/T24NewAccount";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TSP_CREA_CUENTA";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/RegistraCuenta/xq/registraCuentaln/";

declare function xf:registraCuentaln($t24NewAccount1 as element(ns1:T24NewAccount))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $id in $t24NewAccount1/ns1:id
                return
                    <ns0:PV_ID_CUENTA>{ data($id) }</ns0:PV_ID_CUENTA>
            }
            {
                for $customerId in $t24NewAccount1/ns1:customerId
                return
                    <ns0:PV_ID_CLIENTE>{ data($customerId) }</ns0:PV_ID_CLIENTE>
            }
            {
                for $category in $t24NewAccount1/ns1:category
                return
                    <ns0:PV_CATEGORIA>{ data($category) }</ns0:PV_CATEGORIA>
            }
            {
                for $shortTitle in $t24NewAccount1/ns1:shortTitle
                return
                    <ns0:PV_NOMBRE_CUENTA>{ data($shortTitle) }</ns0:PV_NOMBRE_CUENTA>
            }
            {
                for $currency in $t24NewAccount1/ns1:currency
                return
                    <ns0:PV_ID_MONEDA>{ data($currency) }</ns0:PV_ID_MONEDA>
            }
            {
                for $payrollGrp in $t24NewAccount1/ns1:payrollGrp
                return
                    <ns0:PV_ID_GRUPO_PLANILLA>{ data($payrollGrp) }</ns0:PV_ID_GRUPO_PLANILLA>
            }
        </ns0:InputParameters>
};

declare variable $t24NewAccount1 as element(ns1:T24NewAccount) external;

xf:registraCuentaln($t24NewAccount1)