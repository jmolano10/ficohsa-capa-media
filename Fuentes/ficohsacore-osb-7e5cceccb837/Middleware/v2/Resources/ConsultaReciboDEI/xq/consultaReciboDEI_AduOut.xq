(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/consultaReciboADU/xsd/ConsultaReciboAdu_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReciboResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboAdu";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_AduOut/";

declare function xf:consultaReciboDEI_AduOut($outputParameters as element(ns0:OutputParameters),
    $TAX_TYPE as xs:string,
    $USER_ID as xs:string)
    as element(ns1:consultaReciboResponse) {
        <ns1:consultaReciboResponse>
            <TAX_TYPE>{ $TAX_TYPE }</TAX_TYPE>
            {
                for $PC_RECIBO in $outputParameters/ns0:PC_RECIBO
                return
                    <BILL_DETAIL>{ data($PC_RECIBO) }</BILL_DETAIL>
            }
            {
                for $PV_CODIGODEUDOR in $outputParameters/ns0:PV_CODIGODEUDOR
                return
                    <CUSTOMER_ID>{ data($PV_CODIGODEUDOR) }</CUSTOMER_ID>
            }
            <USER_ID>{ $USER_ID }</USER_ID>
        </ns1:consultaReciboResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $TAX_TYPE as xs:string external;
declare variable $USER_ID as xs:string external;

xf:consultaReciboDEI_AduOut($outputParameters,
    $TAX_TYPE,
    $USER_ID)