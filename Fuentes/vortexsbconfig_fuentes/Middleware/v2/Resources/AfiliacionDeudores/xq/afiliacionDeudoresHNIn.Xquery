<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$agregarDeudores" element="ns0:agregarDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresarDeudoresCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionDeudores/xq/afiliacionDeudoresHNIn/";

declare function xf:afiliacionDeudoresHNIn($agregarDeudores as element(ns0:agregarDeudores))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_USUARIOINGRESO>{ data($agregarDeudores/USER_ID) }</ns1:PV_USUARIOINGRESO>
            <ns1:PV_CODIGOCLIENTE>{ data($agregarDeudores/CUSTOMER_ID) }</ns1:PV_CODIGOCLIENTE>
            <ns1:PV_NUMEROCONTRATO>{ data($agregarDeudores/CONTRACT_ID) }</ns1:PV_NUMEROCONTRATO>
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
        </ns1:InputParameters>
};

declare variable $agregarDeudores as element(ns0:agregarDeudores) external;

xf:afiliacionDeudoresHNIn($agregarDeudores)]]></con:xquery>
    <con:dependency location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CobranzasElectronicas/xsd/cobranzasElectronicasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp"/>
    </con:dependency>
</con:xqueryEntry>