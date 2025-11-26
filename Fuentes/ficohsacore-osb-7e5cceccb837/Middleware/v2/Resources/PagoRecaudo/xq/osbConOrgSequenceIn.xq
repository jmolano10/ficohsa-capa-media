(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/osbConOrgSequenceIn/";

declare function xf:osbConOrgSequenceIn($pagoRecaudo as element(ns1:pagoRecaudo),
    $string1 as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:CURRENCY>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_CURRENCY) }</ns0:CURRENCY>
            {
                for $CREDIT_CARD_NUMBER in $pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER
                return
                    <ns0:CREDIT_CARD>{ data($CREDIT_CARD_NUMBER) }</ns0:CREDIT_CARD>
            }
        </ns0:InputParameters>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $string1 as xs:string external;

xf:osbConOrgSequenceIn($pagoRecaudo,
    $string1)
