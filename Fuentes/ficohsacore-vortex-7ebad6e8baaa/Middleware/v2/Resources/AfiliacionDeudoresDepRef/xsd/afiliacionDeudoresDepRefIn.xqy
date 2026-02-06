xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$agregarDeudores" element="ns0:agregarDeudores" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/ingresarDeudoresDepRef/xsd/ingresarDeudoresDepRef_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresarDeudoresDepRef";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionDeudoresDepRef/xsd/afiliacionDeudoresDepRefIn/";

declare function xf:afiliacionDeudoresDepRefIn($agregarDeudores as element(ns0:agregarDeudores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $USER_ID in $agregarDeudores/USER_ID
                return
                    <ns1:PV_USUARIOINGRESO>{ data($USER_ID) }</ns1:PV_USUARIOINGRESO>
            }
            <ns1:PV_CODIGOCLIENTE>{ data($agregarDeudores/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCUENTA>{ data($agregarDeudores/ACCOUNT_NUMBER) }</ns1:PV_NUMEROCUENTA>
            <ns1:PT_CODIGODEUDORES>
                {
                    for $DEBTOR in $agregarDeudores/DEBTORS/DEBTOR
                    return
                        <ns1:ITEM>{ data($DEBTOR/DEBTOR_CODE) }</ns1:ITEM>
                }
            </ns1:PT_CODIGODEUDORES>
            <ns1:PT_NOMBREDEUDORES>
                {
                    for $DEBTOR in $agregarDeudores/DEBTORS/DEBTOR
                    return
                        <ns1:ITEM>{ data($DEBTOR/DEBTOR_NAME) }</ns1:ITEM>
                }
            </ns1:PT_NOMBREDEUDORES>
            <ns1:PT_NUMERODOCUMENTO>
                {
                    for $DEBTOR in $agregarDeudores/DEBTORS/DEBTOR
                    return
                        <ns1:ITEM>{ data($DEBTOR/DOCUMENT_ID) }</ns1:ITEM>
                }
            </ns1:PT_NUMERODOCUMENTO>
        </ns1:InputParameters>
};

declare variable $agregarDeudores as element(ns0:agregarDeudores) external;

xf:afiliacionDeudoresDepRefIn($agregarDeudores)