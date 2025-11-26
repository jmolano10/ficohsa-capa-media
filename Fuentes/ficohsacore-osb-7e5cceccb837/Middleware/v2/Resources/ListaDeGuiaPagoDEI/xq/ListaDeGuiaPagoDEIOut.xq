(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/DEI/listaDeGuiaPago/xsd/ListaDeGuiaPago_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:listaDeGuiaPagoResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ListaDeGuiaPago";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListaDeGuiaPago/xq/ListaDeGuiaPagoOut2/";

declare function xf:ListaDeGuiaPagoOut2($outputParameters as element(ns1:OutputParameters))
    as element(ns0:listaDeGuiaPagoResponse) {
        <ns0:listaDeGuiaPagoResponse>
            {
                for $ITEMS in $outputParameters/ns1:PT_RESULTADO/ns1:ITEMS
                return
                    <PAYMENT_GUIDES>
                        {
                            for $ITEM in $ITEMS/ns1:ITEM
                            return
                                <PAYMENT_GUIDE>
                                    <PAYMENT_GUIDE_ID>{ data($ITEM/ns1:GUIAPAGO) }</PAYMENT_GUIDE_ID>
                                    <CREATION_DATE>{ data($ITEM/ns1:FECHAGENERACION) }</CREATION_DATE>
                                    <EXPIRATION_DATE>{ data($ITEM/ns1:FECHAVENCIMIENTO) }</EXPIRATION_DATE>
                                    <DEED_NUMBER>{ data($ITEM/ns1:NRODOCUMENTO) }</DEED_NUMBER>
                                    <DEED_DESC>{ data($ITEM/ns1:NRODOCUMENTODESC) }</DEED_DESC>
                                    <PERIOD>{ data($ITEM/ns1:PERIODO) }</PERIOD>
                                    <TOTAL_VALUE>{ data($ITEM/ns1:VALORTOTAL) }</TOTAL_VALUE>
                                </PAYMENT_GUIDE>
                        }
                    </PAYMENT_GUIDES>
            }
        </ns0:listaDeGuiaPagoResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:ListaDeGuiaPagoOut2($outputParameters)