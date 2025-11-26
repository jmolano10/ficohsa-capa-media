(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/ABK/ingresarDeudoresDepRef/xsd/ingresarDeudoresDepRef_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:agregarDeudoresResponse" location="../../DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ingresarDeudoresDepRef";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/AfiliacionDeudoresDepRef/xsd/afiliacionDeudoresDepRefOut/";

declare function xf:afiliacionDeudoresDepRefOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:agregarDeudoresResponse) {
        <ns0:agregarDeudoresResponse>
            <CUSTOMER_ID>{ data($outputParameters/ns1:PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            <ACCOUNT_NUMBER>{ data($outputParameters/ns1:PV_NUMEROCUENTA) }</ACCOUNT_NUMBER>
            {
                for $PN_IDLOTE in $outputParameters/ns1:PN_IDLOTE
                return
                    <BANK_BATCH_ID>{ data($PN_IDLOTE) }</BANK_BATCH_ID>
            }
            <DEBTORS>
                {
                    let $DEUDORES := $outputParameters/ns1:PT_CODIGODEUDORES/ns1:ITEM
                    for $i in 1 to count($DEUDORES)
                    return
                        <DEBTOR>
                            <DEBTOR_CODE>{ data($DEUDORES[$i]) }</DEBTOR_CODE>
                            <DEBTOR_NAME>{ data($outputParameters/ns1:PT_NOMBREDEUDORES/ns1:ITEM[$i]) }</DEBTOR_NAME>
                            <DOCUMENT_ID>{ data($outputParameters/ns1:PT_NUMERODOCUMENTO/ns1:ITEM[$i]) }</DOCUMENT_ID>
                            <STATUS>{ data($outputParameters/ns1:PT_ESTADODEUDORES/ns1:ITEM[$i]) }</STATUS>
                            <MESSAGES>{ data($outputParameters/ns1:PT_MENSAJEDEUDORES/ns1:ITEM[$i]) }</MESSAGES>
                        </DEBTOR>
                }
            </DEBTORS>
        </ns0:agregarDeudoresResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:afiliacionDeudoresDepRefOut($outputParameters)