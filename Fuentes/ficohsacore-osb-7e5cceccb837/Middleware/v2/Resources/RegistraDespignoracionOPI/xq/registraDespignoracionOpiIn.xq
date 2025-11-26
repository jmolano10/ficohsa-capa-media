(:: pragma bea:global-element-parameter parameter="$registraDespignoracionOPI" element="ns0:registraDespignoracionOPI" location="../xsd/registraDespignoracionesOPITypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKHN/despignoracionOPI/xsd/Despignoraciones_OPI_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/Despignoraciones_OPI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reistraDespignoracionOPITypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraDespignoracionOPI/xq/registraDespignoracionOpiIn/";

declare function xf:registraDespignoracionOpiIn($registraDespignoracionOPI as element(ns0:registraDespignoracionOPI))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $ACCOUNT_NUMBER in $registraDespignoracionOPI/ACCOUNT_NUMBER
                return
                    <ns1:PV_NUMEROCUENTA>{ data($ACCOUNT_NUMBER) }</ns1:PV_NUMEROCUENTA>
            }
            {
                for $DESCRIPTION in $registraDespignoracionOPI/DESCRIPTION
                return
                    <ns1:PV_DESCRIPCION>{ data($DESCRIPTION) }</ns1:PV_DESCRIPCION>
            }
            {
                for $VALUE in $registraDespignoracionOPI/VALUE
                return
                    <ns1:PN_VALOR>{ data($VALUE) }</ns1:PN_VALOR>
            }
            {
                for $STATE in $registraDespignoracionOPI/STATE
                return
                    <ns1:PV_ESTADO>{ data($STATE) }</ns1:PV_ESTADO>
            }
            {
                for $ID_REFERENCE_T24 in $registraDespignoracionOPI/ID_REFERENCE_T24
                return
                    <ns1:PV_ID_REFERENCIAT24>{ data($ID_REFERENCE_T24) }</ns1:PV_ID_REFERENCIAT24>
            }
            {
                for $NUM_MODIFICATIONS in $registraDespignoracionOPI/NUM_MODIFICATIONS
                return
                    <ns1:PN_NUM_MODIFICADOS>{ data($NUM_MODIFICATIONS) }</ns1:PN_NUM_MODIFICADOS>
            }
            {
                for $REALESE_DATE in $registraDespignoracionOPI/REALESE_DATE
                return
                    <ns1:PD_FECHA_LIBERACION>{ data($REALESE_DATE) }</ns1:PD_FECHA_LIBERACION>
            }
            {
                for $CORE_DATE in $registraDespignoracionOPI/CORE_DATE
                return
                    <ns1:PD_FECHA_CORE>{ data($CORE_DATE) }</ns1:PD_FECHA_CORE>
            }
        </ns1:InputParameters>
};

declare variable $registraDespignoracionOPI as element(ns0:registraDespignoracionOPI) external;

xf:registraDespignoracionOpiIn($registraDespignoracionOPI)