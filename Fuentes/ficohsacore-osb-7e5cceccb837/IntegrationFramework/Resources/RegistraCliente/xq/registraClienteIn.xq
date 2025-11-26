(:: pragma bea:global-element-parameter parameter="$t24NewCustomer1" element="ns0:T24NewCustomer" location="../xsd/T24FicoTSPServices2-T24NewCustomer.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/RegistraClienteTSPDB/xsd/TSP_CREA_CLIENTE_sp.xsd" ::)

declare namespace ns2 = "http://www.temenos.com/T24/event/Common/EventCommon";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TSP_CREA_CLIENTE";
declare namespace ns0 = "http://www.temenos.com/T24/event/T24FicoTSPServices2/T24NewCustomer";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/RegistraCliente/xq/registraClienteIn/";

declare function xf:registraClienteIn($t24NewCustomer1 as element(ns0:T24NewCustomer))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $id in $t24NewCustomer1/ns0:id
                return
                    <ns1:PV_ID_CLIENTE>{ data($id) }</ns1:PV_ID_CLIENTE>
            }
            {
                for $sector in $t24NewCustomer1/ns0:sector
                return
                    <ns1:PV_SECTOR>{ data($sector) }</ns1:PV_SECTOR>
            }
            {
                for $legalId in $t24NewCustomer1/ns0:legalId
                return
                    <ns1:PV_IDENTIFICACION>{ data($legalId) }</ns1:PV_IDENTIFICACION>
            }
            {
                for $legalDocName in $t24NewCustomer1/ns0:legalDocName
                return
                    <ns1:PV_TIPO_IDENTIFICACION>{ data($legalDocName) }</ns1:PV_TIPO_IDENTIFICACION>
            }
            {
                for $givenNames in $t24NewCustomer1/ns0:givenNames
                return
                    <ns1:PV_NOMBRES>{ data($givenNames) }</ns1:PV_NOMBRES>
            }
            {
                for $familyName in $t24NewCustomer1/ns0:familyName
                return
                    <ns1:PV_APELLIDOS>{ data($familyName) }</ns1:PV_APELLIDOS>
            }
            {
                for $nameOfBusiness in $t24NewCustomer1/ns0:nameOfBusiness
                return
                    <ns1:PV_NOMBRE_LEGAL>{ data($nameOfBusiness) }</ns1:PV_NOMBRE_LEGAL>
            }
            {
                for $commercialName in $t24NewCustomer1/ns0:commercialName
                return
                    <ns1:PV_NOMBRE_COMERCIAL>{ data($commercialName) }</ns1:PV_NOMBRE_COMERCIAL>
            }
        </ns1:InputParameters>
};

declare variable $t24NewCustomer1 as element(ns0:T24NewCustomer) external;

xf:registraClienteIn($t24NewCustomer1)