(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/DEI/consultaReciboDUA/xsd/ConsultaReciboDua_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaReciboResponse" location="../../TributosDEI/xsd/tributosTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaReciboDua";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/tributosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaReciboDEI/xq/consultaReciboDEI_DuaOut/";

declare function xf:consultaReciboDEI_DuaOut($outputParameters as element(ns0:OutputParameters),
    $TAX_TYPE as xs:string,
    $CUSTOMER_ID as xs:string,
    $USER_ID as xs:string)
    as element(ns1:consultaReciboResponse) {
        <ns1:consultaReciboResponse>
            <TAX_TYPE>{ $TAX_TYPE }</TAX_TYPE>
            {
                for $P_RECIBO in $outputParameters/ns0:P_RECIBO
                return
                    <BILL_DETAIL>{ data($P_RECIBO) }</BILL_DETAIL>
            }
            <CUSTOMER_ID>{ $CUSTOMER_ID }</CUSTOMER_ID>
            <USER_ID>{ $USER_ID }</USER_ID>
        </ns1:consultaReciboResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;
declare variable $TAX_TYPE as xs:string external;
declare variable $CUSTOMER_ID as xs:string external;
declare variable $USER_ID as xs:string external;

xf:consultaReciboDEI_DuaOut($outputParameters,
    $TAX_TYPE,
    $CUSTOMER_ID,
    $USER_ID)