(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/ABK/consultarDeudoresCliente/xsd/consultarDeudoresCliente_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDeudoresResponse" location="../../CobranzasElectronicas/xsd/cobranzasElectronicasTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarDeudoresCliente";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cobranzasElectronicasTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/PagingTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDeudores/xq/consultaDeudoresOut/";

declare function xf:consultaDeudoresOut($outputParameters as element(ns2:OutputParameters))
    as element(ns1:consultaDeudoresResponse) {
        <ns1:consultaDeudoresResponse>
            <CUSTOMER_ID>{ data($outputParameters/ns2:PV_CODCLIENTE) }</CUSTOMER_ID>
            {
                for $PV_NUMEROCONTRATO in $outputParameters/ns2:PV_NUMEROCONTRATO
                return
                    <CONTRACT_ID>{ data($PV_NUMEROCONTRATO) }</CONTRACT_ID>
            }
            <RECORDS_INFO>
                <INITIAL_RECORD>{ data($outputParameters/ns2:PN_REGINICIAL) }</INITIAL_RECORD>
                <RECORDS_RETURNED>{ data($outputParameters/ns2:PN_CANTREGISTROS) }</RECORDS_RETURNED>
                <RECORD_TOTAL>{ data($outputParameters/ns2:PN_TOTREGISTROS) }</RECORD_TOTAL>
            </RECORDS_INFO>
            <DEBTORS>
                {
                	let $debtorCode := $outputParameters/ns2:PT_CODDEUDORES/ns2:ITEM
                	let $debtorName := $outputParameters/ns2:PT_NOMDEUDORES/ns2:ITEM
                	let $creationDate := $outputParameters/ns2:PT_FECHACREACION/ns2:ITEM
                    for $i in 1 to count($debtorCode)
                    return
                        <DEBTOR>
                            <DEBTOR_CODE>{ data($debtorCode[$i]) }</DEBTOR_CODE>
                            <DEBTOR_NAME>{ data($debtorName[$i]) }</DEBTOR_NAME>
                            { 
                            	if ($creationDate[$i] != "") then
                            		<CREATION_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime($creationDate[$i]),())}</CREATION_DATE>
                            	else
                            		""
                             }
                        </DEBTOR>
                }
            </DEBTORS>
        </ns1:consultaDeudoresResponse>
};

declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:consultaDeudoresOut($outputParameters)