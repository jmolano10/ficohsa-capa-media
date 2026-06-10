<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$agregarDeudores" element="ns0:agregarDeudores" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:agregarDeudoresResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresarDeudoresCliente";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionDeudores/xq/afiliacionDeudoresHNOut/";

declare function xf:afiliacionDeudoresHNOut($outputParameters as element(ns1:OutputParameters),
    $agregarDeudores as element(ns0:agregarDeudores))
    as element(ns0:agregarDeudoresResponse) {
        <ns0:agregarDeudoresResponse>
            <CUSTOMER_ID>{ data($agregarDeudores/CUSTOMER_ID) }</CUSTOMER_ID>
            {
                for $PV_NUMEROCONTRATO in $outputParameters/ns1:PV_NUMEROCONTRATO
                return
                    <CONTRACT_ID>{ data($PV_NUMEROCONTRATO) }</CONTRACT_ID>
            }
            <BANK_BATCH_ID>{ data($outputParameters/ns1:PN_IDLOTE) }</BANK_BATCH_ID>
            <DEBTORS>
                {
                	let $DEBTOR := $agregarDeudores/DEBTORS/DEBTOR
                    for $i in 1 to count($DEBTOR)
                    return
                        <DEBTOR>
                            <DEBTOR_CODE>{ data($DEBTOR[$i]/DEBTOR_CODE) }</DEBTOR_CODE>
                            <DEBTOR_NAME>{ data($DEBTOR[$i]/DEBTOR_NAME) }</DEBTOR_NAME>
                            <STATUS>{ data($outputParameters/ns1:PT_ESTADODEUDORES/ns1:ITEM[$i]) }</STATUS>
                            <MESSAGES>{ data($outputParameters/ns1:PT_MENSAJEDEUDORES/ns1:ITEM[$i]) }</MESSAGES>
                        </DEBTOR>
                }
            </DEBTORS>
        </ns0:agregarDeudoresResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $agregarDeudores as element(ns0:agregarDeudores) external;

xf:afiliacionDeudoresHNOut($outputParameters,
    $agregarDeudores)]]></con:xquery>
    <con:dependency location="../../../BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABK/ingresarDeudoresCliente/xsd/ingresarDeudoresCliente_sp"/>
    </con:dependency>
    <con:dependency location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/CobranzasElectronicas/xsd/cobranzasElectronicasTypes"/>
    </con:dependency>
</con:xqueryEntry>