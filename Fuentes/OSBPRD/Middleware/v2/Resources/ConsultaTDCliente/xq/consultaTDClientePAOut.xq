(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ABKPA/tarjetaDebitoCliente/xsd/tarjetaDebitoCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTDClienteResponse" location="../../../../Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/tarjetaDebitoCliente";
declare namespace xf = "http://tempuri.org/Middleware/consutlaTDClientePAOut/";

declare function xf:consutlaTDClientePAOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:consultaTDClienteResponse) {
        <ns0:consultaTDClienteResponse>
            {
                for $CUSTOMER_ID in $outputParameters1/ns1:CUSTOMER_ID
                return
                    <CUSTOMER_ID>{ data($CUSTOMER_ID) }</CUSTOMER_ID>
            }
            <ns0:consultaTDClienteResponseType>
            {
           
                for $i in (1 to max( (	count($outputParameters1/ns1:CARD_NUMBER/ns1:ITEM),
                						count($outputParameters1/ns1:CARD_HOLDER_NAME/ns1:ITEM),
                						count($outputParameters1/ns1:CARD_CATEGORY/ns1:ITEM)
                						)))
                return
                    <ns0:consultaTDClienteResponseRecordType>
                        <CARD_NUMBER>{ data($outputParameters1/ns1:CARD_NUMBER/ns1:ITEM[$i]) }</CARD_NUMBER>
                        <CARD_HOLDER_NAME>{ data($outputParameters1/ns1:CARD_HOLDER_NAME/ns1:ITEM[$i]) }</CARD_HOLDER_NAME>
                        <CARD_CATEGORY>{ data($outputParameters1/ns1:CARD_CATEGORY/ns1:ITEM[$i]) }</CARD_CATEGORY>
                    </ns0:consultaTDClienteResponseRecordType>
            }
            </ns0:consultaTDClienteResponseType>
        </ns0:consultaTDClienteResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:consutlaTDClientePAOut($outputParameters1)