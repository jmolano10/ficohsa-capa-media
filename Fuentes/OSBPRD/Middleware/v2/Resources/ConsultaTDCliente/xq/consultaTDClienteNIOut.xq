(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/Cobis/TarjetaDebitoCliente/xsd/tarjetaDebitoClienteNI_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaTDClienteResponse" location="../xsd/consultaTDClienteTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/tarjetaDebitoClienteNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaTDClienteTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTDCliente/xq/consultaTDClienteNIOut/";

declare function xf:consultaTDClienteNIOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaTDClienteResponse) {
        <ns0:consultaTDClienteResponse>
            <ns0:consultaTDClienteResponseType>
                {
                    for $Row in $outputParameters/ns1:RowSet/ns1:Row
                    return (
                        <ns0:consultaTDClienteResponseRecordType>
                        	<CARD_NUMBER>{ data($Row/ns1:Column[ @name='ta_codigo' ]/text()) }</CARD_NUMBER>
                        	<CARD_HOLDER_NAME>{ data($Row/ns1:Column[ @name='CARD_HOLDER_NAME' ]/text()) }</CARD_HOLDER_NAME>
                        	<CARD_CATEGORY>{ data($Row/ns1:Column[ @name='CARD_CATEGORY' ]/text()) }</CARD_CATEGORY>
                        	<CARD_TYPE>{ data($Row/ns1:Column[ @name='CARD_TYPE' ]/text()) }</CARD_TYPE>
                        	<ISSUE_DATE>{ data($Row/ns1:Column[ @name='ISSUE_DATE' ]/text()) }</ISSUE_DATE>
                        	<CARD_BRAND>{ data($Row/ns1:Column[ @name='CARD_BRAND' ]/text()) }</CARD_BRAND>
                        	<CARD_CURRENCY>{ data($Row/ns1:Column[ @name='mo_simbolo' ]/text()) }</CARD_CURRENCY>
                        	<CARD_ACCOUNT_NUMBER>{ data($Row/ns1:Column[ @name='em_cuenta' ]/text()) }</CARD_ACCOUNT_NUMBER>
                        </ns0:consultaTDClienteResponseRecordType>
                    )
                }
            </ns0:consultaTDClienteResponseType>
        </ns0:consultaTDClienteResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaTDClienteNIOut($outputParameters)